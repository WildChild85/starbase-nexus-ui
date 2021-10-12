<template>
<div class="simple-select" :class="classes">
    <label v-if="label" :for="id">
        {{ label }}
        <span class="text--primary" v-if="required">*</span>
    </label>
    <div class="simple-select__wrapper" data-augmented-ui="tl-clip bl-clip tr-clip br-clip border">
        <button class="simple-select__value" @click="expanded = !expanded">
            <div class="simple-select__value-label">{{ valueLabel }}</div>
            <div class="simple-select__chevron"><ChevronDownIconSolid class="svg-icon"/></div>
        </button>
        <div class="simple-select__options">
            <template
                v-for="option in typedOptions"
                :key="option.value"
            >
                <button
                    v-if="modelValue != option.value"
                    class="simple-select__option"
                    @click="emitInput(option.value)"
                >{{ option.label }}</button>
                <div v-else class="simple-select__option simple-select__option--selected">{{ option.label }}</div>
            </template>
        </div>
    </div>
    <div class="simple-select__error" v-for="error in errors" :key="error">{{ error }}</div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { SelectOption } from '@/interfaces/ui';
import { uniqueId } from '@/helpers';

export default defineComponent({
    name: 'SimpleSelect',
    emits: ['update:modelValue'],
    data: () => ({
        id: '',
        expanded: false,
    }),
    props: {
        modelValue: {
            default: null,
        },
        options: {
            type: Array,
            default: () => [],
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
        errors: {
            type: Array,
            default: (): string[] => [],
        },
    },
    computed: {
        typedOptions(): SelectOption[] {
            return this.options as SelectOption[];
        },
        valueLabel(): string {
            const selectedItem = this.typedOptions.find(({ value }) => value === this.modelValue);
            if (selectedItem) {
                return selectedItem.label;
            }
            return '';
        },
        classes(): Record<string, boolean> {
            return {
                'simple-select--expanded': this.expanded,
                'simple-select--disabled': this.disabled,
                'simple-select--readonly': this.readonly,
                'simple-select--error': this.errors.length > 0,
            };
        },
    },
    methods: {
        emitInput(value: string | null): void {
            this.$emit('update:modelValue', value);
            this.expanded = false;
        },
    },
    created() {
        this.id = uniqueId();
    },
});
</script>
