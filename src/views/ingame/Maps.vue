<template>
<div class="padding-container">
    <Panel :noPadding="true" :fitToScreen="true">
        <div class="flex flex--vertical full-height">
            <div class="background-contain flex__item flex__item--grow" :style="{backgroundImage: `url('https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/maps/Origin_Layout.png')`}"></div>
            <div div class="credit-bar">Credit: unknown (please contact WildChild85#2691)</div>
        </div>
    </Panel>
    <Panel :noPadding="true" :fitToScreen="true" class="margin-top">
        <div class="flex flex--vertical full-height">
            <div class="background-contain flex__item flex__item--grow" :style="{backgroundImage: `url('https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/maps/eos_belt.png')`}"></div>
            <div div class="credit-bar">Credit: Arch#6267</div>
        </div>
    </Panel>
    <Panel :noPadding="true" :fitToScreen="true" class="margin-top">
        <div class="flex flex--vertical full-height">
            <div class="background-contain flex__item flex__item--grow" :style="{backgroundImage: `url('https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/maps/elysium_belt.png')`}"></div>
            <div div class="credit-bar">Credit: Arch#6267</div>
        </div>
    </Panel>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import ViewMixin from '@/mixins/ViewMixin';
import Panel from '@/components/layout/Panel.vue';

export default defineComponent({
    name: 'Maps',
    mixins: [ViewMixin],
    components: {
        Panel,
    },
    created(): void {
        this.setPageTitle([this.$t('maps'), this.$t('ingame')]);
    },
});
</script>
