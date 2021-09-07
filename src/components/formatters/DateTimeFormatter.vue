<template>
<span class="text--primary">{{ formattedDate }}</span>
&nbsp;
<span class="text--secondary">{{ formattedTime }}</span>
</template>

<script lang="ts">
import { DateTime } from 'luxon';
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'DateTimeFormatter',
    props: {
        isoString: {
            type: String,
            default: null,
        },
    },
    computed: {
        formattedDate(): string {
            const dateTime = DateTime.fromISO(this.isoString);
            return dateTime.toLocaleString({
                day: '2-digit',
                month: '2-digit',
                year: 'numeric',
            });
        },
        formattedTime(): string {
            const dateTime = DateTime.fromISO(this.isoString);
            return dateTime.toLocaleString({
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit',
            });
        },
    },
});
</script>
