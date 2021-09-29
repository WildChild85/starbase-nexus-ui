<template>
<Panel>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ itemId ? $t('editItem') : $t('createItem') }}</h2>
    <TextField
        class="margin-top"
        v-model.trim="properties.name"
        :label="$t('name')"
        :readonly="isLoading"
        :required="true"
        :errors="errors.name"
    />
    <TextField
        class="margin-top"
        v-model.trim="properties.iconUri"
        :label="$t('iconUri')"
        :readonly="isLoading"
        :errors="errors.iconUri"
    />
    <TextField
        class="margin-top"
        v-model.trim="properties.wikiUri"
        :label="$t('wikiUri')"
        :readonly="isLoading"
        :errors="errors.wikiUri"
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
        v-model="properties.itemCategoryId"
        :label="$t('itemCategory')"
        :readonly="isLoading"
        :errors="errors.itemCategoryId"
        :serviceFunctionSingle="getItemCategory"
        :serviceFunctionMultiple="getItemCategories"
    />
    <SelectSingleReference
        class="margin-top"
        v-model="properties.primaryMaterialId"
        :label="$t('primaryMaterial')"
        :readonly="isLoading"
        :errors="errors.primaryMaterialId"
        :serviceFunctionSingle="getMaterial"
        :serviceFunctionMultiple="getMaterials"
    />
    <TextField
        class="margin-top"
        v-model.trim="properties.adjacencyHeatValues"
        :label="$t('adjacencyHeatValues')"
        :readonly="isLoading"
        :errors="errors.adjacencyHeatValues"
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
import { CreateItem, Item, PatchItem } from '@/interfaces/ingame/item';
import * as itemService from '@/services/ingame/itemService';
import * as itemCategoryService from '@/services/ingame/itemCategoryService';
import * as materialService from '@/services/ingame/materialService';
import TextField from '@/components/controls/TextField.vue';
import TextArea from '@/components/controls/TextArea.vue';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import Panel from '@/components/layout/Panel.vue';
import SelectSingleReference from '@/components/controls/SelectSingleReference.vue';

interface Properties {
    description: string | null;
    name: string;
    iconUri: string | null;
    itemCategoryId: string | null;
    wikiUri: string | null;
    mass: number | null;
    corrosionResistance: number | null;
    primaryMaterialId: string | null;
    electricInput: number | null;
    electricOutput: number | null;
    electricityConversionBonusFactor: number | null;
    electricCapacity: number | null;
    propellantInput: number | null;
    propellantOutput: number | null;
    propellantConversionBonusFactor: number | null;
    propellantCapacity: number | null;
    thrustPower: number | null;
    tier: number | null;
    fuelCapacity: number | null;
    fuelInputRaw: number | null;
    fuelOutputProcessed: number | null;
    heatGeneration: number | null;
    electricityPerShot: number | null;
    electricityPerRecharge: number | null;
    heatGenerationPerShot: number | null;
    heatDissipation: number | null;
    adjacencyHeatValues: string | null;
    coolantCapacity: number | null;
    coolantInput: number | null;
    coolantOutput: number | null;
    minMuzzleVelocity: number | null;
    maxMuzzleVelocity: number | null;
    rateOfFire: number | null;
    chargeCapacity: number | null;
    magazineCapacity: number | null;
    projectileMass: number | null;
    projectileEnergy: number | null;
    projectileLifetime: number | null;
    warmupTime: number | null;
    researchPointsCube: number | null;
    researchPointsPower: number | null;
    researchPointsShield: number | null;
    researchPointsGear: number | null;
}

