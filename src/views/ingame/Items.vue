<template>
<div class="home">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <Panel>
            <div class="flex flex--end flex--wrap">
                <TextField v-model.trim="searchTerm" :placeholder="$t('search')" @keyup.enter="refreshData"/>
                <Button class="margin-left" :loading="isLoading" @click="refreshData">Refresh</Button>
                <Button class="margin-left" @click="showCreate" v-if="isModerator">Create</Button>
            </div>

            <DataItem v-for="item in items" :key="item.id" class="margin-top--f2">
                <div class="data-item__icon" :style="{ backgroundImage: `url(${item.iconUri})`}"></div>
                <div class="data-item__name">{{ item.name }}</div>
                <div class="data-item__spacer"></div>

                <template v-for="prop in Object.keys(item)">
                    <div class="data-item__property data-item__property--with-label" :key="prop" v-if="!excludedProperties.includes(prop) && item[prop] != null">
                        <div class="data-item__property-label">{{ $t(prop) }}</div>
                        <div class="data-item__property-value" v-html="numberToLocaleString(item[prop], 0, 6)"></div>
                    </div>
                </template>

                <div class="data-item__spacer"></div>
                <a class="data-item__action" :title="$t('wikiPage')" :href="item.wikiUri" target="_blank"><ExternalLinkIconOutline class="svg-icon"/></a>
                <div class="data-item__action" :title="$t('copyIdToClipboard')" @click="copyToClipboard(item.id)"><ClipboardCopyIconOutline class="svg-icon"/></div>
                <div class="data-item__action" :title="$t('edit')" v-if="isModerator" @click="showEdit(item.id)"><PencilIconSolid class="svg-icon"/></div>
            </DataItem>
        </Panel>
        <input class="input-copy-to-clipboard" :id="clipboardInputId" :value="textToCopy" />
    </div>
    <Dialog v-if="showEditDialog" @close="hideEditDialog">
        <EditItem
            :itemId="editId"
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
import EditItem from '@/components/ingame/item/EditItem.vue';
import * as itemService from '@/services/ingame/itemService';
import { Item } from '@/interfaces/ingame/item';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import DataItem from '@/components/layout/DataItem.vue';
import { ROLE_MODERATOR } from '@/constants/roles';
import { uniqueId, numberToLocaleString } from '@/helpers';

interface Data {
    searchTerm: string;
    showEditDialog: boolean;
    editId: string | null;
    isLoading: boolean;
    items: Item[];
    textToCopy: string;
}

export default defineComponent({
    name: 'Items',
    components: {
        Dialog,
        Button,
        Panel,
        TextField,
        EditItem,
        LoadingIndicatorBeam,
        DataItem,
    },
    mixins: [ViewMixin],
    data: (): Data => ({
        searchTerm: '',
        showEditDialog: false,
        editId: null,
        isLoading: false,
        items: [],
        textToCopy: '',
    }),
    computed: {
        clipboardInputId(): string {
            return `clipboardInput_${uniqueId}}`;
        },
        isModerator(): boolean {
            return this.$store.getters['authentication/hasOneRoles'](ROLE_MODERATOR);
        },
        excludedProperties(): string[] {
            return ['id', 'iconUri', 'createdAt', 'updatedAt', 'description', 'itemCategoryId', 'primaryMaterialId', 'name', 'wikiUri'];
        },
    },
    methods: {
        numberToLocaleString,
        copyToClipboard(text: string): void {
            this.textToCopy = text;
            const input = document.getElementById(this.clipboardInputId) as HTMLInputElement;

            this.$nextTick(() => {
                /* Select the text field */
                input.select();
                /* For mobile devices */
                input.setSelectionRange(0, 99999);

                document.execCommand('copy');

                this.$notify({
                    title: this.$t('copied'),
                    text: this.$t('idCopied'),
                    type: 'success',
                });
            });
        },
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
                this.loadItems();
            }
        },
        async refreshData(): Promise<void> {
            await this.loadItems();
        },
        async loadItems(): Promise<void> {
            this.isLoading = true;
            try {
                const response = await itemService.getMultiple({
                    pageSize: -1,
                    searchQuery: this.searchTerm,
                });
                this.items = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('items'), this.$t('ingame')]);
        this.refreshData();
    },
});
</script>
