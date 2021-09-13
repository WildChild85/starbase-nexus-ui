<template>
<div class="yolol-project">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <div class="flex flex--stretch-vertical flex--space-between-children flex--wrap-lg">
            <Panel class="flex__item flex__item--w-50-lg">
                <EditYololProject
                    v-if="showEdit || !yololProjectId"
                    :yololProjectId="yololProjectId"
                    ref="editYololProject"
                    @created="handleCreated"
                    @patched="handlePatched"
                    @cancelled="handleCancelled"
                />
                <template v-else>
                    <div class="yolol-project__header">
                        <div
                            class="yolol-project__preview-image"
                            data-augmented-ui="tl-clip t-clip-x tr-clip r-clip-y br-clip b-clip-x bl-clip l-clip-y border"
                            :style="previewImageStyle"
                        ></div>
                        <div class="yolol-project__name">
                            <h1>{{ yololProject ? yololProject.name : '' }}</h1>
                            <p v-if="creator">{{ $t('by')}} <span class="text--title text--primary">{{ creator.userName }}</span></p>
                            <p class="margin-top--no" v-if="yololProject">{{ $t('lastUpdate')}}: <span class="text--primary"><DateTimeFormatter :isoString="yololProject.updatedAt ? yololProject.updatedAt : yololProject.createdAt" /></span></p>
                        </div>
                        <Button v-if="hasEditRights" @click="showEdit = true"><PencilAltIconSolid class="svg-icon"/></Button>
                    </div>
                    <div
                        class="yolol-project__youtube-video"
                        data-augmented-ui="tl-clip t-clip-x tr-clip r-clip-y br-clip b-clip-x bl-clip l-clip-y border"
                        v-if="yololProject && yololProject.youtubeVideoUri"
                    >
                        <YouTube
                            :src="yololProject.youtubeVideoUri"
                            ref="youtube"
                        />
                    </div>
                    <div class="yolol-project__documentation">
                        <Markdown
                            v-if="yololProject"
                            :source="yololProject.documentation"
                            :plugins="markdownPlugins"
                        />
                    </div>
                </template>
            </Panel>
            <Panel class="flex__item flex__item--w-50-lg">
                <div v-if="!yololProjectId || showEdit">
                    <h2 class="text--primary">Guidelines for creating a project</h2>
                    <ol>
                        <li>If you post a project that contains the code from somebody else, please <span class="text--primary">credit the author</span>.</li>
                        <li>After creating the project, you can add as much <span class="text--primary">yolol scripts</span> as you want, if your project includes multiple scripts</li>
                        <li>If your code is at a external git repository, you can <span class="text--primary">link the repository</span> in the description.</li>
                        <li>The description supports markdown (<a href="https://en.wikipedia.org/wiki/Markdown" target="_blank">Wikipedia</a>).</li>
                        <li>We recommend you to setup a <span class="text--primary">preview image</span> for the project, so it looks nicer in the list view.</li>
                        <li>You an addionally add a url to a <span class="text--primary">youtube video</span>, that shows your project in action.</li>
                    </ol>
                </div>
                <div v-else>
                    <div class="flex flex--end">
                        <Button v-if="hasEditRights" @click="showCreateYololScript = true">{{ $t('createYololScript')}}</Button>
                    </div>
                    <EditYololScript
                        v-if="showCreateYololScript"
                        :yololProjectId="yololProjectId"
                        @cancelled="showCreateYololScript = false"
                        @created="handleScriptCreated"
                    />
                    <YololScript
                        class="margin-top"
                        v-for="yololScript in yololScripts"
                        :editRights="hasEditRights"
                        :key="yololScript.id"
                        :yololScript="yololScript"
                        @patched="loadYololScripts()"
                    />
                </div>
            </Panel>
        </div>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import YouTube from 'vue3-youtube';
import Markdown from 'vue3-markdown-it';
import MarkdownAbbr from 'markdown-it-abbr';
import MarkdownAnchor from 'markdown-it-anchor';
import MarkdownDeflist from 'markdown-it-deflist';
import MarkdownEmoji from 'markdown-it-emoji';
import MarkdownFootnote from 'markdown-it-footnote';
import MarkdownHighlightJs from 'markdown-it-highlightjs';
import MarkdownIns from 'markdown-it-ins';
import MarkdownMark from 'markdown-it-mark';
import MarkdownSub from 'markdown-it-sub';
import MarkdownSup from 'markdown-it-sup';
import MarkdownTaskLists from 'markdown-it-task-list';
import MarkdownTocDoneRight from 'markdown-it-toc-done-right';

