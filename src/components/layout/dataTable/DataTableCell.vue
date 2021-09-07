<template>
<td :class="classes">
    <slot></slot>
</td>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'DataTableCell',
    props: {
        type: String,
        default: null,
    },
    computed: {
        classes(): Record<string, boolean> {
            return {
                'data-table__cell--success': this.type === 'success',
                'data-table__cell--warning': this.type === 'warning',
                'data-table__cell--error': this.type === 'error',
                'data-table__cell--info': this.type === 'info',
            };
        },
    },
});
</script>
