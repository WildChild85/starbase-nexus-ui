<template>
<div class="home">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <Panel>
            <div class="flex flex--end flex--wrap">
                <TextField v-model.trim="searchTerm" :placeholder="$t('search')" @keyup.enter="refreshData"/>
                <Button class="margin-left" :loading="isLoading" @click="refreshData">{{ $t('refresh') }}</Button>
                <Button class="margin-left" v-if="isModerator" @click="showCreate">{{ $t('create') }}</Button>
            </div>

            <DataItem v-for="shipRole in shipRolees" :key="shipRole.id" class="margin-top--f2">
                <div class="data-item__name">{{ shipRole.name }}</div>
                <div class="data-item__spacer"></div>
                <div class="data-item__action" v-if="isModerator" @click="showEdit(shipRole.id)"><PencilIconSolid class="svg-icon"/></div>
            </DataItem>
        </Panel>
    </div>
    <Dialog v-if="showEditDialog" @close="hideEditDialog">
        <EditShipRole
            :shipRoleId="editId"
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
import EditShipRole from '@/components/constructions/shipRole/EditShipRole.vue';
import * as shipRoleService from '@/services/constructions/shipRoleService';
import { ShipRole } from '@/interfaces/constructions/shipRole';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import DataItem from '@/components/layout/DataItem.vue';
import { ROLE_MODERATOR } from '@/constants/roles';

interface Data {
    searchTerm: string;
    showEditDialog: boolean;
    editId: string | null;
    isLoading: boolean;
    shipRolees: ShipRole[];
}

export default defineComponent({
    name: 'ShipRoles',
    components: {
        Dialog,
        Button,
        Panel,
        TextField,
        EditShipRole,
        LoadingIndicatorBeam,
        DataItem,
    },
    mixins: [ViewMixin],
    data: (): Data => ({
        searchTerm: '',
        showEditDialog: false,
        editId: null,
        isLoading: false,
        shipRolees: [],
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
                this.loadShipRolees();
            }
        },
        async refreshData(): Promise<void> {
            await this.loadShipRolees();
        },
        async loadShipRolees(): Promise<void> {
            this.isLoading = true;
            try {
                const response = await shipRoleService.getMultiple({
                    pageSize: -1,
                    searchQuery: this.searchTerm,
                    orderBy: 'name asc',
                });
                this.shipRolees = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('shipRoles'), this.$t('constructions')]);
        this.refreshData();
    },
});
</script>
