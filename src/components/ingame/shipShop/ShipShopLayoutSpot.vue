<template>
<g
    :id="`${typedConfig.id}`"
    :transform="`translate(${typedConfig.x}, ${typedConfig.y})`"
    class="ship-shop-layout__spot-wrapper"
    @click="emitSpotClicked()"
>
    <rect
        class="ship-shop-layout__spot"
        :class="classesSpot"
        :width="configSize.width"
        :height="configSize.height"
        :fill="fill"
    />
    <text
        class="ship-shop-layout__spot-number"
        :class="classesSpotNumber"
        :x="xSpotNumber"
        :y="ySpotNumber"
    >{{ typedConfig.id }}</text>
    <title>{{ typedConfig.ship ? typedConfig.ship.name : $t('empty') }}</title>
</g>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { ShipShopSpot, ShipShopSpotConfig, ShipShopSpotConfigSize } from '@/interfaces/ingame/shipShopSpot';

export default defineComponent({
    name: 'ShipShopLayoutSpot',
    emits: ['spotClicked'],
    props: {
        config: {
            type: Object,
            required: true,
        },
    },
    computed: {
        typedConfig(): ShipShopSpotConfig {
            return this.config as ShipShopSpotConfig;
        },
        fill(): string | null {
            return this.typedConfig.ship ? `url(#spot-bg-${this.typedConfig.id})` : null;
        },
        position(): number {
            return this.config.id;
        },
        configSize(): ShipShopSpotConfigSize {
            if (this.typedConfig.spot) {
                const spot = this.typedConfig.spot as ShipShopSpot;
                const size = this.typedConfig.sizes.find((fsize) => fsize.size === spot.size);
                if (size) return size;
            }
            return this.typedConfig.sizes[0];
        },
        classesSpot(): Record<string, boolean> {
            return {
                'ship-shop-layout__spot--empty': !this.typedConfig.ship,
            };
        },
        classesSpotNumber(): Record<string, boolean> {
            return {
                'ship-shop-layout__spot-number--empty': !this.typedConfig.ship,
            };
        },
        xSpotNumber(): number {
            return this.configSize.width / 2;
        },
        ySpotNumber(): number {
            return this.configSize.height / 2;
        },
    },
    methods: {
        emitSpotClicked(): void {
            this.$emit('spotClicked', this.position);
        },
    },
});
</script>
