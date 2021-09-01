<template>
<div class="panel" data-augmented-ui="tl-2-clip-x tr-clip br-2-clip-x bl-clip border">
    <div data-augmented-ui-reset>
        <slot></slot>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'Panel',
});
</script>
