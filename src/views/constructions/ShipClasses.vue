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

            <DataItem v-for="shipClass in shipClasses" :key="shipClass.id" class="margin-top--f2">
                <div class="data-item__name">{{ shipClass.name }}</div>
                <div class="data-item__spacer"></div>
                <div class="data-item__action" v-if="isModerator" @click="showEdit(shipClass.id)"><PencilIconSolid class="svg-icon"/></div>
            </DataItem>
        </Panel>
    </div>
    <Dialog v-if="showEditDialog" @close="hideEditDialog">
        <EditShipClass
            :shipClassId="editId"
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
import EditShipClass from '@/components/constructions/shipClass/EditShipClass.vue';
import * as shipClassService from '@/services/constructions/shipClassService';
import { ShipClass } from '@/interfaces/constructions/shipClass';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import DataItem from '@/components/layout/DataItem.vue';
import { ROLE_MODERATOR } from '@/constants/roles';

interface Data {
    searchTerm: string;
    showEditDialog: boolean;
    editId: string | null;
    isLoading: boolean;
    shipClasses: ShipClass[];
}

export default defineComponent({
    name: 'ShipClasses',
    components: {
        Dialog,
        Button,
        Panel,
        TextField,
        EditShipClass,
        LoadingIndicatorBeam,
        DataItem,
    },
    mixins: [ViewMixin],
    data: (): Data => ({
        searchTerm: '',
        showEditDialog: false,
        editId: null,
        isLoading: false,
        shipClasses: [],
    }),
    computed: {
        isModerator(): boolean {
            return this.$store.getters['authentication/hasOneRoles'](ROLE_MODERATOR);
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
                this.loadShipClasses();
            }
        },
        async refreshData(): Promise<void> {
            await this.loadShipClasses();
        },
        async loadShipClasses(): Promise<void> {
            this.isLoading = true;
            try {
                const response = await shipClassService.getMultiple({
                    pageSize: -1,
                    searchQuery: this.searchTerm,
                    orderBy: 'name asc',
                });
                this.shipClasses = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('shipClasses'), this.$t('constructions')]);
        this.refreshData();
    },
});
</script>
