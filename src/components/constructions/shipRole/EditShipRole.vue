<template>
<Panel>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ shipRoleId ? $t('editShipRole') : $t('createShipRole') }}</h2>
    <TextField
        class="margin-top"
        v-model.trim="properties.name"
        :label="$t('name')"
        :readonly="isLoading"
        :required="true"
        :errors="errors.name"
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
import { CreateShipRole, ShipRole, PatchShipRole } from '@/interfaces/constructions/shipRole';
import * as shipRoleService from '@/services/constructions/shipRoleService';
import TextField from '@/components/controls/TextField.vue';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import Panel from '@/components/layout/Panel.vue';

interface Properties {
    name: string;
}

interface Data {
    shipRole: ShipRole | null;
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const getEmptyProperties = ():Properties => ({
    name: '',
});

export default defineComponent({
    name: 'EditShipRole',
    components: {
        Button,
        LoadingIndicatorBeam,
        Panel,
        TextField,
    },
    emits: ['created', 'patched', 'cancelled'],
    props: {
        shipRoleId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        shipRole: null,
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    watch: {
        shipRoleId(): void {
            this.refreshData();
        },
    },
    computed: {
        changedProperties(): PatchShipRole {
            const changed: PatchShipRole = {};
            if (this.shipRole !== null) {
                Object.keys(this.properties).forEach((key: string) => {
                    if ((this.shipRole as ShipRole)[key as keyof ShipRole] !== (this.properties as PatchShipRole)[key as keyof PatchShipRole]) {
                        changed[key as keyof PatchShipRole] = (this.properties as PatchShipRole)[key as keyof PatchShipRole] as never;
                    }
                });
            }
            return changed;
        },
    },
    methods: {
        mapToProperties(): void {
            if (!this.shipRole) {
                return;
            }
            Object.keys(this.properties).forEach((key) => {
                (this.properties as PatchShipRole)[key as keyof PatchShipRole] = (this.shipRole as ShipRole)[key as keyof ShipRole] as never;
            });
        },
        async saveChanges(): Promise<void> {
            if (this.shipRoleId) {
                if (await this.patch()) {
                    this.$emit('patched', this.shipRole);
                }
            } else if (await this.create()) {
                this.$emit('created', this.shipRole);
            }
        },
        refreshData(): void {
            this.properties = getEmptyProperties();
            this.loadShipRole();
        },
        async loadShipRole(): Promise<void> {
            if (!this.shipRoleId) {
                return;
            }
            this.isLoading = true;
            try {
                this.shipRole = (await shipRoleService.getOneOrDefault(this.shipRoleId)).data;
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
                this.shipRole = (await shipRoleService.create(this.properties as CreateShipRole)).data;
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
                this.shipRole = (await shipRoleService.patch(
                    this.shipRoleId,
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
