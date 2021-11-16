<template>
<div class="yolol-script">
    <div
        v-if="!showEdit"
        class="yolol-script__code"
        data-augmented-ui="tl-clip-inset t-clip-x tr-clip r-clip-y br-clip-inset b-clip-x bl-clip l-clip-y border"
    >
        <div class="yolol-script__last-update">
            <div class="yolol-script__header">
                <div v-if="editRights" class="margin-right--f2"><Button @click="showEdit = true"><PencilAltIconSolid class="svg-icon"/></Button></div>
                <Button type="info" class="margin-right" :title="$t('copyIdToClipboard')" @click="copyToClipboard(yololScript.code)"><ClipboardCopyIconOutline class="svg-icon"/></Button>
                <span class="yolol-script__name">{{ yololScript.name }}</span>
                <span class="yolol-script__chip" :title="$t('requiredChip')"><ChipIconSolid class="svg-icon margin-right--f2"/>{{ requiredChip }}</span>
                <span>
                    {{ $t('lastUpdate')}}:
                    <DateTimeFormatter v-if="lastUpdate" :isoString="lastUpdate" />
                    <span v-else>{{ $t('checkOnGithub')}}</span>
                </span>
            </div>
        </div>
        <pre>{{ yololScript.code }}</pre>
        <textarea class="input-copy-to-clipboard" :id="clipboardInputId" :value="textToCopy" />
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
import { uniqueId, getRequiredYololChip } from '@/helpers';

interface Data {
    showEdit: boolean;
    textToCopy: string;
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
        textToCopy: '',
    }),
    computed: {
        typedYololScript(): YololScript {
            return this.yololScript as YololScript;
        },
        clipboardInputId(): string {
            return `clipboardInput_${this.yololScript.id}_${uniqueId}}`;
        },
        requiredChip(): string {
            return getRequiredYololChip(this.yololScript.code);
        },
        lastUpdate(): string | null {
            return this.yololScript.updatedAt ? this.yololScript.updatedAt : this.yololScript.createdAt;
        },
    },
    methods: {
        copyToClipboard(text: string): void {
            this.textToCopy = text;
            const input = document.getElementById(this.clipboardInputId) as HTMLInputElement;

            this.$nextTick(() => {
                /* Select the text field */
                input.select();
                /* For mobile devices */
                input.setSelectionRange(0, 99999);

                document.execCommand('copy');

                this.$notify({
                    title: this.$t('copied'),
                    text: this.$t('codeCopied'),
                    type: 'success',
                });
            });
        },
        handlePatched(): void {
            this.showEdit = false;
            this.$emit('patched');
        },
    },
});
</script>
