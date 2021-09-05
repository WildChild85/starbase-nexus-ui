<template>
<span v-html="formatted"></span>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { Duration } from 'luxon';

export default defineComponent({
    name: 'DurationFormatter',
    props: {
        seconds: {
            type: Number,
            default: 0,
        },
    },
    computed: {
        formatted(): string {
            return Duration.fromObject({ seconds: this.seconds }).toFormat('hh:mm:ss');
        },
    },
});
</script>
