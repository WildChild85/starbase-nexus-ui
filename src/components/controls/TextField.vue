<template>
<div class="text-field" :class="classes">
    <label v-if="label" :for="id">
        {{ label }}
        <span class="text--primary" v-if="required">*</span>
    </label>
    <div class="text-field__input" data-augmented-ui="tl-clip tr-clip br-clip bl-clip border">
        <input
            :id="id"
            :type="type"
            :maxlength="maxLength"
            :min="min"
            :max="max"
            :placeholder="placeholder"
            :value="modelValue"
            :disabled="disabled"
            :readonly="readonly"
            @input="emitInput"
            @focus="emitFocus"
            @blur="emitBlur"
        >
    </div>
    <div class="text-field__error" v-for="error in errors" :key="error">{{ error }}</div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { uniqueId } from '@/helpers';
import { DEFAULT_TEXT_MAX_LENGTH } from '@/constants/app';

export default defineComponent({
    name: 'TextField',
    emits: ['update:modelValue', 'focus', 'blur', 'enter'],
    props: {
        modelValue: {
            default: null,
        },
        type: {
            type: String,
            default: 'text',
        },
        maxLength: {
            type: Number,
            default: DEFAULT_TEXT_MAX_LENGTH,
        },
        min: {
            type: Number,
            default: null,
        },
        max: {
            type: Number,
            default: null,
        },
        label: {
            type: String,
            default: null,
        },
        placeholder: {
            type: String,
            default: null,
        },
        disabled: {
            type: Boolean,
            default: false,
        },
        readonly: {
            type: Boolean,
            default: false,
        },
        required: {
            type: Boolean,
            default: false,
        },
        errors: {
            type: Array,
            default: (): string[] => [],
        },
    },
    data: () => ({
        id: '',
        isFocused: false,
    }),
    computed: {
        classes(): Record<string, boolean> {
            return {
                'text-field--disabled': this.disabled,
                'text-field--readonly': this.readonly,
                'text-field--error': this.errors.length > 0,
                'text-field--focused': this.isFocused,
            };
        },
    },
    methods: {
        emitInput(event: InputEvent): void {
            const target = event.target as HTMLInputElement;
            this.$emit('update:modelValue', target.value);
        },
        emitFocus(event: Event) {
            this.isFocused = true;
            this.$emit('focus', event);
        },
        emitBlur(event: Event) {
            this.isFocused = false;
            this.$emit('blur', event);
        },
    },
    mounted() {
        this.id = uniqueId();
    },
});
</script>
