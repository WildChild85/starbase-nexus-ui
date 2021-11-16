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
                    @update:documentation="handleUpdateDocumentation"
                />
                <template v-else>
                    <div class="yolol-project__header">
                        <div
                            class="yolol-project__preview-image"
                            data-augmented-ui="tl-clip t-clip-x tr-clip r-clip-y br-clip b-clip-x bl-clip l-clip-y border"
                            :style="previewImageStyle"
                        ></div>
                        <div class="yolol-project__meta">
                            <h1>{{ yololProject ? yololProject.name : '' }}</h1>
                            <p v-if="creator">{{ $t('by')}} <span class="text--title text--primary">{{ creator.userName }}</span></p>
                            <p class="margin-top--no" v-if="yololProject">{{ $t('lastUpdate')}}: <span class="text--primary"><DateTimeFormatter :isoString="yololProject.updatedAt ? yololProject.updatedAt : yololProject.createdAt" /></span></p>
                            <div class="flex"><HeartIconSolid class="svg-icon text--error margin-right--f2"/> {{ likes.length }}</div>
                        </div>
                        <Button :title="$t('back')" :to="{name: 'yolol_yolol-projects'}"><ChevronLeftIconSolid class="svg-icon"/></Button>
                        <Button class="margin-left--f2" v-if="hasEditRights" :title="$t('edit')" @click="showEdit = true"><PencilAltIconSolid class="svg-icon"/></Button>
                        <template v-if="!isCreator">
                            <div class="yolol-project__actions" :class="{ 'margin-left--f2': !isCreator && isAdmin }">
                                <Button type="info" v-if="!user" :title="$t('loginToLike')" @click="redirectToDiscord"><HeartIconOutline class="svg-icon"/></Button>
                                <Button type="info" v-else-if="currentUserLike" :title="$t('unlike')" @click="unlike(currentUserLike.id)"><HeartIconSolid class="svg-icon"/></Button>
                                <Button type="info" v-else :title="$t('like')" @click="like"><HeartIconOutline class="svg-icon"/></Button>
                            </div>
                        </template>
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
                    <FetchConfigCheck
                        v-if="yololProject && yololProject.fetchConfigUri"
                        :fetchConfigUri="yololProject.fetchConfigUri"
                        :onlyErrors="true"
                    />
                    <div class="yolol-project__documentation">
                        <Markdown
                            v-if="documentation"
                            :source="documentation"
                            :plugins="markdownPlugins"
                        />
                    </div>
                </template>
            </Panel>
            <Panel class="flex__item flex__item--w-50-lg">
                <div v-if="!yololProjectId || showEdit">
                    <h2 class="text--primary">Creating a project manually</h2>
                    <p><strong>If you don't manage your code in an external git repository</strong>, you can add your yolol project here manually by adding and managing the documentation and each yolol script (after saving) here. You will have to apply future changes and updates to your project here also.</p>
                    <ol>
                        <li>If you post a project that contains the code from somebody else, please <strong>credit the author</strong>.</li>
                        <li>After creating the project, you can add as much <strong>yolol scripts</strong> as you want, if your project includes multiple scripts</li>
                        <li>If your code is at an <strong>external git repository</strong>, you can <strong>link the repository</strong> in the description.</li>
                        <li>The description supports markdown (<a href="https://en.wikipedia.org/wiki/Markdown" target="_blank">Wikipedia</a>).</li>
                        <li>We recommend you to setup a <strong>preview image</strong> for the project, so it looks nicer in the list view.</li>
                        <li>You an addionally add a url to a <strong>youtube video</strong>, that shows your project in action.</li>
                    </ol>
                    <h2 class="text--primary">Creating a project automatically</h2>
                    <p><strong>If you manage your code in an external git repository</strong>, you can configure your project, so it fetches the latest code and documentation automatically by providing a <strong>fetch config uri</strong>. So you register your project here one time and the rest is done for you.</p>
                    <ol>
                        <li>If you post a project that contains the code from somebody else, please <strong>credit the author</strong>.</li>
                        <li>Create a <strong>fetch-config.json</strong> (the name doesn't matter, just has to be a json file).</li>
                        <li>Each fetch config needs a <strong>docs</strong> property with the <strong>uri to the md (markdown) file</strong>, that contains the documentation for the script</li>
                        <li>and a <strong>scripts</strong> property that contains an <strong>array</strong> of scripts.</li>
                        <li>Each script can have a <strong>name</strong> property that should make the purpose of the script, This propery is not required</li>
                        <li>and a <strong>uri</strong> property, <strong>which is required</strong>, that contains the uri to the script file in your git repository.</li>
                        <li><strong>IMPORTANT:</strong> The uri of the documentation and the scripts has to be the <strong>raw uri</strong>, not the link to the github page. <strong>Click on the raw button to get the raw uri</strong>.</li>
                        <li>We recommend you to setup a <strong>preview image</strong> for the project, so it looks nicer in the list view.</li>
                        <li>You an addionally add a url to a <strong>youtube video</strong>, that shows your project in action.</li>
                    </ol>
                    <h2>{{ $t('exampleFetchConfig') }}</h2>
                    <div class="yolol-script__code" data-augmented-ui="tl-clip-inset t-clip-x tr-clip r-clip-y br-clip-inset b-clip-x bl-clip l-clip-y border"><pre>{{ exampleFetchConfig }}</pre></div>
                    <div class="yolol-project__documentation">
                        <h2>{{ $t('documentation') }} ({{ $t('preview') }})</h2>
                        <Markdown
                            :source="editDocumentation"
                            :plugins="markdownPlugins"
                        />
                    </div>
                </div>
                <div v-else>
                    <div class="flex flex--end">
                        <Button type="info" v-if="hasEditRights && yololProject && !yololProject.fetchConfigUri" @click="showCreateYololScript = true">{{ $t('createYololScript')}}</Button>
                    </div>
                    <EditYololScript
                        v-if="showCreateYololScript"
                        :yololProjectId="yololProjectId"
                        @cancelled="showCreateYololScript = false"
                        @created="handleScriptCreated"
                    />
                    <YololScript
                        class="margin-top"
                        v-for="yololScript in scripts"
                        :editRights="hasEditRights && yololProject && !yololProject.fetchConfigUri"
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
import * as likeService from '@/services/social/likeService';
import { YololProject, FetchedYololProject } from '@/interfaces/yolol/yololProject';
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
import { Like } from '@/interfaces/social/like';
import { redirectToDiscord, uniqueId } from '@/helpers/index';
import { EXAMPLE_FETCH_CONFIG } from '@/constants/ingame';
import FetchConfigCheck from '@/components/yolol/yololProject/FetchConfigCheck.vue';

interface Data {
    searchTerm: string;
    isLoading: boolean;
    yololProject: YololProject | null;
    fetchedYololProject: FetchedYololProject | null;
    showEdit: boolean;
    creator: PublicUser | null;
    yololScripts: YololScript[];
    showCreateYololScript: boolean;
    likes: Like[];
    editDocumentation: string;
}

export default defineComponent({
    name: 'YololProject',
    components: {
        Button,
        DateTimeFormatter,
        EditYololProject,
        EditYololScript,
        FetchConfigCheck,
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
        fetchedYololProject: null,
        showEdit: false,
        creator: null,
        yololScripts: [],
        showCreateYololScript: false,
        likes: [],
        editDocumentation: '',
    }),
    watch: {
        yololProjectId(): void {
            this.refreshData();
        },
    },
    computed: {
        exampleFetchConfig(): string {
            return EXAMPLE_FETCH_CONFIG;
        },
        isAdmin(): boolean {
            return this.$store.getters['authentication/hasOneRoles']([]);
        },
        isCreator(): boolean | null {
            return this.user && this.yololProject && this.user.id === this.yololProject.creatorId;
        },
        hasEditRights(): boolean | null {
            if (this.user && this.yololProject) {
                if (this.user.id === this.yololProject.creatorId) return true;
                if (this.isAdmin) return true;
            }
            return false;
        },
        user(): JwtUser | null {
            return this.$store.getters['authentication/user'];
        },
        currentUserLike(): Like | undefined {
            if (this.user) {
                return this.likes.find(({ userId }) => this.user && this.user.id === userId);
            }
            return undefined;
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
        documentation(): string | null {
            if (this.fetchedYololProject) {
                return this.fetchedYololProject.documentation;
            }
            if (this.yololProject) {
                return this.yololProject.documentation;
            }
            return null;
        },
        scripts(): YololScript[] {
            if (this.fetchedYololProject) {
                return this.fetchedYololProject.scripts.map((script) => ({
                    id: uniqueId(),
                    code: script.code,
                    name: script.name,
                    projectId: this.yololProjectId,
                    createdAt: '',
                    updatedAt: null,
                }));
            }
            return this.yololScripts;
        },
    },
    methods: {
        redirectToDiscord,
        handleUpdateDocumentation(documentation: string): void {
            this.editDocumentation = documentation;
        },
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
            if (!this.yololProjectId) {
                this.$router.push({ name: 'yolol_yolol-projects' });
            }
        },
        async refreshData(): Promise<void> {
            this.yololProject = null as YololProject | null;
            this.creator = null;
            this.yololScripts = [];
            this.likes = [];
            this.fetchedYololProject = null;
            await this.loadYololProject();
            await this.loadCreator();
            if (this.yololProject && this.yololProject.fetchConfigUri) {
                await this.loadFetchedYololProject();
            } else {
                await this.loadYololScripts();
            }
            await this.loadLikes();
        },
        async loadYololProject(): Promise<void> {
            if (!this.yololProjectId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await yololProjectService.getOneOrDefault(this.yololProjectId);
                this.yololProject = response.data;
                this.setPageTitle([this.yololProject.name, this.$t('yololLibrary'), this.$t('yolol')]);
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
        async loadFetchedYololProject(): Promise<void> {
            if (!this.yololProject || !this.yololProject.fetchConfigUri) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await yololProjectService.loadByFetchConfig(this.yololProjectId);
                this.fetchedYololProject = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadLikes(): Promise<void> {
            if (!this.yololProjectId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await likeService.getMultiple({
                    yololProjectIds: this.yololProjectId,
                    pageSize: -1,
                });
                this.likes = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async like(): Promise<void> {
            if (!this.yololProjectId) {
                return;
            }
            this.isLoading = true;
            try {
                await likeService.create({
                    yololProjectId: this.yololProjectId,
                });
                this.$notify({
                    type: 'success',
                    title: this.$t('thankYou'),
                });
            } catch (_) {
                this.$notify({
                    type: 'error',
                    title: this.$t('likingFailed'),
                });
            }
            this.isLoading = false;
            this.loadLikes();
        },
        async unlike(id: string): Promise<void> {
            if (!this.yololProjectId) {
                return;
            }
            this.isLoading = true;
            try {
                await likeService.deleteSingle(id);
                this.$notify({
                    type: 'success',
                    title: this.$t('thatsSad'),
                });
            } catch (_) {
                this.$notify({
                    type: 'error',
                    title: this.$t('unlikingFailed'),
                });
            }
            this.isLoading = false;
            this.loadLikes();
        },
    },
    created(): void {
        this.setPageTitle([this.$t('yololLibrary'), this.$t('yolol')]);
        this.refreshData();
    },
});
</script>
