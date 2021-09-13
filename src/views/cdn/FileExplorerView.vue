<template>
<div class="padding-container">
    <FileExplorer />
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import ViewMixin from '@/mixins/ViewMixin';
import FileExplorer from '@/components/cdn/FileExplorer.vue';

export default defineComponent({
    name: 'FileExplorerView',
    components: {
        FileExplorer,
    },
    mixins: [ViewMixin],
    created(): void {
        this.setPageTitle([this.$t('fileExplorer'), 'CDN']);
    },
});
</script>
