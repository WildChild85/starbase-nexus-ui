<template>
<div class="home">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <Panel>
            <div class="flex flex--end">
                <TextField v-model.trim="searchTerm" :placeholder="$t('search')" @keyup.enter="refreshData"/>
                <Button class="margin-left" :loading="isLoading" @click="refreshData">Refresh</Button>
                <Button class="margin-left" @click="showCreate" v-if="isModerator">Create</Button>
                <Button class="margin-left" type="info" href="https://wiki.starbasegame.com/index.php/Materials">Wiki</Button>
            </div>

            <DataItem v-for="material in materials" :key="material.id" class="margin-top--f2">
                <div class="data-item__icon" :style="{ backgroundImage: `url(${material.iconUriRaw})`}"></div>
                <div class="data-item__icon" :style="{ backgroundImage: `url(${material.iconUriRefined})`}"></div>
                <div class="data-item__icon" :style="{ backgroundImage: `url(${material.iconUriOreChunk})`}"></div>
                <div class="data-item__name">{{ material.name }}</div>
                <div class="data-item__spacer"></div>

                <template v-for="prop in Object.keys(material)">
                    <div class="data-item__property" :key="prop" v-if="!excludedProperties.includes(prop) && material[prop] != null">
                        <div class="data-item__property-label">{{ $t(prop) }}</div>
                        <div class="data-item__property-value" v-html="numberToLocaleString(material[prop], 0, 6)"></div>
                    </div>
                </template>

                <div class="data-item__spacer"></div>
                <div class="data-item__action" v-if="isModerator" @click="showEdit(material.id)"><PencilIconSolid class="svg-icon"/></div>
            </DataItem>
        </Panel>
    </div>
    <Dialog v-if="showEditDialog" @close="hideEditDialog">
        <EditMaterial
            :materialId="editId"
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
import EditMaterial from '@/components/ingame/material/EditMaterial.vue';
import * as materialService from '@/services/ingame/materialService';
import { Material } from '@/interfaces/ingame/material';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import DataItem from '@/components/layout/DataItem.vue';
import { ROLE_MODERATOR } from '@/constants/roles';
import { numberToLocaleString } from '@/helpers';

interface Data {
    searchTerm: string;
    showEditDialog: boolean;
    editId: string | null;
    isLoading: boolean;
    materials: Material[];
}

export default defineComponent({
    name: 'Materials',
    components: {
        Dialog,
        Button,
        Panel,
        TextField,
        EditMaterial,
        LoadingIndicatorBeam,
        DataItem,
    },
    mixins: [ViewMixin],
    data: (): Data => ({
        searchTerm: '',
        showEditDialog: false,
        editId: null,
        isLoading: false,
        materials: [],
    }),
    computed: {
        isModerator(): boolean {
            return this.$store.getters['authentication/hasOneRoles'](ROLE_MODERATOR);
        },
        excludedProperties(): string[] {
            return ['id', 'iconUriRaw', 'iconUriRefined', 'iconUriOreChunk', 'createdAt', 'updatedAt', 'description', 'name', 'wikiUri', 'materialCategoryId', 'minArmor', 'transformability'];
        },
    },
    methods: {
        numberToLocaleString,
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
                this.loadMaterials();
            }
        },
        async refreshData(): Promise<void> {
            await this.loadMaterials();
        },
        async loadMaterials(): Promise<void> {
            this.isLoading = true;
            try {
                const response = await materialService.getMultiple({
                    pageSize: -1,
                    searchQuery: this.searchTerm,
                });
                this.materials = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('materials'), this.$t('ingame')]);
        this.refreshData();
    },
});
</script>
