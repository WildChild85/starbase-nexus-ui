<template>
<router-link
    :to="{name: 'ingame_ship-shop', params: { shipShopId: shipShop.id }}"
    class="ship-shop-list-item"
    data-augmented-ui="tl-clip tr-clip br-clip bl-clip border"
>
    <div class="ship-shop-list-item__image" :style="imageStyle"></div>
    <div class="ship-shop-list-item__name">{{ shipShop.name }}</div>

</router-link>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { ShipShop } from '@/interfaces/ingame/shipShop';

export default defineComponent({
    name: 'ShipShopListItem',
    props: {
        shipShop: {
            type: Object,
            required: true,
        },
    },
    computed: {
        typedShipShop(): ShipShop {
            return this.shipShop as ShipShop;
        },
        imageStyle(): Record<string, string> {
            return {
                backgroundImage: this.typedShipShop && this.typedShipShop.imageUri ? `url('${this.typedShipShop.imageUri}')` : '',
            };
        },
    },
});
</script>
