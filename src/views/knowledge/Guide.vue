<template>
<div class="guide">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <div class="flex flex--stretch-vertical flex--space-between-children flex--wrap-lg">
            <Panel class="flex__item flex__item--w-50-lg">
                <EditGuide
                    v-if="showEdit || !guideId"
                    :guideId="guideId"
                    ref="editGuide"
                    @created="handleCreated"
                    @patched="handlePatched"
                    @cancelled="handleCancelled"
                    @update:bodytext="handleUpdateBodytext"
                />
                <template v-else>
                    <div class="guide__header">
                        <h1 class="guide__name">{{ guide ? guide.title : '' }}</h1>
                        <Button :title="$t('back')" class="margin-right--f2" :to="{name: 'knowledge_guides'}"><ChevronLeftIconSolid class="svg-icon"/></Button>
                        <Button v-if="hasEditRights" :title="$t('edit')" @click="showEdit = true"><PencilAltIconSolid class="svg-icon"/></Button>
                        <template v-else>
                            <Button type="info" v-if="!user" :title="$t('loginToLike')" @click="redirectToDiscord"><HeartIconOutline class="svg-icon"/></Button>
                            <Button type="info" v-else-if="currentUserLike" :title="$t('unlike')" @click="unlike(currentUserLike.id)"><HeartIconSolid class="svg-icon"/></Button>
                            <Button type="info" v-else :title="$t('like')" @click="like"><HeartIconOutline class="svg-icon"/></Button>
                        </template>
                    </div>
                    <div class="guide__meta">
                        <div class="guide__creator" v-if="creator">
                            <span class="margin-right">by</span>
                            <PublicUserBadge :user="creator" />
                        </div>
                        <div class="guide__likes">
                            <HeartIconSolid class="svg-icon margin-right--f2 text--error"/> {{ likes.length }}
                        </div>
                    </div>
                    <div class="guide__bodytext">
                        <Markdown
                            v-if="guide && guide.bodytext"
                            :source="guide.bodytext"
                            :plugins="markdownPlugins"
                        />
                    </div>
                </template>
            </Panel>
            <Panel class="flex__item flex__item--w-50-lg">
                <div v-if="!guideId || showEdit">
                    <h2 class="text--primary">Rules for creating a guide</h2>
                    <ol>
                        <li>First of all: Thank you for sharing your knowledge.</li>
                        <li>You don't have to provide a bodytext and a youtube video. One of them is enough.</li>
                        <li>You don't have to be the creator of the youtube video.</li>
                        <li>Put only stuff here, that can be considered as a guide. A whole let's play video or a recorded stream is not a guide, even if something is explained there. Try to use the clip feature to only use the part that explains what should be considered in this guide.</li>
                        <li>The bodytext supports markdown (<a href="https://en.wikipedia.org/wiki/Markdown" target="_blank">Wikipedia</a>).</li>
                    </ol>
                    <div class="guide__bodytext" style="margin-top: 35px">
                        <h2>{{ $t('bodytext') }} ({{ $t('preview') }})</h2>
                        <Markdown
                            :source="editBodytext"
                            :plugins="markdownPlugins"
                        />
                    </div>
                </div>
                <div
                    v-else
                    class="guide__youtube-video"
                    data-augmented-ui="tl-clip t-clip-x tr-clip r-clip-y br-clip b-clip-x bl-clip l-clip-y border"
                >
                    <YouTube
                        v-if="guide && guide.youtubeVideoUri"
                        :src="guide.youtubeVideoUri"
                        ref="youtube"
                    />
                </div>
            </Panel>
        </div>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
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
import YouTube from 'vue3-youtube';

import Panel from '@/components/layout/Panel.vue';
import ViewMixin from '@/mixins/ViewMixin';
import * as guideService from '@/services/knowledge/guideService';
import * as publicUserService from '@/services/social/publicUserService';
import { Guide } from '@/interfaces/knowledge/guide';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import EditGuide from '@/components/knowledge/guide/EditGuide.vue';
import PublicUserBadge from '@/components/social/user/PublicUserBadge.vue';
import 'highlight.js';
import 'highlight.js/styles/monokai.css';
import { JwtUser } from '@/interfaces/identity/user';
import Button from '@/components/controls/Button';
import { PublicUser } from '@/interfaces/social/publicUser';
import * as likeService from '@/services/social/likeService';
import { Like } from '@/interfaces/social/like';
import { redirectToDiscord } from '../../helpers/index';

interface Data {
    isLoading: boolean;
    guide: Guide | null;
    creator: PublicUser | null;
    showEdit: boolean;
    editBodytext: string;
    likes: Like[];
}

export default defineComponent({
    name: 'Guide',
    components: {
        Button,
        EditGuide,
        LoadingIndicatorBeam,
        Markdown,
        Panel,
        PublicUserBadge,
        YouTube,
    },
    mixins: [ViewMixin],
    props: {
        guideId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        isLoading: false,
        guide: null,
        creator: null,
        showEdit: false,
        editBodytext: '',
        likes: [],
    }),
    watch: {
        guideId(): void {
            this.refreshData();
        },
    },
    computed: {
        hasEditRights(): boolean | null {
            return this.user && this.guide && this.user.id === this.guide.creatorId;
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
    },
    methods: {
        redirectToDiscord,
        handleUpdateBodytext(bodytext: string): void {
            this.editBodytext = bodytext;
        },
        handleCreated(guide: Guide): void {
            this.$router.push({
                name: 'knowledge_guide',
                params: {
                    guideId: guide.id,
                },
            });
        },
        handlePatched(): void {
            this.showEdit = false;
            this.refreshData();
        },
        handleCancelled(): void {
            this.showEdit = false;
            if (!this.guideId) {
                this.$router.push({ name: 'knowledge_guides' });
            }
        },
        async refreshData(): Promise<void> {
            this.guide = null;
            this.creator = null;
            this.likes = [];
            await this.loadGuide();
            await this.loadCreator();
            await this.loadLikes();
        },
        async loadGuide(): Promise<void> {
            if (!this.guideId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await guideService.getOneOrDefault(this.guideId);
                this.guide = response.data;
                this.setPageTitle([this.guide.title, this.$t('guide'), this.$t('knowledge')]);
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadCreator(): Promise<void> {
            if (!this.guide) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await publicUserService.getOneOrDefault(this.guide.creatorId);
                this.creator = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadLikes(): Promise<void> {
            if (!this.guideId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await likeService.getMultiple({
                    guideIds: this.guideId,
                    pageSize: -1,
                });
                this.likes = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async like(): Promise<void> {
            if (!this.guideId) {
                return;
            }
            this.isLoading = true;
            try {
                await likeService.create({
                    guideId: this.guideId,
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
            if (!this.guideId) {
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
        this.setPageTitle([this.$t('guide'), this.$t('knowledge')]);
        this.refreshData();
    },
});
</script>
