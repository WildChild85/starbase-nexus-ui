<template>
<Panel>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ materialCategoryId ? $t('editMaterialCategory') : $t('createMaterialCategory') }}</h2>
    <TextField
        class="margin-top"
        v-model.trim="properties.name"
        :label="$t('name')"
        :readonly="isLoading"
        :required="true"
        :errors="errors.name"
    />
    <TextArea
        class="margin-top"
        v-model.trim="properties.description"
        :label="$t('description')"
        :readonly="isLoading"
        :required="true"
        :errors="errors.description"
    />

    <div class="panel__actions">
        <Button
            type="success"
            :loading="isLoading"
            @click="saveChanges"
        >{{ $t('save') }}</Button>

        <Button
            :disabled="isLoading"
            :small="true"
            type="secondary"
            @click="$emit('cancelled')"
        >{{ $t('cancel') }}</Button>
    </div>
</Panel>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { CreateMaterialCategory, MaterialCategory, PatchMaterialCategory } from '@/interfaces/ingame/materialCategory';
import * as materialCategoryService from '@/services/ingame/materialCategoryService';
import TextField from '@/components/controls/TextField.vue';
import TextArea from '@/components/controls/TextArea.vue';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import Panel from '@/components/layout/Panel.vue';

interface Properties {
    description: string;
    name: string;
}

interface Data {
    materialCategory: MaterialCategory | null;
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const getEmptyProperties = ():Properties => ({
    description: '',
    name: '',
});

export default defineComponent({
    name: 'EditMaterialCategory',
    components: {
        Button,
        LoadingIndicatorBeam,
        Panel,
        TextField,
        TextArea,
    },
    emits: ['created', 'patched', 'cancelled'],
    props: {
        materialCategoryId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        materialCategory: null,
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    watch: {
        materialCategoryId(): void {
            this.refreshData();
        },
    },
    computed: {
        changedProperties(): PatchMaterialCategory {
            const changed: PatchMaterialCategory = {};
            if (this.materialCategory !== null) {
                Object.keys(this.properties).forEach((key: string) => {
                    if ((this.materialCategory as MaterialCategory)[key as keyof MaterialCategory] !== (this.properties as PatchMaterialCategory)[key as keyof PatchMaterialCategory]) {
                        changed[key as keyof PatchMaterialCategory] = (this.properties as PatchMaterialCategory)[key as keyof PatchMaterialCategory] as never;
                    }
                });
            }
            return changed;
        },
    },
    methods: {
        mapToProperties(): void {
            if (!this.materialCategory) {
                return;
            }
            Object.keys(this.properties).forEach((key) => {
                (this.properties as PatchMaterialCategory)[key as keyof PatchMaterialCategory] = (this.materialCategory as MaterialCategory)[key as keyof MaterialCategory] as never;
            });
        },
        async saveChanges(): Promise<void> {
            if (this.materialCategoryId) {
                if (await this.patch()) {
                    this.$emit('patched', this.materialCategory);
                }
            } else if (await this.create()) {
                this.$emit('created', this.materialCategory);
            }
        },
        refreshData(): void {
            this.properties = getEmptyProperties();
            this.loadMaterialCategory();
        },
        async loadMaterialCategory(): Promise<void> {
            if (!this.materialCategoryId) {
                return;
            }
            this.isLoading = true;
            try {
                this.materialCategory = (await materialCategoryService.getOneOrDefault(this.materialCategoryId)).data;
                this.mapToProperties();
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async create(): Promise<boolean> {
            this.isLoading = true;
            this.errors = {};
            try {
                this.materialCategory = (await materialCategoryService.create(this.properties as CreateMaterialCategory)).data;
                this.$notify({
                    type: 'success',
                    text: this.$t('saved'),
                });
            } catch (error: any) {
                if (error.response && error.response.data && error.response.data.errors) {
                    this.errors = error.response.data.errors;
                }
                this.isLoading = false;
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth',
                });
                this.$notify({
                    type: 'error',
                    text: this.$t('savingFailed'),
                });
                return false;
            }
            this.isLoading = false;
            return true;
        },
        async patch(): Promise<boolean> {
            this.isLoading = true;
            this.errors = {};
            try {
                this.materialCategory = (await materialCategoryService.patch(
                    this.materialCategoryId,
                    this.changedProperties,
                )).data;
                this.$notify({
                    type: 'success',
                    text: this.$t('saved'),
                });
            } catch (error: any) {
                if (error.response && error.response.data && error.response.data.errors) {
                    this.errors = error.response.data.errors;
                }
                this.isLoading = false;
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth',
                });
                this.$notify({
                    type: 'error',
                    text: this.$t('savingFailed'),
                });
                return false;
            }
            this.isLoading = false;
            return true;
        },
    },
    async created(): Promise<void> {
        this.refreshData();
    },
});
</script>
