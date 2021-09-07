<template>
<div class="data-item" :class="classes" data-augmented-ui="tl-clip tr-clip br-clip bl-clip border">
    <slot></slot>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'DataItem',
    props: {
        clickable: {
            type: Boolean,
            default: false,
        },
    },
    computed: {
        classes(): Record<string, boolean> {
            return {
                'data-item--clickable': this.clickable,
            };
        },
    },
});
</script>
