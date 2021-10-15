<template>
<div class="ship-shop">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <div
            class="flex flex--stretch-vertical"
            :class="showEdit || !shipShopId ? 'flex--space-between-children flex--wrap-lg' : ''"
        >
            <Panel class="flex__item flex__item--w-50-lg">
                <EditShipShop
                    v-if="showEdit || !shipShopId"
                    :shipShopId="shipShopId"
                    ref="editShipShop"
                    @created="handleCreated"
                    @patched="handlePatched"
                    @cancelled="handleCancelled"
                    @update:description="handleUpdateDescription"
                />
                <template v-else>
                    <div class="ship-shop__meta">
                        <div
                            class="ship-shop__image"
                            data-augmented-ui="tl-clip t-clip-x tr-clip r-clip-y br-clip b-clip-x bl-clip l-clip-y border"
                            :style="imageStyle"
                        ></div>
                        <div class="ship-shop__meta-content">
                            <div class="ship-shop__header">
                                <h1 class="ship-shop__name">{{ shipShop ? shipShop.name : '' }}</h1>
                                <template v-if="isModerator">
                                    <Switch v-model="spotsEditMode" :label="$t('editSpots')" />
                                    <Button :title="$t('edit')" @click="showEdit = true"><PencilAltIconSolid class="svg-icon"/></Button>
                                </template>
                            </div>
                            <div class="ship-shop__description">
                                <p><strong>{{ $t('moderator') }}</strong>: {{ moderator ? moderator.userName : $t('unassigned') }}</p>
                                <Markdown
                                    v-if="shipShop"
                                    :source="shipShop.description"
                                    :plugins="markdownPlugins"
                                />
                            </div>
                        </div>
                    </div>
                    <ShipShopLayoutLarge
                        :key="mapRerenderKey"
                        class="margin-top"
                        :shipShopSpotConfigs="configsShipsMap"
                        @spotClicked="handleSpotClicked"
                    />
                </template>
            </Panel>
            <Panel class="flex__item flex__item--w-50-lg" v-if="!shipShopId || showEdit">
                <div>
                    <h2 class="text--primary">Rules for creating a shipShop</h2>
                    <ol>
                        <li>Only create a Ship Shop, if it is actually inside the game.</li>
                        <li>This website is a neutral space. Describe the shop in the description as honest as possible.</li>
                        <li>The about us supports markdown (<a href="https://en.wikipedia.org/wiki/Markdown" target="_blank">Wikipedia</a>).</li>
                    </ol>
                    <div class="ship-shop__description" style="margin-top: 210px">
                        <h2>{{ $t('descriptionMD') }} ({{ $t('preview') }})</h2>
                        <Markdown
                            :source="editDescription"
                            :plugins="markdownPlugins"
                        />
                    </div>
                </div>
            </Panel>
            <Dialog v-if="showSpotDialog">
                <EditShipShopSpot
                    :shipShopSpotId="spotEditId"
                    :position="spotEditPosition"
                    :shipShopId="shipShopId"
                    :shipShopSpotConfigs="configsShipsMap"
                    ref="editShipShopSpot"
                    @created="hideEditSpot(true)"
                    @patched="hideEditSpot(true)"
                    @cancelled="hideEditSpot(false)"
                />
            </Dialog>
        </div>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Markdown from 'vue3-markdown-it';
import MarkdownAbbr from 'markdown-it-abbr';
import MarkdownAnchor from 'markdown-it-anchor';
import MarkdownDeflist from 'markdown-it-deflist';
import MarkdownEmoji from 'markdown-it-emoji';
import MarkdownFootnote from 'markdown-it-footnote';
import MarkdownHighlightJs from 'markdown-it-highlightjs';
import MarkdownIns from 'markdown-it-ins';
import MarkdownMark from 'markdown-it-mark';
import MarkdownSub from 'markdown-it-sub';
import MarkdownSup from 'markdown-it-sup';
import MarkdownTaskLists from 'markdown-it-task-list';
import MarkdownTocDoneRight from 'markdown-it-toc-done-right';

import Panel from '@/components/layout/Panel.vue';
import ViewMixin from '@/mixins/ViewMixin';
import * as shipShopService from '@/services/ingame/shipShopService';
import * as shipShopSpotService from '@/services/ingame/shipShopSpotService';
import * as shipService from '@/services/constructions/shipService';
import * as publicUserService from '@/services/social/publicUserService';
import { ShipShop } from '@/interfaces/ingame/shipShop';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import EditShipShop from '@/components/ingame/shipShop/EditShipShop.vue';
import ShipShopLayoutLarge from '@/components/ingame/shipShop/ShipShopLayoutLarge.vue';
import EditShipShopSpot from '@/components/ingame/shipShopSpot/EditShipShopSpot.vue';
import 'highlight.js';
import 'highlight.js/styles/monokai.css';
import { JwtUser } from '@/interfaces/identity/user';
import Button from '@/components/controls/Button';
import { ROLE_MODERATOR } from '@/constants/roles';
import { ShipShopSpot, ShipShopSpotConfig } from '@/interfaces/ingame/shipShopSpot';
import Dialog from '@/components/dialogs/Dialog.vue';
import shipShopSpotConfigs from '@/components/ingame/shipShop/ship-shop-large-spot-configs.json';
import { Ship } from '@/interfaces/constructions/ship';
import { uniqueId } from '@/helpers';
import Switch from '@/components/controls/Switch.vue';
import { PublicUser } from '@/interfaces/social/publicUser';

