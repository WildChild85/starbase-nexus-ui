<template>
<div class="number-adjuster">
    <button class="number-adjuster__decrease" data-augmented-ui="tl-clip bl-clip tr-clip br-clip border" @click="decrease">-</button>
    <div class="number-adjuster__value">{{ modelValue }}</div>
    <button class="number-adjuster__increase" data-augmented-ui="tl-clip bl-clip tr-clip br-clip border" @click="increase">+</button>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    name: 'NumberAdjuster',
    emits: ['update:modelValue'],
    props: {
        modelValue: {
            type: Number,
            default: 0,
        },
        min: {
            type: Number,
            default: 0,
        },
        max: {
            type: Number,
            default: null,
        },
    },
    methods: {
        decrease(): void {
            if (this.modelValue > this.min) {
                this.$emit('update:modelValue', this.modelValue - 1);
            }
        },
        increase(): void {
            if (this.max === null || this.modelValue < this.max) {
                this.$emit('update:modelValue', this.modelValue + 1);
            }
        },
    },
});
</script>
