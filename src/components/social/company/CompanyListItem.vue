<template>
<router-link
    :to="{name: 'social_company', params: { companyId: company.id }}"
    class="company-list-item"
    data-augmented-ui="tl-clip tr-clip br-clip bl-clip border"
>
    <div class="company-list-item__logo" :style="logoStyle"></div>
    <div class="company-list-item__name">{{ company.name }}</div>

</router-link>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { Company } from '@/interfaces/social/company';

export default defineComponent({
    name: 'CompanyListItem',
    props: {
        company: {
            type: Object,
            required: true,
        },
    },
    computed: {
        typedCompany(): Company {
            return this.company as Company;
        },
        logoStyle(): Record<string, string> {
            return {
                backgroundImage: this.typedCompany && this.typedCompany.logoUri ? `url('${this.typedCompany.logoUri}')` : '',
            };
        },
    },
});
</script>
