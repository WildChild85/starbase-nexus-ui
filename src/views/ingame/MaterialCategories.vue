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

            <DataItem v-for="materialCategory in materialCategories" :key="materialCategory.id" class="margin-top--f2">
                <div class="data-item__name">{{ materialCategory.name }}</div>
                <div class="data-item__spacer"></div>
                <div class="data-item__action" v-if="isModerator" @click="showEdit(materialCategory.id)"><PencilIconSolid class="svg-icon"/></div>
            </DataItem>
        </Panel>
    </div>
    <Dialog v-if="showEditDialog" @close="hideEditDialog">
        <EditMaterialCategory
            :materialCategoryId="editId"
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
import EditMaterialCategory from '@/components/ingame/materialCategory/EditMaterialCategory.vue';
import * as materialCategoryService from '@/services/ingame/materialCategoryService';
import { MaterialCategory } from '@/interfaces/ingame/materialCategory';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import DataItem from '@/components/layout/DataItem.vue';
import { ROLE_MODERATOR } from '@/constants/roles';

interface Data {
    searchTerm: string;
    showEditDialog: boolean;
    editId: string | null;
    isLoading: boolean;
    materialCategories: MaterialCategory[];
}

export default defineComponent({
    name: 'MaterialCategories',
    components: {
        Dialog,
        Button,
        Panel,
        TextField,
        EditMaterialCategory,
        LoadingIndicatorBeam,
        DataItem,
    },
    mixins: [ViewMixin],
    data: (): Data => ({
        searchTerm: '',
        showEditDialog: false,
        editId: null,
        isLoading: false,
        materialCategories: [],
    }),
    computed: {
        isModerator(): boolean {
            return this.$store.getters['authentication/hasOneRoles']([ROLE_MODERATOR]);
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
                this.loadMaterialCategories();
            }
        },
        async refreshData(): Promise<void> {
            await this.loadMaterialCategories();
        },
        async loadMaterialCategories(): Promise<void> {
            this.isLoading = true;
            try {
                const response = await materialCategoryService.getMultiple({
                    pageSize: -1,
                    searchQuery: this.searchTerm,
                });
                this.materialCategories = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('materialCategories'), this.$t('ingame')]);
        this.refreshData();
    },
});
</script>