interface Data {
    item: Item | null;
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const getEmptyProperties = ():Properties => ({
    description: null,
    name: '',
    iconUri: null,
    itemCategoryId: null,
    wikiUri: null,
    mass: null,
    corrosionResistance: null,
    primaryMaterialId: null,
    electricInput: null,
    electricOutput: null,
    electricityConversionBonusFactor: null,
    electricCapacity: null,
    propellantInput: null,
    propellantOutput: null,
    propellantConversionBonusFactor: null,
    propellantCapacity: null,
    thrustPower: null,
    tier: null,
    fuelCapacity: null,
    fuelInputRaw: null,
    fuelOutputProcessed: null,
    heatGeneration: null,
    electricityPerShot: null,
    electricityPerRecharge: null,
    heatGenerationPerShot: null,
    heatDissipation: null,
    adjacencyHeatValues: null,
    coolantCapacity: null,
    coolantInput: null,
    coolantOutput: null,
    minMuzzleVelocity: null,
    maxMuzzleVelocity: null,
    rateOfFire: null,
    chargeCapacity: null,
    magazineCapacity: null,
    projectileMass: null,
    projectileEnergy: null,
    projectileLifetime: null,
    warmupTime: null,
    researchPointsCube: null,
    researchPointsPower: null,
    researchPointsShield: null,
    researchPointsGear: null,
});

export default defineComponent({
    name: 'EditItem',
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
        itemId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        item: null,
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    watch: {
        itemId(): void {
            this.refreshData();
        },
    },
    computed: {
        numericProperties(): string[] {
            return [
                'mass',
                'corrosionResistance',
                'electricInput',
                'electricOutput',
                'electricityConversionBonusFactor',
                'electricCapacity',
                'propellantInput',
                'propellantOutput',
                'propellantConversionBonusFactor',
                'propellantCapacity',
                'thrustPower',
                'tier',
                'fuelCapacity',
                'fuelInputRaw',
                'fuelOutputProcessed',
                'heatGeneration',
                'electricityPerShot',
                'electricityPerRecharge',
                'heatGenerationPerShot',
                'heatDissipation',
                'coolantCapacity',
                'coolantInput',
                'coolantOutput',
                'minMuzzleVelocity',
                'maxMuzzleVelocity',
                'rateOfFire',
                'chargeCapacity',
                'magazineCapacity',
                'projectileMass',
                'projectileEnergy',
                'projectileLifetime',
                'warmupTime',
                'researchPointsCube',
                'researchPointsPower',
                'researchPointsShield',
                'researchPointsGear',
            ];
        },
        changedProperties(): PatchItem {
            const changed: PatchItem = {};
            if (this.item !== null) {
                Object.keys(this.properties).forEach((key: string) => {
                    if ((this.item as Item)[key as keyof Item] !== (this.properties as PatchItem)[key as keyof PatchItem]) {
                        changed[key as keyof PatchItem] = (this.properties as PatchItem)[key as keyof PatchItem] as never;
                    }
                });
            }
            return changed;
        },
        getItemCategory(): unknown {
            return itemCategoryService.getOneOrDefault;
        },
        getItemCategories(): unknown {
            return itemCategoryService.getMultiple;
        },
        getMaterial(): unknown {
            return materialService.getOneOrDefault;
        },
        getMaterials(): unknown {
            return materialService.getMultiple;
        },
    },
    methods: {
        mapToProperties(): void {
            if (!this.item) {
                return;
            }
            Object.keys(this.properties).forEach((key) => {
                (this.properties as PatchItem)[key as keyof PatchItem] = (this.item as Item)[key as keyof Item] as never;
            });
        },
        async saveChanges(): Promise<void> {
            if (this.itemId) {
                if (await this.patch()) {
                    this.$emit('patched', this.item);
                }
            } else if (await this.create()) {
                this.$emit('created', this.item);
            }
        },
        refreshData(): void {
            this.properties = getEmptyProperties();
            this.loadItem();
        },
        async loadItem(): Promise<void> {
            if (!this.itemId) {
                return;
            }
            this.isLoading = true;
            try {
                this.item = (await itemService.getOneOrDefault(this.itemId)).data;
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
                this.item = (await itemService.create(this.properties as CreateItem)).data;
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
                this.item = (await itemService.patch(
                    this.itemId,
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
