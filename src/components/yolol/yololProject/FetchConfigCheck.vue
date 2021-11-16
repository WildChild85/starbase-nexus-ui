<template>
<div class="fetch-config-check">
    <div class="flex flex--center-horizontal margin-top--f2">
        <LoadingIndicatorCircle v-if="isLoading"/>
    </div>
    <template v-if="!onlyErrors">
        <template
            v-for="successKey in Object.keys(successes)"
            :key="successKey"
        >
            <DataItem
                v-for="successMessage in successes[successKey]"
                :key="successMessage"
                type="success"
                class="margin-top--f2"
            >
                <div class="data-item__property"><span class="text--success">{{ successKey }}</span>&nbsp;{{ successMessage }}</div>
            </DataItem>
        </template>
    </template>
    <template
        v-for="errorKey in Object.keys(errors)"
        :key="errorKey"
    >
        <DataItem
            v-for="errorMessage in errors[errorKey]"
            :key="errorMessage"
            type="error"
            class="margin-top--f2"
        >
            <div class="data-item__property"><span class="text--error">{{ errorKey }}</span>&nbsp;{{ errorMessage }}</div>
        </DataItem>
    </template>
</div>
</template>

<script lang="ts">
import axios, { CancelTokenSource } from 'axios';
import { defineComponent } from 'vue';
import LoadingIndicatorCircle from '@/components/loading/LoadingIndicatorCircle.vue';
import DataItem from '@/components/layout/DataItem.vue';
import * as yololProjectService from '@/services/yolol/yololProjectService';

interface Data {
    isLoading: boolean;
    errors: Record<string, string[]>;
    successes: Record<string, string[]>;
    cancelToken: CancelTokenSource | null;
}

export default defineComponent({
    name: 'FetchConfigCheck',
    components: {
        DataItem,
        LoadingIndicatorCircle,
    },
    props: {
        fetchConfigUri: {
            type: String,
            default: null,
        },
        onlyErrors: {
            type: Boolean,
            default: false,
        },
    },
    watch: {
        fetchConfigUri(): void {
            this.errors = {};
            this.successes = {};
            if (this.fetchConfigUri) {
                this.loadFetchConfig();
            }
        },
    },
    data: (): Data => ({
        isLoading: false,
        errors: {},
        successes: {},
        cancelToken: null,
    }),
    methods: {
        async loadFetchConfig(): Promise<void> {
            this.errors = {};
            this.successes = {};
            this.isLoading = true;
            if (this.cancelToken) {
                this.cancelToken.cancel();
            }
            this.cancelToken = axios.CancelToken.source();
            try {
                const response = await yololProjectService.testFetchConfig({
                    fetchConfigUri: this.fetchConfigUri,
                }, this.cancelToken);
                this.successes = response.data.successes;
                this.errors = response.data.errors;
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            } catch (error: any) {
                this.$notify({
                    type: 'error',
                    text: error.message,
                });
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.loadFetchConfig();
    },
});
</script>
// http://starbase-nexus-cdn.localhost/flow-control/fetch-config.json
