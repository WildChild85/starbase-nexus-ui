<template>
    <svg class="loading-indicator-circle" xmlns="http://www.w3.org/2000/svg"
        xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 50 50" width="50" height="50" :style="styles">
        <circle class="loading-indicator-circle__path" :class="pathClasses" :style="pathStyles" cx="25" cy="25" r="22"/>
    </svg>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'LoadingIndicatorCircle',
    props: {
        size: {
            type: String,
            default: null,
        },
        strokeWidth: {
            type: String,
            default: null,
        },
    },
    computed: {
        styles(): Record<string, string> {
            const stylesObj: Record<string, string> = {};
            if (this.size) {
                stylesObj.height = this.size;
                stylesObj.width = this.size;
            }
            return stylesObj;
        },
        pathStyles(): Record<string, string> {
            const stylesObj: Record<string, string> = {};
            if (this.strokeWidth) {
                stylesObj.strokeWidth = this.strokeWidth;
            }
            return stylesObj;
        },
        pathClasses(): Record<string, boolean> {
            return {
            };
        },
    },
});
</script>
