<template>
<div class="companies">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <Panel>
            <div class="flex flex--end flex--wrap">
                <TextField v-model.trim="searchTerm" :placeholder="$t('search')" @keyup.enter="refreshData"/>
                <Button class="margin-left" :loading="isLoading" @click="refreshData">Refresh</Button>
                <Button class="margin-left" type="info" :to="{name: 'social_company_create'}">Create</Button>
            </div>

            <div class="company-list">
                <CompanyListItem
                    v-for="company in companies"
                    :key="company.id"
                    :company="company"
                    class="margin-top--f2"
                >
                </CompanyListItem>
            </div>
        </Panel>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Panel from '@/components/layout/Panel.vue';
import ViewMixin from '@/mixins/ViewMixin';
import TextField from '@/components/controls/TextField.vue';
import Button from '@/components/controls/Button';
import * as companyService from '@/services/social/companyService';
import { Company } from '@/interfaces/social/company';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import CompanyListItem from '@/components/social/company/CompanyListItem.vue';

interface Data {
    searchTerm: string;
    isLoading: boolean;
    companies: Company[];
}

export default defineComponent({
    name: 'Companys',
    components: {
        Button,
        Panel,
        TextField,
        LoadingIndicatorBeam,
        CompanyListItem,
    },
    mixins: [ViewMixin],
    data: (): Data => ({
        searchTerm: '',
        isLoading: false,
        companies: [],
    }),
    methods: {
        async refreshData(): Promise<void> {
            await this.loadCompanys();
        },
        async loadCompanys(): Promise<void> {
            this.isLoading = true;
            try {
                const response = await companyService.getMultiple({
                    pageSize: -1,
                    searchQuery: this.searchTerm,
                });
                this.companies = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('companies'), this.$t('social')]);
        this.refreshData();
    },
});
</script>
