<template>
<div class="home">
    <div class="padding-container">
        <Panel>
            <div class="flex flex--end">
                <TextField :v-model="searchTerm" :placeholder="$t('search')" />
                <Button class="margin-left">Create</Button>
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

interface Data {
    searchTerm: string;
}

export default defineComponent({
    name: 'Items',
    components: {
        Button,
        Panel,
        TextField,
    },
    mixins: [ViewMixin],
    data: (): Data => ({
        searchTerm: '',
    }),
    computed: {
    },
    created(): void {
        this.setPageTitle(['InGame', 'Items']);
    },
});
</script>
