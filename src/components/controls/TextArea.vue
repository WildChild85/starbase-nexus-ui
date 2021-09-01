<template>
<div class="text-area" :class="classes">
    <label v-if="label" :for="id">
        {{ label }}
        <span class="text--primary" v-if="required">*</span>
    </label>
    <div class="text-area__input" data-augmented-ui="tl-clip tr-clip br-clip bl-clip border">
        <textarea :id="id"
                :maxlength="maxLength"
                :placeholder="placeholder"
                :value="modelValue"
                :disabled="disabled"
                :readonly="readonly"
                @input="emitInput"
                @focus="emitFocus"
                @blur="emitBlur"
        ></textarea>
    </div>
    <div class="text-area__error" v-for="error in errors" :key="error">{{ error }}</div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { uniqueId } from '@/helpers';
import { DEFAULT_TEXT_MAX_LENGTH } from '@/constants/app';

export default defineComponent({
    name: 'TextArea',
    emits: ['update:modelValue', 'focus', 'blur', 'enter'],
    props: {
        modelValue: {
            default: null,
        },
        maxLength: {
            type: Number,
            default: DEFAULT_TEXT_MAX_LENGTH,
        },
        label: {
            type: String,
            default: undefined,
        },
        placeholder: {
            type: String,
            default: undefined,
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
                'text-area--disabled': this.disabled,
                'text-area--readonly': this.readonly,
                'text-area--error': this.errors.length > 0,
                'text-area--focused': this.isFocused,
            };
        },
    },
    methods: {
        emitInput(event: InputEvent): void {
            const target = event.target as HTMLInputElement;
            target.style.cssText = 'height:auto';
            target.style.cssText = `height:${target.scrollHeight}px`;
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
