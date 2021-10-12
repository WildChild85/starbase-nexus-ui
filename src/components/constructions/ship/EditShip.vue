<template>
<div>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ shipId ? $t('editShip') : $t('createShip') }}</h2>
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
        :label="$t('previewImage')"
        v-model="properties.previewImageUri"
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
    <SelectFiles
        class="margin-top"
        :label="$t('galleryImages')"
        v-model="properties.imageUris"
    />
    <SelectMultipleReference
        class="margin-top"
        v-model="properties.shipRoleIds"
        :label="$t('shipRoles')"
        :readonly="isLoading"
        :errors="errors.shipRoleIds"
        :service="serviceShipRole"
    />
    <SelectSingleReference
        class="margin-top"
        v-model="properties.armorMaterialId"
        :label="$t('armorMaterial')"
        :readonly="isLoading"
        :errors="errors.armorMaterialId"
        :service="serviceMaterial"
    />
    <SelectSingleReference
        class="margin-top"
        v-model="properties.companyId"
        :label="$t('company')"
        :readonly="isLoading"
        :errors="errors.companyId"
        :service="serviceCompany"
    />
    <TextField
        class="margin-top"
        v-model.trim="properties.youtubeVideoUri"
        :label="$t('youtubeVideoUri')"
        :readonly="isLoading"
        :errors="errors.youtubeVideoUri"
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

    <Switch
        v-if="!shipId"
        v-model="properties.isCreator"
        :label="$t('creatorOfShipQuestion')"
        class="margin-top"
        :readonly="isLoading"
        :errors="errors.isCreator"
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
import { CreateShip, Ship, PatchShip } from '@/interfaces/constructions/ship';

import * as shipService from '@/services/constructions/shipService';
import * as companyService from '@/services/social/companyService';
import * as shipRoleService from '@/services/constructions/shipRoleService';
import * as materialService from '@/services/ingame/materialService';

import TextField from '@/components/controls/TextField.vue';
import TextArea from '@/components/controls/TextArea.vue';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import SelectFile from '@/components/controls/SelectFile.vue';
import SelectFiles from '@/components/controls/SelectFiles.vue';
import SelectSingleReference from '@/components/controls/SelectSingleReference.vue';
import SelectMultipleReference from '@/components/controls/SelectMultipleReference.vue';
import Switch from '@/components/controls/Switch.vue';

interface Properties {
    companyId: string | null;
    armorMaterialId: string | null;
    name: string;
    description: string;
    previewImageUri: string;
    imageUris: string | null;
    youtubeVideoUri: string | null;
    oreCrates: number | null;
    speedWithoutCargo: number | null;
    speedWithCargo: number | null;
    priceBlueprint: number | null;
    priceShip: number | null;
    resourceBridges: number | null;
    batteries: number | null;
    generatedPower: number | null;
    propellantCapacity: number | null;
    backwardThrustPower: number | null;
    forwardThrustPower: number | null;
    length: number | null;
    height: number | null;
    width: number | null;
    flightTime: number | null;
    totalMassWithoutCargo: number | null;
    radiators: number | null;
    miningLasers: number | null;
    oreCollectors: number | null;
    primaryWeaponsAutoCannons: number | null;
    primaryWeaponsLaserCannons: number | null;
    primaryWeaponsPlasmaCannons: number | null;
    primaryWeaponsRailCannons: number | null;
    primaryWeaponsMissileLauncher: number | null;
    primaryWeaponsTorpedoLauncher: number | null;
    turretWeaponsAutoCannons: number | null;
    turretWeaponsLaserCannons: number | null;
    turretWeaponsPlasmaCannons: number | null;
    turretWeaponsRailCannons: number | null;
    turretWeaponsMissileLauncher: number | null;
    turretWeaponsTorpedoLauncher: number | null;
    shipRoleIds: string[],
    isCreator?: boolean;
}

