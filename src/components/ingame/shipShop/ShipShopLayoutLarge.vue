<template>
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 821.47 731.17" class="ship-shop__layout ship-shop__layout--large">
        <defs>
            <template v-for="config in typedShipShopSpotConfigs" :key="config.id">
                <ShipShopLayoutSpotPattern
                    v-if="config.ship"
                    :config="config"
                />
            </template>
        </defs>
        <g id="large-ship-shop">
            <g id="large-ship-shop-2" data-name="large-ship-shop">
                <polygon
                    id="background"
                    class="ship-shop-layout__background"
                    points="821.47 90 821.47 549.57 640.1 549.57 640.1 731.17 180.3 731.17 180.3 549.57 0 549.57 0 90 180.28 90 180.28 48.82 228.3 0.8 229.1 0 591.6 0 593.37 1.77 640.65 49.04 640.65 90 821.47 90"
                />
                <g id="areas">
                    <rect class="ship-shop-layout__area-1" x="275.24" y="184.22" width="270.91" height="270.91" />
                    <rect class="ship-shop-layout__area-2" x="275.24" y="4.33" width="270.91" height="179.89" />
                    <rect class="ship-shop-layout__area-3" x="185.39" y="455.13" width="450.08" height="271.42" />
                    <polygon class="ship-shop-layout__area-4" points="275.24 93.93 275.24 455.13 185.39 455.13 185.39 545.7 4.04 545.7 4.04 93.93 275.24 93.93" />
                    <polygon class="ship-shop-layout__area-5" points="817.24 93.93 817.24 545.7 635.47 545.7 635.47 455.13 546.04 455.13 546.04 93.93 817.24 93.93" />
                    <text class="ship-shop-layout__area-label" x="382" y="140">Lobby</text>
                    <text class="ship-shop-layout__area-label" x="327" y="383">Central Showroom</text>
                    <text class="ship-shop-layout__area-label" x="327" y="595">Scenery Showroom</text>
                    <text class="ship-shop-layout__area-label" x="50" y="145">Hangar Showroom 1</text>
                    <text class="ship-shop-layout__area-label" x="590" y="145">Hangar Showroom 2</text>

                    <text class="ship-shop-layout__exit-label" transform="translate(290, 66) rotate(-90)">EXIT</text>
                    <text class="ship-shop-layout__exit-label" transform="translate(542, 66) rotate(-90)">EXIT</text>

                    <text class="ship-shop-layout__exit-label" transform="translate(202, 608) rotate(-90)">EXIT</text>
                    <text class="ship-shop-layout__exit-label" transform="translate(630, 608) rotate(-90)">EXIT</text>
                    <text class="ship-shop-layout__exit-label-lp" transform="translate(217, 633) rotate(-90)">LANDING PAD</text>
                    <text class="ship-shop-layout__exit-label-lp" transform="translate(615, 633) rotate(-90)">LANDING PAD</text>
                </g>
                <path
                    id="borders"
                    d="M275.74,454.63v-111h-1v111H253v1H386.47v-1Zm270.8,0v-111h-1v111H434v1H567.47v-1ZM344,183.72v1H477.47v-1ZM274.74,3.83V18.27h1V4.83H545.65V18.27h1V3.83Zm1,450.8v-111h-1v111H253v1H386.47v-1Zm270.8,0v-111h-1v111H434v1H567.47v-1ZM344,183.72v1H477.47v-1Zm-68.29,0V71.48h-1v22H253v1h21.71V296.09h1V184.72h20.73v-1Zm0,270.91v-111h-1v111H253v1H386.47v-1Zm-90.85,0V545.2H4.54V94.43H199.82v-1H3.54V546.2H184.89v13.89h1V455.63h19.58v-1ZM622,93.43v1H816.74V545.2H636V454.63H615v1H635V560.09h1V546.2H817.74V93.43ZM635,726.06H185.89V617.13h-1V727.06H636V617.13h-1ZM546.54,454.63v-111h-1v111H434v1H567.47v-1Zm.11-361.2v-22h-1V183.72H525v1h20.51V296.09h1V94.43h22.28v-1ZM275.74,454.63v-111h-1v111H253v1H386.47v-1Zm0,0v-111h-1v111H253v1H386.47v-1Zm270.8,0v-111h-1v111H434v1H567.47v-1Z"
                />
                <g id="spots">
                    <template v-for="config in typedShipShopSpotConfigs" :key="config.id">
                        <ShipShopLayoutSpot
                            v-if="!hiddenPositions.includes(config.id)"
                            :config="config"
                            @spotClicked="handleSpotClicked"
                        />
                    </template>
                </g>
            </g>
        </g>
    </svg>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { ShipShopSpotConfig } from '@/interfaces/ingame/shipShopSpot';
import ShipShopLayoutSpot from '@/components/ingame/shipShop/ShipShopLayoutSpot.vue';
import ShipShopLayoutSpotPattern from '@/components/ingame/shipShop/ShipShopLayoutSpotPattern.vue';

// <rect id="spot-([0-9]+)" class="ship-shop-layout__spot" x="([0-9\.]+)" y="([0-9\.]+)" width="([0-9\.]+)" height="([0-9\.]+)"[ ]*/>
// <g id="spot-$1" transform="translate($2, $3)"><rect class="ship-shop-layout__spot" width="$4" height="$5" /><text class="ship-shop-layout__spot-number" x="$4" y="$5">$1</text></g>
// {"id": "spot-$1", "class": "ship-shop-layout__spot", "x": $2, "y": $3, "sizes": [{ "size": 1, "width": $4, "height": $5 }] },
export default defineComponent({
    name: 'ShipShopLayoutLarge',
    emits: ['spotClicked'],
    components: {
        ShipShopLayoutSpot,
        ShipShopLayoutSpotPattern,
    },
    props: {
        shipShopSpotConfigs: {
            type: Array,
            required: true,
        },
    },
    computed: {
        typedShipShopSpotConfigs(): ShipShopSpotConfig[] {
            return this.shipShopSpotConfigs as ShipShopSpotConfig[];
        },
        hiddenPositions(): number[] {
            const hidden: number[] = [];
            this.typedShipShopSpotConfigs.forEach(({ spot, sizes }) => {
                if (spot) {
                    let size = sizes.find((fsize) => fsize.size === spot.size);
                    if (!size) [size] = sizes;

                    if (size.hides && size.hides.length > 0) {
                        hidden.push(...size.hides);
                    }
                }
            });
            return [...new Set(hidden)];
        },
    },
    methods: {
        handleSpotClicked(position: number): void {
            this.$emit('spotClicked', position);
        },
    },
});
</script>
