<template>
<table class="data-table">
    <slot></slot>
</table>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'DataTable',
});
</script>
