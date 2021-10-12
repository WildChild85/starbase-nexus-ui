<template>
<div class="switch" :class="classes" @click="emitInput(!modelValue)">
    <button class="switch__wrapper">
        <div class="switch__area" data-augmented-ui="tl-clip bl-clip tr-clip br-clip border">
            <div data-augmented-reset>
                <div class="switch__state" data-augmented-ui="tl-clip bl-clip tr-clip br-clip none"></div>
            </div>
        </div>
        <label v-if="label" :for="id">
            {{ label }}
            <span class="text--primary" v-if="required">*</span>
        </label>
    </button>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { uniqueId } from '@/helpers';

export default defineComponent({
    name: 'Switch',
    emits: ['update:modelValue'],
    data: () => ({
        id: '',
        expanded: false,
    }),
    props: {
        modelValue: {
            type: Boolean,
            default: null,
        },
        label: {
            type: String,
            default: null,
        },
        required: {
            type: Boolean,
            default: false,
        },
        disabled: {
            type: Boolean,
            default: false,
        },
        readonly: {
            type: Boolean,
            default: false,
        },
    },
    computed: {
        classes(): Record<string, boolean> {
            return {
                'switch--active': this.modelValue,
                'switch--disabled': this.disabled,
                'switch--readonly': this.readonly,
            };
        },
    },
    methods: {
        emitInput(value: boolean | null): void {
            if (this.disabled || this.readonly) return;
            this.$emit('update:modelValue', value);
        },
    },
    created() {
        this.id = uniqueId();
    },
});
</script>