import Panel from '@/components/layout/Panel.vue';
import ViewMixin from '@/mixins/ViewMixin';
import * as yololProjectService from '@/services/yolol/yololProjectService';
import * as yololScriptService from '@/services/yolol/yololScriptService';
import * as publicUserService from '@/services/social/publicUserService';
import { YololProject } from '@/interfaces/yolol/yololProject';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import EditYololProject from '@/components/yolol/yololProject/EditYololProject.vue';
import EditYololScript from '@/components/yolol/yololScript/EditYololScript.vue';
import YololScriptComponent from '@/components/yolol/yololScript/YololScript.vue';
import 'highlight.js';
import 'highlight.js/styles/monokai.css';
import { JwtUser } from '@/interfaces/identity/user';
import Button from '@/components/controls/Button';
import { PublicUser } from '@/interfaces/social/publicUser';
import { YololScript } from '@/interfaces/yolol/yololScript';
import DateTimeFormatter from '@/components/formatters/DateTimeFormatter.vue';

interface Data {
    searchTerm: string;
    isLoading: boolean;
    yololProject: YololProject | null;
    showEdit: boolean;
    creator: PublicUser | null;
    yololScripts: YololScript[];
    showCreateYololScript: boolean;
}

export default defineComponent({
    name: 'YololProject',
    components: {
        Button,
        DateTimeFormatter,
        EditYololProject,
        EditYololScript,
        YololScript: YololScriptComponent,
        Markdown,
        Panel,
        LoadingIndicatorBeam,
        YouTube,
    },
    mixins: [ViewMixin],
    props: {
        yololProjectId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        searchTerm: '',
        isLoading: false,
        yololProject: null,
        showEdit: false,
        creator: null,
        yololScripts: [],
        showCreateYololScript: false,
    }),
    watch: {
        yololProjectId(): void {
            this.yololProject = null;
            this.creator = null;
            this.yololScripts = [];
            this.refreshData();
        },
    },
    computed: {
        hasEditRights(): boolean | null {
            return this.user && this.yololProject && this.user.id === this.yololProject.creatorId;
        },
        user(): JwtUser | null {
            return this.$store.getters['authentication/user'];
        },
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        markdownPlugins(): Record<string, any>[] {
            return [
                { plugin: MarkdownAbbr },
                { plugin: MarkdownAnchor },
                { plugin: MarkdownDeflist },
                { plugin: MarkdownEmoji },
                { plugin: MarkdownFootnote },
                { plugin: MarkdownHighlightJs },
                { plugin: MarkdownMark },
                { plugin: MarkdownIns },
                { plugin: MarkdownSub },
                { plugin: MarkdownSup },
                { plugin: MarkdownTaskLists },
                { plugin: MarkdownTocDoneRight },
            ];
        },
        previewImageStyle(): Record<string, string> {
            return {
                backgroundImage: this.yololProject && this.yololProject.previewImageUri ? `url('${this.yololProject.previewImageUri}')` : '',
            };
        },
        editFormDocumentation(): string | null {
            if (this.$refs.editYololProject) {
                // eslint-disable-next-line @typescript-eslint/no-explicit-any
                return (this.$refs.editYololProject as any).data.properties.documentation as string | null;
            }
            return null;
        },
    },
    methods: {
        handleScriptCreated(): void {
            this.showCreateYololScript = false;
            this.loadYololScripts();
        },
        handleCreated(yololProject: YololProject): void {
            this.$router.push({
                name: 'yolol_yolol-project',
                params: {
                    yololProjectId: yololProject.id,
                },
            });
        },
        handlePatched(): void {
            this.showEdit = false;
            this.refreshData();
        },
        handleCancelled(): void {
            this.showEdit = false;
        },
        async refreshData(): Promise<void> {
            await this.loadYololProject();
            await this.loadCreator();
            await this.loadYololScripts();
        },
        async loadYololProject(): Promise<void> {
            if (!this.yololProjectId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await yololProjectService.getOneOrDefault(this.yololProjectId);
                this.yololProject = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadCreator(): Promise<void> {
            if (!this.yololProject) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await publicUserService.getOneOrDefault(this.yololProject.creatorId);
                this.creator = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadYololScripts(): Promise<void> {
            if (!this.yololProjectId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await yololScriptService.getMultiple({
                    projectIds: this.yololProjectId,
                    pageSize: -1,
                });
                this.yololScripts = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('yololLibrary'), this.$t('yolol')]);
        this.refreshData();
    },
});
</script>
