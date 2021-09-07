<template>
<div class="select-single-reference" :class="classes">
    <div class="select-single-reference__label" v-if="label">
        {{ label }}
        <span class="text--primary" v-if="required">*</span>
    </div>
    <div class="select-single-reference__input" data-augmented-ui="tl-clip tr-clip br-clip bl-clip border">
        <div class="select-single-reference__value-wrapper">
            <div class="select-single-reference__value" @click="handleValueClicked">
                {{ value ? value.name : $t('noSet') }}
            </div>
            <div class="select-single-reference__delete-value" v-if="modelValue" @click="emitInput(null)"><XIconSolid class="svg-icon"/></div>
        </div>
        <div class="select-single-reference__search" data-augmented-ui-reset>
            <TextField
                v-model.trim="searchTerm"
                :placeholder="$t('search')"
                @keyup.enter="loadRecords"
            />
            <DataItem
                v-for="record in records"
                :key="record.id"
                class="margin-top--f2"
                :clickable="true"
                @click="emitInput(record.id)"
            >
                <div class="data-item__name">{{ record.name }}</div>
                <div class="data-item__spacer"></div>
                <div class="data-item__action"><ChevronRightIconSolid class="svg-icon"/></div>
            </DataItem>
        </div>
    </div>
    <div class="select-single-reference__error" v-for="error in errors" :key="error">{{ error }}</div>
</div>
</template>

<script lang="ts">
import axios, { CancelTokenSource } from 'axios';
import { defineComponent } from 'vue';
import TextField from '@/components/controls/TextField.vue';
import DataItem from '@/components/layout/DataItem.vue';

interface Data {
    isLoading: boolean;
    records: unknown[];
    searchTerm: string;
    value: unknown | null;
    cancelToken: CancelTokenSource | null;
    expanded: boolean;
}

export default defineComponent({
    name: 'SelectSingleReference',
    components: {
        DataItem,
        TextField,
    },
    emits: ['update:modelValue'],
    props: {
        modelValue: {
            type: String,
            default: null,
        },
        serviceFunctionSingle: {
            type: Function,
            required: true,
        },
        serviceFunctionMultiple: {
            type: Function,
            required: true,
        },
        label: {
            type: String,
            default: null,
        },
        required: {
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
    data: (): Data => ({
        isLoading: false,
        records: [],
        value: null,
        searchTerm: '',
        cancelToken: null,
        expanded: false,
    }),
    watch: {
        modelValue(): void {
            this.loadValue();
            this.expanded = false;
        },
        expanded(): void {
            if (this.expanded) {
                this.loadRecords();
            }
        },
    },
    computed: {
        classes(): Record<string, boolean> {
            return {
                'select-single-reference--expanded': this.expanded,
            };
        },
    },
    methods: {
        handleValueClicked(): void {
            this.expanded = true;
        },
        emitInput(id: string): void {
            this.$emit('update:modelValue', id);
        },
        async loadRecords(): Promise<void> {
            if (this.cancelToken) {
                this.cancelToken.cancel();
            }
            this.cancelToken = axios.CancelToken.source();
            this.isLoading = true;
            try {
                const response = await this.serviceFunctionMultiple({
                    pageSize: 15,
                    searchQuery: this.searchTerm,
                    orderBy: 'name asc',
                }, this.cancelToken);
                this.records = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadValue(): Promise<void> {
            this.value = null;
            if (!this.modelValue) {
                return;
            }
            if (this.cancelToken) {
                this.cancelToken.cancel();
            }
            this.cancelToken = axios.CancelToken.source();
            this.isLoading = true;
            try {
                const response = await this.serviceFunctionSingle(this.modelValue, this.cancelToken);
                this.value = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
});
</script>
