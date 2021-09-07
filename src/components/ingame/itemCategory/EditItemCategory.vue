<template>
<Panel>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ itemCategoryId ? $t('editItemCategory') : $t('createItemCategory') }}</h2>
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
        :errors="errors.description"
    />
    <SelectSingleReference
        class="margin-top"
        v-model="properties.parentId"
        :label="$t('parent')"
        :readonly="isLoading"
        :errors="errors.parentId"
        :serviceFunctionSingle="getParent"
        :serviceFunctionMultiple="getItemCategories"
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
import { CreateItemCategory, ItemCategory, PatchItemCategory } from '@/interfaces/ingame/itemCategory';
import * as itemCategoryService from '@/services/ingame/itemCategoryService';
import TextField from '@/components/controls/TextField.vue';
import TextArea from '@/components/controls/TextArea.vue';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import Panel from '@/components/layout/Panel.vue';
import SelectSingleReference from '@/components/controls/SelectSingleReference.vue';

interface Properties {
    description: string | null;
    name: string;
    parentId: string | null;
}

interface Data {
    itemCategory: ItemCategory | null;
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const getEmptyProperties = ():Properties => ({
    description: null,
    name: '',
    parentId: null,
});

export default defineComponent({
    name: 'EditItemCategory',
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
        itemCategoryId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        itemCategory: null,
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    watch: {
        itemCategoryId(): void {
            this.refreshData();
        },
    },
    computed: {
        changedProperties(): PatchItemCategory {
            const changed: PatchItemCategory = {};
            if (this.itemCategory !== null) {
                Object.keys(this.properties).forEach((key: string) => {
                    if ((this.itemCategory as ItemCategory)[key as keyof ItemCategory] !== (this.properties as PatchItemCategory)[key as keyof PatchItemCategory]) {
                        changed[key as keyof PatchItemCategory] = (this.properties as PatchItemCategory)[key as keyof PatchItemCategory] as never;
                    }
                });
            }
            return changed;
        },
        getParent(): unknown {
            return itemCategoryService.getOneOrDefault;
        },
        getItemCategories(): unknown {
            return itemCategoryService.getMultiple;
        },
    },
    methods: {
        mapToProperties(): void {
            if (!this.itemCategory) {
                return;
            }
            Object.keys(this.properties).forEach((key) => {
                (this.properties as PatchItemCategory)[key as keyof PatchItemCategory] = (this.itemCategory as ItemCategory)[key as keyof ItemCategory] as never;
            });
        },
        async saveChanges(): Promise<void> {
            if (this.itemCategoryId) {
                if (await this.patch()) {
                    this.$emit('patched', this.itemCategory);
                }
            } else if (await this.create()) {
                this.$emit('created', this.itemCategory);
            }
        },
        refreshData(): void {
            this.properties = getEmptyProperties();
            this.loadItemCategory();
        },
        async loadItemCategory(): Promise<void> {
            if (!this.itemCategoryId) {
                return;
            }
            this.isLoading = true;
            try {
                this.itemCategory = (await itemCategoryService.getOneOrDefault(this.itemCategoryId)).data;
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
                this.itemCategory = (await itemCategoryService.create(this.properties as CreateItemCategory)).data;
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
                this.itemCategory = (await itemCategoryService.patch(
                    this.itemCategoryId,
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
