<template>
<div class="padding-container">
    <Panel :noPadding="true" :fitToScreen="true">
        <div class="flex flex--vertical full-height">
            <div class="background-contain flex__item flex__item--grow" :style="{backgroundImage: `url('https://cdn.starbase-nexus.net/dd1a4bcf-140b-4bb8-906b-93a18739812d/maps/Origin_Layout.png')`}"></div>
            <div div class="credit-bar">Credit: OkimFB</div>
        </div>
    </Panel>
    <Panel :noPadding="true" :fitToScreen="true" class="margin-top">
        <div class="flex flex--vertical full-height">
            <div class="background-contain flex__item flex__item--grow" :style="{backgroundImage: `url('https://cdn.starbase-nexus.net/dd1a4bcf-140b-4bb8-906b-93a18739812d/maps/eos_belt.png')`}"></div>
            <div div class="credit-bar">Credit: Arch#6267</div>
        </div>
    </Panel>
    <Panel :noPadding="true" :fitToScreen="true" class="margin-top">
        <div class="flex flex--vertical full-height">
            <div class="background-contain flex__item flex__item--grow" :style="{backgroundImage: `url('https://cdn.starbase-nexus.net/dd1a4bcf-140b-4bb8-906b-93a18739812d/maps/25go7x02krl71.png')`}"></div>
            <div div class="credit-bar">Credit: RustyDawwwg</div>
        </div>
    </Panel>
    <Panel :noPadding="true" :fitToScreen="true" class="margin-top">
        <div class="flex flex--vertical full-height">
            <div class="background-contain flex__item flex__item--grow" :style="{backgroundImage: `url('https://cdn.starbase-nexus.net/dd1a4bcf-140b-4bb8-906b-93a18739812d/maps/elysium_belt.png')`}"></div>
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
