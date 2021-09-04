<template>
<teleport to="#dialogs">
    <div class="aside">
        <Overlay />
        <div class="aside__content">
            <slot></slot>
        </div>
    </div>
</teleport>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Overlay from '@/components/dialogs/Overlay.vue';

export default defineComponent({
    name: 'Aside',
    components: {
        Overlay,
    },
    emits: ['close'],
    methods: {
        handleCLose(event: Event): void {
            event.stopPropagation();
            this.$emit('close');
        },
    },
});
</script>
