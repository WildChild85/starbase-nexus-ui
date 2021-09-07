<template>
<div class="overlay">
    <slot></slot>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'Overlay',
});
</script>
