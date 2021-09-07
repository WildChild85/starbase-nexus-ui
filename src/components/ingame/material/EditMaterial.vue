<template>
<Panel>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ materialId ? $t('editMaterial') : $t('createMaterial') }}</h2>
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
    <SelectSingleReference
        class="margin-top"
        v-model="properties.materialCategoryId"
        :label="$t('materialCategory')"
        :readonly="isLoading"
        :required="true"
        :errors="errors.materialCategoryId"
        :serviceFunctionSingle="getMaterialCategory"
        :serviceFunctionMultiple="getMaterialCategories"
    />
    <TextField
        v-for="numericProperty in numericProperties"
        :key="numericProperty"
        class="margin-top"
        v-model.number="properties[numericProperty]"
        :label="$t(numericProperty)"
        type="number"
        :readonly="isLoading"
        :errors="errors[numericProperty]"
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
import { CreateMaterial, Material, PatchMaterial } from '@/interfaces/ingame/material';
import * as materialService from '@/services/ingame/materialService';
import TextField from '@/components/controls/TextField.vue';
import TextArea from '@/components/controls/TextArea.vue';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import Panel from '@/components/layout/Panel.vue';
import SelectSingleReference from '@/components/controls/SelectSingleReference.vue';
import * as materialCategoryService from '@/services/ingame/materialCategoryService';

interface Properties {
    description: string;
    name: string;
    materialCategoryId: string | null;
    armor?: number | null;
    minArmor?: number | null;
    voxelPenetrationMultiplier?: number | null;
    corrosionResistance?: number | null;
    transformability?: number | null;
    structuralDurability?: number | null;
    density?: number | null;
    oreDensity?: number | null;
    iconUriRaw?: string | null;
    iconUriRefined?: string | null;
    iconUriOreChunk? : string | null;
}

interface Data {
    material: Material | null;
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const getEmptyProperties = ():Properties => ({
    description: '',
    name: '',
    materialCategoryId: null,
    armor: null,
    minArmor: null,
    voxelPenetrationMultiplier: null,
    corrosionResistance: null,
    transformability: null,
    structuralDurability: null,
    density: null,
    oreDensity: null,
    iconUriRaw: null,
    iconUriRefined: null,
    iconUriOreChunk: null,
});

export default defineComponent({
    name: 'EditMaterial',
    components: {
        Button,
        LoadingIndicatorBeam,
        Panel,
        TextField,
        TextArea,
        SelectSingleReference,
    },
    emits: ['created', 'patched', 'cancelled'],
    props: {
        materialId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        material: null,
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    watch: {
        materialId(): void {
            this.refreshData();
        },
    },
    computed: {
        numericProperties(): string[] {
            return [
                'armor',
                'minArmor',
                'voxelPenetrationMultiplier',
                'corrosionResistance',
                'transformability',
                'structuralDurability',
                'density',
                'oreDensity',
            ];
        },
        changedProperties(): PatchMaterial {
            const changed: PatchMaterial = {};
            if (this.material !== null) {
                Object.keys(this.properties).forEach((key: string) => {
                    if ((this.material as Material)[key as keyof Material] !== (this.properties as PatchMaterial)[key as keyof PatchMaterial]) {
                        changed[key as keyof PatchMaterial] = (this.properties as PatchMaterial)[key as keyof PatchMaterial] as never;
                    }
                });
            }
            return changed;
        },
        getMaterialCategory(): unknown {
            return materialCategoryService.getOneOrDefault;
        },
        getMaterialCategories(): unknown {
            return materialCategoryService.getMultiple;
        },
    },
    methods: {
        mapToProperties(): void {
            if (!this.material) {
                return;
            }
            Object.keys(this.properties).forEach((key) => {
                (this.properties as PatchMaterial)[key as keyof PatchMaterial] = (this.material as Material)[key as keyof Material] as never;
            });
        },
        async saveChanges(): Promise<void> {
            if (this.materialId) {
                if (await this.patch()) {
                    this.$emit('patched', this.material);
                }
            } else if (await this.create()) {
                this.$emit('created', this.material);
            }
        },
        refreshData(): void {
            this.properties = getEmptyProperties();
            this.loadMaterial();
        },
        async loadMaterial(): Promise<void> {
            if (!this.materialId) {
                return;
            }
            this.isLoading = true;
            try {
                this.material = (await materialService.getOneOrDefault(this.materialId)).data;
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
                this.material = (await materialService.create(this.properties as CreateMaterial)).data;
                this.$notify({
                    type: 'success',
                    text: this.$t('saved'),
                });
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
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
                this.material = (await materialService.patch(
                    this.materialId,
                    this.changedProperties,
                )).data;
                this.$notify({
                    type: 'success',
                    text: this.$t('saved'),
                });
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
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