interface Data {
    ship: Ship | null;
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const defaultMarkdown = `The folowing text is a default template. Change it as you like :) There is no required structure or content. Just write something.

This ship is an awesome ship for a lot of reasons.

## Features
* ISAN v2.5
* Automatic Generator Control
* Flow Control
`;

const getEmptyProperties = ():Properties => ({
    companyId: null,
    armorMaterialId: null,
    name: '',
    description: defaultMarkdown,
    previewImageUri: '',
    imageUris: null,
    youtubeVideoUri: null,
    oreCrates: null,
    speedWithoutCargo: null,
    speedWithCargo: null,
    priceBlueprint: null,
    priceShip: null,
    resourceBridges: null,
    batteries: null,
    generatedPower: null,
    propellantCapacity: null,
    backwardThrustPower: null,
    forwardThrustPower: null,
    length: null,
    height: null,
    width: null,
    flightTime: null,
    totalMassWithoutCargo: null,
    radiators: null,
    miningLasers: null,
    oreCollectors: null,
    primaryWeaponsAutoCannons: null,
    primaryWeaponsLaserCannons: null,
    primaryWeaponsPlasmaCannons: null,
    primaryWeaponsRailCannons: null,
    primaryWeaponsMissileLauncher: null,
    primaryWeaponsTorpedoLauncher: null,
    turretWeaponsAutoCannons: null,
    turretWeaponsLaserCannons: null,
    turretWeaponsPlasmaCannons: null,
    turretWeaponsRailCannons: null,
    turretWeaponsMissileLauncher: null,
    turretWeaponsTorpedoLauncher: null,
    shipRoleIds: [],
    isCreator: false,
});

export default defineComponent({
    name: 'EditShip',
    components: {
        Button,
        LoadingIndicatorBeam,
        SelectFile,
        SelectFiles,
        SelectSingleReference,
        SelectMultipleReference,
        Switch,
        TextField,
        TextArea,
    },
    emits: ['created', 'patched', 'cancelled', 'update:description'],
    props: {
        shipId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        ship: null,
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    watch: {
        shipId(): void {
            this.refreshData();
        },
        properties(): void {
            this.$emit('update:description', this.properties.description);
        },
    },
    computed: {
        changedProperties(): PatchShip {
            const changed: PatchShip = {};
            if (this.ship !== null) {
                Object.keys(this.properties).forEach((key: string) => {
                    if ((this.ship as Ship)[key as keyof Ship] !== (this.properties as PatchShip)[key as keyof PatchShip]) {
                        changed[key as keyof PatchShip] = (this.properties as PatchShip)[key as keyof PatchShip] as never;
                    }
                });
            }
            return changed;
        },
        serviceCompany(): unknown {
            return companyService;
        },
        serviceShipRole(): unknown {
            return shipRoleService;
        },
        serviceMaterial(): unknown {
            return materialService;
        },
        numericProperties(): string[] {
            return [
                'oreCrates',
                'speedWithoutCargo',
                'speedWithCargo',
                'priceBlueprint',
                'priceShip',
                'resourceBridges',
                'batteries',
                'generatedPower',
                'propellantCapacity',
                'backwardThrustPower',
                'forwardThrustPower',
                'length',
                'height',
                'width',
                'flightTime',
                'totalMassWithoutCargo',
                'radiators',
                'miningLasers',
                'oreCollectors',
                'primaryWeaponsAutoCannons',
                'primaryWeaponsLaserCannons',
                'primaryWeaponsPlasmaCannons',
                'primaryWeaponsRailCannons',
                'primaryWeaponsMissileLauncher',
                'primaryWeaponsTorpedoLauncher',
                'turretWeaponsAutoCannons',
                'turretWeaponsLaserCannons',
                'turretWeaponsPlasmaCannons',
                'turretWeaponsRailCannons',
                'turretWeaponsMissileLauncher',
                'turretWeaponsTorpedoLauncher',
            ];
        },
    },
    methods: {
        mapToProperties(): void {
            if (!this.ship) {
                return;
            }
            Object.keys(this.properties).forEach((key) => {
                if (key === 'shipRoleIds') {
                    this.properties.shipRoleIds = (this.ship as Ship).shipRoles.map(({ shipRoleId }) => shipRoleId);
                } else {
                    (this.properties as PatchShip)[key as keyof PatchShip] = (this.ship as Ship)[key as keyof Ship] as never;
                }
            });
        },
        async saveChanges(): Promise<void> {
            if (this.shipId) {
                if (await this.patch()) {
                    this.$emit('patched', this.ship);
                }
            } else if (await this.create()) {
                this.$emit('created', this.ship);
            }
        },
        refreshData(): void {
            this.properties = getEmptyProperties();
            this.loadShip();
        },
        async loadShip(): Promise<void> {
            if (!this.shipId) {
                return;
            }
            this.isLoading = true;
            try {
                this.ship = (await shipService.getOneOrDefault(this.shipId)).data;
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
                this.ship = (await shipService.create(this.properties as CreateShip)).data;
                this.$notify({
                    type: 'success',
                    text: this.$t('saved'),
                });
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            } catch (error: any) {
                if (error.response && error.response.data && error.response.data.errors) {
                    this.errors = error.response.data.errors;
                }
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
                this.ship = (await shipService.patch(
                    this.shipId,
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
