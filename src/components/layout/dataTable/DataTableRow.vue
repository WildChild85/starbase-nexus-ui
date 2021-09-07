<template>
<tr data-augmented-ui="tl-clip tr-clip br-clip bl-clip border">
    <slot></slot>
</tr>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'DataTableRow',
});
</script>
