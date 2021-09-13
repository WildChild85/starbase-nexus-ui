<template>
    <div class="select-file">
        <div class="select-file__label" v-if="label">{{ label }}</div>
        <div
            class="select-file__selected"
            data-augmented-ui="tl-clip t-clip-x tr-clip r-clip-y br-clip b-clip-x bl-clip l-clip-y border"
            :style="selectFileStyle"
            @click="handleClick"
        >
            <span v-if="!modelValue">{{ $t('clickToSelectOrUpload')}}</span>
            <div v-else class="select-file__remove">{{ $t('remove') }}<XIconSolid class="svg-icon"/></div>
        </div>
        <Dialog v-if="dialogShown" :fullWidth="true">
            <FileExplorer
                :embedded="true"
                @fileSelected="handleFileSelected"
                @close="hideDialog"
            />
        </Dialog>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import FileExplorer, { FileSelection } from '@/components/cdn/FileExplorer.vue';
import Dialog from '@/components/dialogs/Dialog.vue';

export default defineComponent({
    name: 'SelectFile',
    components: {
        FileExplorer,
        Dialog,
    },
    emits: ['update:modelValue'],
    props: {
        label: {
            type: String,
            default: null,
        },
        modelValue: {
            type: String,
            default: null,
        },
    },
    data: () => ({
        dialogShown: false,
    }),
    computed: {
        selectFileStyle(): Record<string, string> {
            return {
                backgroundImage: this.modelValue ? `url('${this.modelValue}')` : '',
            };
        },
    },
    methods: {
        handleClick(): void {
            if (this.modelValue) {
                this.$emit('update:modelValue', null);
            } else {
                this.showDialog();
            }
        },
        showDialog(): void {
            this.dialogShown = true;
        },
        hideDialog(): void {
            this.dialogShown = false;
        },
        handleFileSelected(file: FileSelection): void {
            this.dialogShown = false;
            this.$emit('update:modelValue', file.publicUri);
        },
    },
});
</script>
