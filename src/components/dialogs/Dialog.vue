<template>
<teleport to="#dialogs">
    <div class="dialog" :class="classes">
        <Overlay />
        <div class="dialog__content">
            <slot></slot>
        </div>
    </div>
</teleport>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Overlay from '@/components/dialogs/Overlay.vue';

export default defineComponent({
    name: 'Dialog',
    components: {
        Overlay,
    },
    emits: ['close'],
    props: {
        position: {
            type: String,
            default: null,
        },
        fullWidth: {
            type: Boolean,
            default: false,
        },
    },
    computed: {
        classes(): Record<string, boolean> {
            return {
                'dialog--pull-left': this.position === 'left',
                'dialog--full-width': this.fullWidth,
            };
        },
    },
    methods: {
        handleCLose(event: Event): void {
            event.stopPropagation();
            this.$emit('close');
        },
    },
});
</script>
