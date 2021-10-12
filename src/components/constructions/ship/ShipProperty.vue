<template>
<div class="ship__property">
    <div class="ship__property-icon" v-if="iconUri" :style="iconStyle"></div>
    <div class="ship__property-value">
        <DurationFormatter v-if="formatDuration && value" :seconds="value * 60"/>
        <span v-else v-html="formattedValue"></span>
    </div>
    <div class="ship__property-name">{{ title }}</div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { numberToLocaleString } from '@/helpers';
import DurationFormatter from '@/components/formatters/DurationFormatter.vue';

export default defineComponent({
    name: 'ShipProperty',
    components: {
        DurationFormatter,
    },
    props: {
        iconUri: {
            type: String,
            default: null,
        },
        title: {
            type: String,
            required: true,
        },
        value: {
            required: true,
        },
        formatNumber: {
            type: Boolean,
            default: false,
        },
        formatDuration: {
            type: Boolean,
            default: false,
        },
    },
    computed: {
        iconStyle(): Record<string, string> {
            return {
                backgroundImage: this.iconUri !== 'keep' ? `url('${this.iconUri}')` : '',
            };
        },
        formattedValue(): unknown {
            if (this.value) {
                if (this.formatNumber) return numberToLocaleString(this.value as number, 0);
                return this.value;
            }
            return 'n/a';
        },
    },
});
</script>
