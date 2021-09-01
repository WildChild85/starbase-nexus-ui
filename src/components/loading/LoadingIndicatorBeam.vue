<template>
<teleport to="#loading-indicator-beam-wrapper">
    <div class="loading-indicator-beam">
    </div>
</teleport>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'LoadingIndicatorBeam',
    props: {
    },
    computed: {
    },
});
</script>
