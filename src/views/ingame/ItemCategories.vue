<template>
<div class="home">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <Panel>
            <div class="flex flex--end flex--wrap">
                <TextField v-model.trim="searchTerm" :placeholder="$t('search')" @keyup.enter="refreshData"/>
                <Button class="margin-left" :loading="isLoading" @click="refreshData">Refresh</Button>
                <Button class="margin-left" v-if="isModerator" @click="showCreate">Create</Button>
            </div>

            <DataItem v-for="itemCategory in itemCategories" :key="itemCategory.id" class="margin-top--f2">
                <div class="data-item__name">{{ itemCategory.name }}</div>
                <div class="data-item__spacer"></div>
                <div class="data-item__action" v-if="isModerator" @click="showEdit(itemCategory.id)"><PencilIconSolid class="svg-icon"/></div>
            </DataItem>
        </Panel>
    </div>
    <Dialog v-if="showEditDialog" @close="hideEditDialog">
        <EditItemCategory
            :itemCategoryId="editId"
            @created="hideEditDialog(true)"
            @patched="hideEditDialog(true)"
            @cancelled="hideEditDialog"
        />
    </Dialog>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Panel from '@/components/layout/Panel.vue';
import ViewMixin from '@/mixins/ViewMixin';
import TextField from '@/components/controls/TextField.vue';
import Button from '@/components/controls/Button';
import Dialog from '@/components/dialogs/Dialog.vue';
import EditItemCategory from '@/components/ingame/itemCategory/EditItemCategory.vue';
import * as itemCategoryService from '@/services/ingame/itemCategoryService';
import { ItemCategory } from '@/interfaces/ingame/itemCategory';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import DataItem from '@/components/layout/DataItem.vue';
import { ROLE_MODERATOR } from '@/constants/roles';

interface Data {
    searchTerm: string;
    showEditDialog: boolean;
    editId: string | null;
    isLoading: boolean;
    itemCategories: ItemCategory[];
}

export default defineComponent({
    name: 'ItemCategories',
    components: {
        Dialog,
        Button,
        Panel,
        TextField,
        EditItemCategory,
        LoadingIndicatorBeam,
        DataItem,
    },
    mixins: [ViewMixin],
    data: (): Data => ({
        searchTerm: '',
        showEditDialog: false,
        editId: null,
        isLoading: false,
        itemCategories: [],
    }),
    computed: {
        isModerator(): boolean {
            return this.$store.getters['authentication/hasOneRoles'](ROLE_MODERATOR);
        },
    },
    methods: {
        showCreate(): void {
            this.editId = null;
            this.showEditDialog = true;
        },
        showEdit(id: string) {
            this.editId = id;
            this.showEditDialog = true;
        },
        hideEditDialog(refreshData = false): void {
            this.showEditDialog = false;
            this.editId = null;
            if (refreshData) {
                this.loadItemCategories();
            }
        },
        async refreshData(): Promise<void> {
            await this.loadItemCategories();
        },
        async loadItemCategories(): Promise<void> {
            this.isLoading = true;
            try {
                const response = await itemCategoryService.getMultiple({
                    pageSize: -1,
                    searchQuery: this.searchTerm,
                });
                this.itemCategories = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('itemCategories'), this.$t('ingame')]);
        this.refreshData();
    },
});
</script>
