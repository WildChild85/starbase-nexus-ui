<template>
<div class="home">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <Panel>
            <div class="flex flex--end flex--wrap">
                <TextField v-model.trim="searchTerm" :placeholder="$t('search')" @keyup.enter="refreshData"/>
                <Button class="margin-left" :loading="isLoading" @click="refreshData">Refresh</Button>
                <Button class="margin-left" type="info" :to="{name: 'yolol_yolol-project_create'}">Create</Button>
            </div>

            <div class="yolol-project-list">
                <YololProjectListItem
                    v-for="yololProject in yololProjects"
                    :key="yololProject.id"
                    :yololProject="yololProject"
                    :creator="publicUsers.find(({ id }) => id === yololProject.creatorId)"
                    class="margin-top--f2"
                >
                </YololProjectListItem>
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
import * as yololProjectService from '@/services/yolol/yololProjectService';
import { YololProject } from '@/interfaces/yolol/yololProject';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import YololProjectListItem from '@/components/yolol/yololProject/YololProjectListItem.vue';
import * as publicUserService from '@/services/social/publicUserService';
import { PublicUser } from '@/interfaces/social/publicUser';

interface Data {
    searchTerm: string;
    isLoading: boolean;
    yololProjects: YololProject[];
    publicUsers: PublicUser[];
}

export default defineComponent({
    name: 'YololProjects',
    components: {
        Button,
        Panel,
        TextField,
        LoadingIndicatorBeam,
        YololProjectListItem,
    },
    mixins: [ViewMixin],
    data: (): Data => ({
        searchTerm: '',
        isLoading: false,
        yololProjects: [],
        publicUsers: [],
    }),
    computed: {
        creatorIds(): string[] {
            return [...new Set(this.yololProjects.map(({ creatorId }) => creatorId))];
        },
    },
    methods: {
        async refreshData(): Promise<void> {
            await this.loadYololProjects();
            await this.loadPublicUsers();
        },
        async loadYololProjects(): Promise<void> {
            this.isLoading = true;
            try {
                const response = await yololProjectService.getMultiple({
                    pageSize: -1,
                    searchQuery: this.searchTerm,
                });
                this.yololProjects = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadPublicUsers(): Promise<void> {
            if (!this.creatorIds.length) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await publicUserService.getMultipleByIds(this.creatorIds);
                this.publicUsers = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('yololProjects'), this.$t('yolol')]);
        this.refreshData();
    },
});
</script>
