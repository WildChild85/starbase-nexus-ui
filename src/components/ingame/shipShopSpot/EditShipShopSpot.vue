<template>
<Panel>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ shipShopSpotId ? $t('editShipShopSpot') : $t('createShipShopSpot') }}</h2>

    <TextField
        class="margin-top"
        v-model.number="properties.position"
        :label="$t('position')"
        type="number"
        :readonly="true"
        :errors="errors.position"
    />

    <SimpleSelect
        class="margin-top"
        :label="$t('size')"
        v-model="properties.size"
        :options="sizeOptions"
        :errors="errors.size"
    />

    <SelectSingleReference
        class="margin-top"
        v-model="properties.shipId"
        :label="$t('ship')"
        :readonly="isLoading"
        :required="true"
        :errors="errors.shipId"
        :service="serviceShip"
        :createRoute="{ name: 'constructions_ship_create' }"
        imageProperty="previewImageUri"
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
import {
    CreateShipShopSpot, ShipShopSpot, PatchShipShopSpot, ShipShopSpotConfig,
} from '@/interfaces/ingame/shipShopSpot';
import * as shipService from '@/services/constructions/shipService';
import * as shipShopSpotService from '@/services/ingame/shipShopSpotService';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import Panel from '@/components/layout/Panel.vue';
import TextField from '@/components/controls/TextField.vue';
import { SelectOption } from '@/interfaces/ui';
import SimpleSelect from '@/components/controls/SimpleSelect.vue';
import SelectSingleReference from '@/components/controls/SelectSingleReference.vue';

interface Properties {
    shipShopId: string | null;
    shipId: string | null;
    position: number;
    size: number;
}

interface Data {
    shipShopSpot: ShipShopSpot | null;
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const getEmptyProperties = ():Properties => ({
    shipShopId: null,
    shipId: null,
    position: 1,
    size: 1,
});

export default defineComponent({
    name: 'EditShipShopSpot',
    components: {
        Button,
        LoadingIndicatorBeam,
        Panel,
        SelectSingleReference,
        SimpleSelect,
        TextField,
    },
    emits: ['created', 'patched', 'cancelled'],
    props: {
        shipShopSpotId: {
            type: String,
            default: null,
        },
        position: {
            type: Number,
            required: true,
        },
        shipShopId: {
            type: String,
            required: true,
        },
        shipShopSpotConfigs: {
            type: Array,
            required: true,
        },
    },
    data: (): Data => ({
        shipShopSpot: null,
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    watch: {
        shipShopSpotId(): void {
            this.refreshData();
        },
    },
    computed: {
        changedProperties(): PatchShipShopSpot {
            const changed: PatchShipShopSpot = {};
            if (this.shipShopSpot !== null) {
                Object.keys(this.properties).forEach((key: string) => {
                    if ((this.shipShopSpot as ShipShopSpot)[key as keyof ShipShopSpot] !== (this.properties as PatchShipShopSpot)[key as keyof PatchShipShopSpot]) {
                        changed[key as keyof PatchShipShopSpot] = (this.properties as PatchShipShopSpot)[key as keyof PatchShipShopSpot] as never;
                    }
                });
            }
            return changed;
        },
        typedShipShopSpotConfigs(): ShipShopSpotConfig[] {
            return this.shipShopSpotConfigs as ShipShopSpotConfig[];
        },
        shipShopSpotConfig(): ShipShopSpotConfig {
            return this.typedShipShopSpotConfigs.find(({ id }) => id === this.properties.position) as ShipShopSpotConfig;
        },
        sizeOptions(): SelectOption[] {
            return this.shipShopSpotConfig.sizes.map(({ size }) => ({
                value: size,
                label: `${size}`,
            }));
        },
        serviceShip(): unknown {
            return shipService;
        },
    },
    methods: {
        mapToProperties(): void {
            if (!this.shipShopSpot) {
                return;
            }
            Object.keys(this.properties).forEach((key) => {
                (this.properties as PatchShipShopSpot)[key as keyof PatchShipShopSpot] = (this.shipShopSpot as ShipShopSpot)[key as keyof ShipShopSpot] as never;
            });
        },
        async saveChanges(): Promise<void> {
            if (this.shipShopSpotId) {
                if (await this.patch()) {
                    this.$emit('patched', this.shipShopSpot);
                }
            } else if (await this.create()) {
                this.$emit('created', this.shipShopSpot);
            }
        },
        refreshData(): void {
            this.properties = getEmptyProperties();

            if (!this.shipShopSpotId) {
                this.properties.position = this.position;
                this.properties.size = this.shipShopSpotConfig.sizes[0].size;
                this.properties.shipShopId = this.shipShopId;
            }

            this.loadShipShopSpot();
        },
        async loadShipShopSpot(): Promise<void> {
            if (!this.shipShopSpotId) {
                return;
            }
            this.isLoading = true;
            try {
                this.shipShopSpot = (await shipShopSpotService.getOneOrDefault(this.shipShopSpotId)).data;
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
                this.shipShopSpot = (await shipShopSpotService.create(this.properties as CreateShipShopSpot)).data;
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
                this.shipShopSpot = (await shipShopSpotService.patch(
                    this.shipShopSpotId,
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
        await this.refreshData();
    },
});
</script>
