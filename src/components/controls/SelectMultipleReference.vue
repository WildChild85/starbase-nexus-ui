<template>
<div class="select-multiple-reference" :class="classes">
    <div class="select-multiple-reference__label" v-if="label">
        {{ label }}
        <span class="text--primary" v-if="required">*</span>
    </div>
    <div class="select-multiple-reference__input" data-augmented-ui="tl-clip tr-clip br-clip bl-clip border">
        <div class="select-multiple-reference__value-wrapper">
            <div class="select-multiple-reference__value" @click="handleValueClicked">
                <div
                    v-if="imageProperty"
                    class="select-multiple-reference__value-icon"
                    :style="{backgroundImage: value ? `url(${value[imageProperty]})` : null}"
                ></div>
                <div class="select-multiple-reference__value-name">{{ modelValueLabels.length > 0 ? modelValueLabels.join(', ') : $t('noSet') }}</div>
            </div>
            <div class="select-multiple-reference__delete-value" v-if="modelValue" @click="emitInput([])"><XIconSolid class="svg-icon"/></div>
        </div>
        <div class="select-multiple-reference__values" data-augmented-ui-reset>
            <DataItem
                v-for="value in values"
                :key="value.id"
                class="margin-top--f2"
                :clickable="true"
                @click="removeValue(value.id)"
            >
                <div class="data-item__icon" v-if="imageProperty" :style="{backgroundImage: `url(${value[imageProperty]})`}"></div>
                <div class="data-item__name">{{ value[labelProperty] }}</div>
                <div class="data-item__spacer"></div>
                <div class="data-item__action"><XIconSolid class="svg-icon"/></div>
            </DataItem>
        </div>
        <div class="select-multiple-reference__search" data-augmented-ui-reset>
            <div class="select-multiple-reference__search-header">
                <div class="select-multiple-reference__search-term">
                    <TextField
                        v-model.trim="searchTerm"
                        :placeholder="$t('search')"
                        @keyup.enter="loadRecords"
                    />
                </div>
                <Button class="margin-left" v-if="createRoute" type="info" :to="createRoute">{{ $t('create') }}</Button>
            </div>
            <DataItem
                v-for="record in filteredRecors"
                :key="record.id"
                class="margin-top--f2"
                :clickable="true"
                @click="addValue(record.id)"
            >
                <div class="data-item__icon" v-if="imageProperty" :style="{backgroundImage: `url(${record[imageProperty]})`}"></div>
                <div class="data-item__name">{{ record[labelProperty] }}</div>
                <div class="data-item__spacer"></div>
                <div class="data-item__action"><ChevronRightIconSolid class="svg-icon"/></div>
            </DataItem>
        </div>
    </div>
    <div class="select-multiple-reference__error" v-for="error in errors" :key="error">{{ error }}</div>
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
    records: never[];
    searchTerm: string;
    values: never[];
    cancelToken: CancelTokenSource | null;
    cancelTokenMultiple: CancelTokenSource | null;
    expanded: boolean;
}

export default defineComponent({
    name: 'SelectMultipleReference',
    components: {
        Button,
        DataItem,
        TextField,
    },
    emits: ['update:modelValue'],
    props: {
        modelValue: {
            type: Array,
            default: () => [],
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
        values: [],
        searchTerm: '',
        cancelToken: null,
        cancelTokenMultiple: null,
        expanded: false,
    }),
    watch: {
        modelValue(): void {
            this.loadValues();
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
                'select-multiple-reference--expanded': this.expanded,
                'select-multiple-reference--error': this.errors.length > 0,
            };
        },
        modelValueLabels(): string[] {
            return this.values.map((value) => (value as never)[this.labelProperty]);
        },
        filteredRecors(): never[] {
            return (this.records as never[]).filter(({ id }) => !this.modelValue.includes(id as string));
        },
    },
    methods: {
        handleValueClicked(): void {
            this.expanded = !this.expanded;
        },
        addValue(value: string) {
            this.emitInput([
                ...new Set([
                    ...this.modelValue as string[],
                    value,
                ]),
            ]);
        },
        removeValue(value: string) {
            this.emitInput((this.modelValue as string[]).filter((fValue) => fValue !== value));
        },
        emitInput(values: string[]): void {
            this.$emit('update:modelValue', values);
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
        async loadValues(): Promise<void> {
            this.values = [];
            if (!this.modelValue) {
                return;
            }
            if (this.cancelToken) {
                this.cancelToken.cancel();
            }
            this.cancelToken = axios.CancelToken.source();
            this.isLoading = true;
            try {
                const response = await this.service.getMultipleByIds(this.modelValue, null, this.cancelToken);
                this.values = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
});
</script>
