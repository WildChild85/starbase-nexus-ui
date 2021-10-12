<template>
<div class="ship-shops">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <Panel>
            <div class="flex flex--end flex--wrap">
                <TextField v-model.trim="searchTerm" :placeholder="$t('search')" @keyup.enter="refreshData"/>
                <Button class="margin-left" :loading="isLoading" @click="refreshData">{{ $t('refresh') }}</Button>
                <Button class="margin-left" v-if="isModerator" type="info" :to="{name: 'ingame_ship-shop_create'}">{{ $t('create') }}</Button>
            </div>

            <div class="ship-shop-list">
                <ShipShopListItem
                    v-for="shipShop in shipShops"
                    :key="shipShop.id"
                    :shipShop="shipShop"
                    class="margin-top--f2"
                >
                </ShipShopListItem>
            </div>
        </Panel>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Panel from '@/components/layout/Panel.vue';
import ViewMixin from '@/mixins/ViewMixin';
import TextField from '@/components/controls/TextField.vue';
import Button from '@/components/controls/Button';
import * as shipShopService from '@/services/ingame/shipShopService';
import { ShipShop } from '@/interfaces/ingame/shipShop';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import ShipShopListItem from '@/components/ingame/shipShop/ShipShopListItem.vue';
import { redirectToDiscord } from '@/helpers/index';
import { JwtUser } from '@/interfaces/identity/user';
import { ROLE_MODERATOR } from '@/constants/roles';

interface Data {
    searchTerm: string;
    isLoading: boolean;
    shipShops: ShipShop[];
}

export default defineComponent({
    name: 'ShipShops',
    components: {
        Button,
        Panel,
        TextField,
        LoadingIndicatorBeam,
        ShipShopListItem,
    },
    mixins: [ViewMixin],
    data: (): Data => ({
        searchTerm: '',
        isLoading: false,
        shipShops: [],
    }),
    computed: {
        user(): JwtUser | null {
            return this.$store.getters['authentication/user'];
        },
        isModerator(): boolean {
            return this.$store.getters['authentication/hasOneRoles'](ROLE_MODERATOR);
        },
    },
    methods: {
        redirectToDiscord,
        async refreshData(): Promise<void> {
            await this.loadShipShops();
        },
        async loadShipShops(): Promise<void> {
            this.isLoading = true;
            try {
                const response = await shipShopService.getMultiple({
                    pageSize: -1,
                    searchQuery: this.searchTerm,
                    orderBy: 'name asc',
                });
                this.shipShops = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('shipShops'), this.$t('ingame')]);
        this.refreshData();
    },
});
</script>
