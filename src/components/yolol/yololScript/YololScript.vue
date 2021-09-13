<template>
<div class="yolol-script">
    <div
        v-if="!showEdit"
        class="yolol-script__code"
        data-augmented-ui="tl-clip-inset t-clip-x tr-clip r-clip-y br-clip-inset b-clip-x bl-clip l-clip-y border"
    >
        <div class="yolol-script__last-update">
            <div class="flex flex--center-vertical">
                <div v-if="editRights"><Button @click="showEdit = true"><PencilAltIconSolid class="svg-icon"/></Button></div>
                <div class="flex__item flex__item--grow">
                    {{ $t('lastUpdate')}}: <span class="text--primary"><DateTimeFormatter :isoString="yololScript.updatedAt ? yololScript.updatedAt : yololScript.createdAt" /></span>
                </div>
            </div>
        </div>
        <pre>{{ yololScript.code }}</pre>
    </div>
    <EditYololScript
        v-else
        :yololScriptId="yololScript.id"
        @cancelled="showEdit = false"
        @patched="handlePatched"
    />
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { YololScript } from '@/interfaces/yolol/yololScript';
import EditYololScript from '@/components/yolol/yololScript/EditYololScript.vue';
import DateTimeFormatter from '@/components/formatters/DateTimeFormatter.vue';
import Button from '@/components/controls/Button';

interface Data {
    showEdit: boolean;
}

export default defineComponent({
    name: 'YololScript',
    emits: ['patched'],
    components: {
        Button,
        DateTimeFormatter,
        EditYololScript,
    },
    props: {
        yololScript: {
            type: Object,
            required: true,
        },
        editRights: {
            type: Boolean,
            default: false,
        },
    },
    data: (): Data => ({
        showEdit: false,
    }),
    computed: {
        typedYololScript(): YololScript {
            return this.yololScript as YololScript;
        },
    },
    methods: {
        handlePatched(): void {
            this.showEdit = false;
            this.$emit('patched');
        },
    },
});
</script>
