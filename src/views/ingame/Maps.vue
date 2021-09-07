<template>
<div class="padding-container">
    <Panel :noPadding="true" :fitToScreen="true">
        <div class="flex flex--vertical full-height">
            <div class="background-contain flex__item flex__item--grow" :style="{backgroundImage: `url('https://ik.imagekit.io/mcmt38yqgcy/app-assets/maps/Origin_Layout_4pKF_Zo4F.png?updatedAt=1631036269127')`}"></div>
            <div div class="credit-bar">Credit: unknown (please contact WildChild85#2691)</div>
        </div>
    </Panel>
    <Panel :noPadding="true" :fitToScreen="true" class="margin-top">
        <div class="flex flex--vertical full-height">
            <div class="background-contain flex__item flex__item--grow" :style="{backgroundImage: `url('https://ik.imagekit.io/mcmt38yqgcy/app-assets/maps/eos_belt_fZtGLZpokhs.png?updatedAt=1631036270662')`}"></div>
            <div div class="credit-bar">Credit: Arch#6267</div>
        </div>
    </Panel>
    <Panel :noPadding="true" :fitToScreen="true" class="margin-top">
        <div class="flex flex--vertical full-height">
            <div class="background-contain flex__item flex__item--grow" :style="{backgroundImage: `url('https://ik.imagekit.io/mcmt38yqgcy/app-assets/maps/25go7x02krl71_QDsCbqPaO.png?updatedAt=1631036270507')`}"></div>
            <div div class="credit-bar">Credit: RustyDawwwg</div>
        </div>
    </Panel>
    <Panel :noPadding="true" :fitToScreen="true" class="margin-top">
        <div class="flex flex--vertical full-height">
            <div class="background-contain flex__item flex__item--grow" :style="{backgroundImage: `url('https://ik.imagekit.io/mcmt38yqgcy/app-assets/maps/elysium_belt_8d5PmCx4f.png?updatedAt=1631036270213')`}"></div>
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
