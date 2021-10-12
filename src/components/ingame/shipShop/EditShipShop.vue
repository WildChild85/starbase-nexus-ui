<template>
<div>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ shipShopId ? $t('editShipShop') : $t('createShipShop') }}</h2>
    <TextField
        class="margin-top"
        v-model.trim="properties.name"
        :label="$t('name')"
        :readonly="isLoading"
        :required="true"
        :errors="errors.name"
    />
    <SelectFile
        class="margin-top"
        :label="$t('image')"
        v-model="properties.imageUri"
    />
    <SimpleSelect
        class="margin-top"
        :label="$t('layout')"
        v-model="properties.layout"
        :options="layoutOptions"
        :required="true"
    />
    <TextArea
        class="margin-top"
        v-model="properties.description"
        :label="$t('descriptionMD')"
        :readonly="isLoading"
        :required="true"
        :isCode="true"
        :errors="errors.description"
        @input="$emit('update:description', properties.description);"
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
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { CreateShipShop, ShipShop, PatchShipShop } from '@/interfaces/ingame/shipShop';
import * as shipShopService from '@/services/ingame/shipShopService';
import TextField from '@/components/controls/TextField.vue';
import TextArea from '@/components/controls/TextArea.vue';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import SelectFile from '@/components/controls/SelectFile.vue';
import SimpleSelect from '@/components/controls/SimpleSelect.vue';
import { SHIP_SHOP_LAYOUT_SMALL } from '@/constants/ingame';
import { SelectOption } from '@/interfaces/ui';

interface Properties {
    imageUri?: string | null;
    name: string;
    description: string;
    layout: string;
    height?: number | null;
    width?: number | null;
    left?: number | null;
    top?: number | null;
}

interface Data {
    shipShop: ShipShop | null;
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const defaultMarkdown = `The folowing text is a default template. Change it as you like :) There is no required structure or content. Just write something.

A description about the ship, like the story behind it, the faction behind it and if ships in it have a specialization or some kind of unique feature.
`;

const getEmptyProperties = ():Properties => ({
    imageUri: null,
    name: '',
    description: defaultMarkdown,
    layout: SHIP_SHOP_LAYOUT_SMALL,
    height: null,
    width: null,
    left: null,
    top: null,
});

export default defineComponent({
    name: 'EditShipShop',
    components: {
        Button,
        LoadingIndicatorBeam,
        SelectFile,
        SimpleSelect,
        TextField,
        TextArea,
    },
    emits: ['created', 'patched', 'cancelled', 'update:description'],
    props: {
        shipShopId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        shipShop: null,
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    watch: {
        shipShopId(): void {
            this.refreshData();
        },
        properties(): void {
            this.$emit('update:description', this.properties.description);
        },
    },
    computed: {
        changedProperties(): PatchShipShop {
            const changed: PatchShipShop = {};
            if (this.shipShop !== null) {
                Object.keys(this.properties).forEach((key: string) => {
                    if ((this.shipShop as ShipShop)[key as keyof ShipShop] !== (this.properties as PatchShipShop)[key as keyof PatchShipShop]) {
                        changed[key as keyof PatchShipShop] = (this.properties as PatchShipShop)[key as keyof PatchShipShop] as never;
                    }
                });
            }
            return changed;
        },
        layoutOptions(): SelectOption[] {
            return [
                { value: 'small', label: this.$t('small') },
                { value: 'large', label: this.$t('large') },
            ];
        },
    },
    methods: {
        mapToProperties(): void {
            if (!this.shipShop) {
                return;
            }
            Object.keys(this.properties).forEach((key) => {
                (this.properties as PatchShipShop)[key as keyof PatchShipShop] = (this.shipShop as ShipShop)[key as keyof ShipShop] as never;
            });
        },
        async saveChanges(): Promise<void> {
            if (this.shipShopId) {
                if (await this.patch()) {
                    this.$emit('patched', this.shipShop);
                }
            } else if (await this.create()) {
                this.$emit('created', this.shipShop);
            }
        },
        refreshData(): void {
            this.properties = getEmptyProperties();
            this.loadShipShop();
        },
        async loadShipShop(): Promise<void> {
            if (!this.shipShopId) {
                return;
            }
            this.isLoading = true;
            try {
                this.shipShop = (await shipShopService.getOneOrDefault(this.shipShopId)).data;
                this.mapToProperties();
                this.$emit('update:description', this.properties.description);
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async create(): Promise<boolean> {
            this.isLoading = true;
            this.errors = {};
            try {
                this.shipShop = (await shipShopService.create(this.properties as CreateShipShop)).data;
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
                this.shipShop = (await shipShopService.patch(
                    this.shipShopId,
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
