<template>
    <pattern
        :id="`spot-bg-${typedConfig.id}`"
        patternUnits="userSpaceOnUse"
        :width="configSize.width"
        :height="configSize.height"
    >
        <image
            preserveAspectRatio="xMidYMid slice"
            :href="config.ship.previewImageUri"
            :x="0"
            :y="0"
            :width="configSize.width"
            :height="configSize.height"
        />
    </pattern>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { ShipShopSpot, ShipShopSpotConfig, ShipShopSpotConfigSize } from '@/interfaces/ingame/shipShopSpot';

export default defineComponent({
    name: 'ShipShopLayoutSpotPattern',
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
        configSize(): ShipShopSpotConfigSize {
            if (this.typedConfig.spot) {
                const spot = this.typedConfig.spot as ShipShopSpot;
                const size = this.typedConfig.sizes.find((fsize) => fsize.size === spot.size);
                if (size) return size;
            }
            return this.typedConfig.sizes[0];
        },
    },
});
</script>