interface Data {
    isLoading: boolean;
    shipShop: ShipShop | null;
    moderator: PublicUser | null;
    showEdit: boolean;
    editDescription: string;
    spotsEditMode: boolean;
    showSpotDialog: boolean;
    spotEditId: string | null;
    spotEditPosition: number;
    spots: ShipShopSpot[];
    ships: Ship[];
    configsShipsMap: ShipShopSpotConfig[];
    mapRerenderKey: string;
}

export default defineComponent({
    name: 'ShipShop',
    components: {
        Button,
        Dialog,
        EditShipShop,
        EditShipShopSpot,
        Markdown,
        Panel,
        LoadingIndicatorBeam,
        ShipShopLayoutLarge,
        Switch,
    },
    mixins: [ViewMixin],
    props: {
        shipShopId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        isLoading: false,
        shipShop: null,
        moderator: null,
        showEdit: false,
        editDescription: '',
        spotsEditMode: false,
        showSpotDialog: false,
        spotEditId: null,
        spotEditPosition: 1,
        spots: [],
        ships: [],
        configsShipsMap: [],
        mapRerenderKey: uniqueId(),
    }),
    watch: {
        shipShopId(): void {
            this.shipShop = null;
            this.moderator = null;
            this.refreshData();
        },
    },
    computed: {
        isModerator(): boolean {
            return this.$store.getters['authentication/hasOneRoles']([ROLE_MODERATOR]) || (this.user && this.shipShop && this.shipShop.moderatorId === this.user.id);
        },
        user(): JwtUser | null {
            return this.$store.getters['authentication/user'];
        },
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        markdownPlugins(): Record<string, any>[] {
            return [
                { plugin: MarkdownAbbr },
                { plugin: MarkdownAnchor },
                { plugin: MarkdownDeflist },
                { plugin: MarkdownEmoji },
                { plugin: MarkdownFootnote },
                { plugin: MarkdownHighlightJs },
                { plugin: MarkdownMark },
                { plugin: MarkdownIns },
                { plugin: MarkdownSub },
                { plugin: MarkdownSup },
                { plugin: MarkdownTaskLists },
                { plugin: MarkdownTocDoneRight },
            ];
        },
        imageStyle(): Record<string, string> {
            return {
                backgroundImage: this.shipShop && this.shipShop.imageUri ? `url('${this.shipShop.imageUri}')` : '',
            };
        },
        spotsMap(): Record<string, ShipShopSpot> {
            const map: Record<string, ShipShopSpot> = {};
            this.spots.forEach((spot) => {
                map[`spot-${spot.position}`] = spot;
            });
            return map;
        },
    },
    methods: {
        handleSpotClicked(position: number): void {
            const spot = this.spotsMap[`spot-${position}`];
            if (this.spotsEditMode) {
                this.showEditSpot(spot, position);
            } else if (spot.shipId) {
                const routeData = this.$router.resolve({
                    name: 'constructions_ship',
                    params: {
                        shipId: spot.shipId,
                    },
                });
                window.open(routeData.href, '_blank');
            }
        },
        showEditSpot(spot: ShipShopSpot | null, position: number): void {
            this.spotEditId = spot ? spot.id : null;
            this.spotEditPosition = position;
            this.showSpotDialog = true;
        },
        hideEditSpot(withRefresh = false): void {
            this.spotEditId = null;
            this.spotEditPosition = 1;
            this.showSpotDialog = false;
            if (withRefresh) {
                this.refreshData();
            }
        },
        handleUpdateDescription(description: string): void {
            this.editDescription = description;
        },
        handleCreated(shipShop: ShipShop): void {
            this.$router.push({
                name: 'ingame_ship-shop',
                params: {
                    shipShopId: shipShop.id,
                },
            });
        },
        handlePatched(): void {
            this.showEdit = false;
            this.refreshData();
        },
        handleCancelled(): void {
            this.showEdit = false;
            if (!this.shipShopId) {
                this.$router.push({ name: 'ingame_ship-shops' });
            }
        },
        async refreshData(): Promise<void> {
            await this.loadShipShop();
            await this.loadShipShopSpots();
            await this.loadShips();
            await this.loadModerator();
            const configsShipsMap: ShipShopSpotConfig[] = [];
            shipShopSpotConfigs.forEach((config) => {
                const spot: ShipShopSpot | null = this.spots.find(({ position }) => position === config.id) || null;
                let ship: Ship | null = null;
                if (spot && spot.shipId) {
                    ship = this.ships.find((fship) => fship.id === spot.shipId) || null;
                }
                const newConfig: ShipShopSpotConfig = {
                    ...config,
                    spot,
                    ship,
                };
                configsShipsMap.push(newConfig);
            });
            this.configsShipsMap = configsShipsMap;
            this.mapRerenderKey = uniqueId();
        },
        async loadShipShop(): Promise<void> {
            if (!this.shipShopId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await shipShopService.getOneOrDefault(this.shipShopId);
                this.shipShop = response.data;
                this.setPageTitle([this.shipShop.name, this.$t('shipShop'), this.$t('ingame')]);
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadModerator(): Promise<void> {
            if (!this.shipShop || !this.shipShop.moderatorId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await publicUserService.getOneOrDefault(this.shipShop.moderatorId);
                this.moderator = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadShipShopSpots(): Promise<void> {
            if (!this.shipShopId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await shipShopSpotService.getMultiple({
                    shipShopIds: this.shipShopId,
                    pageSize: -1,
                    orderBy: 'position asc',
                });
                this.spots = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadShips(): Promise<void> {
            const spotsWithShips = this.spots.filter(({ shipId }) => shipId !== null);
            const shipIds = spotsWithShips.map(({ shipId }) => shipId);
            if (shipIds.length === 0) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await shipService.getMultipleByIds(shipIds as string[]);
                this.ships = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('shipShop'), this.$t('ingame')]);
        this.refreshData();
    },
});
</script>
