<template>
<div class="home">
    <div class="padding-container">
        <Panel>
            <h2>Hi</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vitae mauris bibendum, cursus lorem ut, facilisis nunc. Nulla vitae mollis tellus. Proin sollicitudin dui et odio porta, non ornare mi malesuada. Ut auctor nisi sit amet libero laoreet vehicula. Mauris pulvinar vitae nunc at venenatis. Curabitur ultrices in enim pretium tincidunt. Fusce dignissim, risus eu fringilla mollis, arcu leo elementum dui, ullamcorper auctor dolor libero nec diam. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nam eu felis sit amet massa imperdiet placerat vel non lorem. Sed consequat interdum nulla, eu lacinia erat feugiat et. Quisque bibendum neque quis consequat mollis. Sed luctus magna in felis maximus, id dictum nibh fringilla.</p>
        </Panel>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Panel from '@/components/layout/Panel.vue';
import ViewMixin from '@/mixins/ViewMixin';

export default defineComponent({
    name: 'Home',
    components: {
        Panel,
    },
    mixins: [ViewMixin],
    data: () => ({
    }),
    computed: {
    },
    created(): void {
        this.setPageTitle(['InGame', 'Items']);
    },
});
</script>
