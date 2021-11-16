<template>
<div class="panel" :class="classes" data-augmented-ui="tl-2-clip-x tr-clip br-2-clip-x bl-clip border">
    <div data-augmented-ui-reset>
        <slot></slot>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'Panel',
    props: {
        noPadding: {
            type: Boolean,
            default: false,
        },
        fitToScreen: {
            type: Boolean,
            default: false,
        },
        fullWidth: {
            type: Boolean,
            default: false,
        },
    },
    computed: {
        classes(): Record<string, boolean> {
            return {
                'panel--no-padding': this.noPadding,
                'panel--fit-to-screen': this.fitToScreen,
                'panel--full-width': this.fullWidth,
            };
        },
    },
});
</script>
