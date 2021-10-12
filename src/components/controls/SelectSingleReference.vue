<template>
<div class="select-single-reference" :class="classes">
    <div class="select-single-reference__label" v-if="label">
        {{ label }}
        <span class="text--primary" v-if="required">*</span>
    </div>
    <div class="select-single-reference__input" data-augmented-ui="tl-clip tr-clip br-clip bl-clip border">
        <div class="select-single-reference__value-wrapper">
            <div class="select-single-reference__value" @click="handleValueClicked">
                <div
                    v-if="imageProperty"
                    class="select-single-reference__value-icon"
                    :style="{backgroundImage: value ? `url(${value[imageProperty]})` : null}"
                ></div>
                <div class="select-single-reference__value-name">{{ value ? value[labelProperty] : $t('noSet') }}</div>
            </div>
            <div class="select-single-reference__delete-value" v-if="modelValue" @click="emitInput(null)"><XIconSolid class="svg-icon"/></div>
        </div>
        <div class="select-single-reference__search" data-augmented-ui-reset>
            <div class="select-single-reference__search-header">
                <div class="select-single-reference__search-term">
                    <TextField
                        v-model.trim="searchTerm"
                        :placeholder="$t('search')"
                        @keyup.enter="loadRecords"
                    />
                </div>
                <Button class="margin-left" v-if="createRoute" type="info" :to="createRoute">{{ $t('create') }}</Button>
            </div>
            <DataItem
                v-for="record in records"
                :key="record.id"
                class="margin-top--f2"
                :clickable="true"
                @click="emitInput(record.id)"
            >
                <div class="data-item__icon" v-if="imageProperty" :style="{backgroundImage: `url(${record[imageProperty]})`}"></div>
                <div class="data-item__name">{{ record[labelProperty] }}</div>
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
import Button from '@/components/controls/Button';

interface Data {
    isLoading: boolean;
    records: unknown[];
    searchTerm: string;
    value: unknown | null;
    cancelToken: CancelTokenSource | null;
    cancelTokenMultiple: CancelTokenSource | null;
    expanded: boolean;
}

export default defineComponent({
    name: 'SelectSingleReference',
    components: {
        Button,
        DataItem,
        TextField,
    },
    emits: ['update:modelValue'],
    props: {
        modelValue: {
            type: String,
            default: null,
        },
        service: {
            type: Object,
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
        createRoute: {
            type: Object,
            default: () => null,
        },
        imageProperty: {
            type: String,
            default: null,
        },
        orderBy: {
            type: String,
            default: 'name',
        },
        labelProperty: {
            type: String,
            default: 'name',
        },
    },
    data: (): Data => ({
        isLoading: false,
        records: [],
        value: null,
        searchTerm: '',
        cancelToken: null,
        cancelTokenMultiple: null,
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
                'select-single-reference--error': this.errors.length > 0,
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
            if (this.cancelTokenMultiple) {
                this.cancelTokenMultiple.cancel();
            }
            this.cancelTokenMultiple = axios.CancelToken.source();
            this.isLoading = true;
            try {
                const response = await this.service.getMultiple({
                    pageSize: 15,
                    searchQuery: this.searchTerm,
                    orderBy: `${this.orderBy} asc`,
                }, this.cancelTokenMultiple);
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
                const response = await this.service.getOneOrDefault(this.modelValue, null, this.cancelToken);
                this.value = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
});
</script>
