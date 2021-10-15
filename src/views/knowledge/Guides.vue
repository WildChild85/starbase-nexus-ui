<template>
<div class="guides">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <Panel>
            <div class="flex flex--end flex--wrap flex--center-vertical">
                <div class="margin-right--f2"><strong class="text--primary">You can post your own guides.</strong> Sign in and click on create to share your knowledge.</div>
                <div class="flex__item flex__item--grow"></div>
                <TextField v-model.trim="searchTerm" :placeholder="$t('search')" @keyup.enter="refreshData"/>
                <Button class="margin-left" :loading="isLoading" @click="refreshData">Refresh</Button>
                <Button class="margin-left" v-if="user" type="info" @click="gotoCreate">Create</Button>
                <Button class="margin-left" v-else type="info" @click="redirectToDiscord">Create</Button>
            </div>

            <div class="guide-list">
                <DataItem v-for="guide in guides" :key="guide.id" class="margin-top--f2" :clickable="true" @click="gotoGuide(guide.id)">
                    <div class="data-item__name">{{ guide.title }}</div>

                    <div class="data-item__spacer"></div>

                    <div class="data-item__property" :title="$t('likes')"><HeartIconSolid class="svg-icon margin-right--f2 text--error"/> {{ guideLikes[guide.id] }}</div>
                    <div class="data-item__property" v-if="guide.bodytext" :title="$t('hasBodytext')"><DocumentTextIconOutline class="svg-icon"/></div>
                    <div class="data-item__property" v-if="guide.youtubeVideoUri" :title="$t('hasYoutubeVideo')"><PlayIconSolid class="svg-icon"/></div>
                    <div class="data-item__property" v-if="creators[guide.creatorId]"><PublicUserBadge :user="creators[guide.creatorId]" /></div>

                    <div class="data-item__action" :title="$t('edit')"><ChevronRightIconSolid class="svg-icon"/></div>
                </DataItem>
            </div>
        </Panel>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Panel from '@/components/layout/Panel.vue';
import ViewMixin from '@/mixins/ViewMixin';
import TextField from '@/components/controls/TextField.vue';
import Button from '@/components/controls/Button';
import * as guideService from '@/services/knowledge/guideService';
import { Guide } from '@/interfaces/knowledge/guide';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import { redirectToDiscord } from '@/helpers/index';
import { JwtUser } from '@/interfaces/identity/user';
import DataItem from '@/components/layout/DataItem.vue';
import { ROLE_ADMINISTRATOR } from '@/constants/roles';
import * as publicUserService from '@/services/social/publicUserService';
import { PublicUser } from '@/interfaces/social/publicUser';
import PublicUserBadge from '@/components/social/user/PublicUserBadge.vue';
import { Like } from '@/interfaces/social/like';
import * as likeService from '@/services/social/likeService';

interface Data {
    searchTerm: string;
    isLoading: boolean;
    guides: Guide[];
    creators: Record<string, PublicUser>;
    likes: Like[];
}

export default defineComponent({
    name: 'Guides',
    components: {
        Button,
        Panel,
        TextField,
        LoadingIndicatorBeam,
        DataItem,
        PublicUserBadge,
    },
    mixins: [ViewMixin],
    data: (): Data => ({
        searchTerm: '',
        isLoading: false,
        guides: [],
        creators: {},
        likes: [],
    }),
    computed: {
        user(): JwtUser | null {
            return this.$store.getters['authentication/user'];
        },
        isAdmin(): boolean {
            return this.$store.getters['authentication/hasOneRoles']([ROLE_ADMINISTRATOR]);
        },
        guideLikes(): Record<string, number> {
            const guideLikes: Record<string, number> = {};
            this.guides.forEach(({ id }) => {
                guideLikes[id] = this.likes.filter(({ guideId }) => guideId === id).length;
            });

            return guideLikes;
        },
    },
    methods: {
        redirectToDiscord,
        gotoCreate(): void {
            if (!this.user) {
                this.redirectToDiscord();
            } else {
                this.$router.push({ name: 'knowledge_guide_create' });
            }
        },
        gotoGuide(id: string): void {
            this.$router.push({
                name: 'knowledge_guide',
                params: {
                    guideId: id,
                },
            });
        },
        async refreshData(): Promise<void> {
            await this.loadGuides();
            await this.loadCreators();
            await this.loadLikes();
        },
        async loadGuides(): Promise<void> {
            this.isLoading = true;
            try {
                const response = await guideService.getMultiple({
                    pageSize: -1,
                    searchQuery: this.searchTerm,
                });
                this.guides = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadCreators(): Promise<void> {
            const creatorIds = [...new Set(this.guides.map(({ creatorId }) => creatorId))];
            if (!creatorIds.length) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await publicUserService.getMultipleByIds(creatorIds);
                this.creators = {};
                response.data.forEach((creator) => {
                    this.creators[creator.id] = creator;
                });
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadLikes(): Promise<void> {
            const guideIds = [...new Set(this.guides.map(({ id }) => id))];
            if (!guideIds.length) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await likeService.getMultiple({
                    guideIds: guideIds.join(','),
                    pageSize: -1,
                });
                this.likes = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('guides'), this.$t('knowledge')]);
        this.refreshData();
    },
});
</script>
