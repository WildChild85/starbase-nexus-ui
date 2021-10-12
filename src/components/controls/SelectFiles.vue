<template>
    <div class="select-files">
        <div class="select-files__label" v-if="label">{{ label }}</div>
        <div class="select-files__files">
            <div
                v-for="(selectedFile, index) in values"
                :key="selectedFile"
                class="select-files__selected"
                data-augmented-ui="tl-clip t-clip-x tr-clip r-clip-y br-clip b-clip-x bl-clip l-clip-y border"
                :style="selectedFileStyles[index]"
                @click="removeSelectedFile(selectedFile)"
            >
                <div class="select-files__remove">{{ $t('remove') }}<XIconSolid class="svg-icon"/></div>
            </div>
            <div
                class="select-files__add"
                data-augmented-ui="tl-clip t-clip-x tr-clip r-clip-y br-clip b-clip-x bl-clip l-clip-y border"
                @click="showFileBrowser"
            >
                <span>{{ $t('clickToSelectOrUpload')}}</span>
            </div>
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
    name: 'SelectFiles',
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
        selectedFiles: [],
    }),
    computed: {
        values(): string[] {
            return this.modelValue ? this.modelValue.split(',') : [];
        },
        selectedFileStyles(): Record<string, string>[] {
            return this.values.map((value) => ({
                backgroundImage: `url('${value}')`,
            }));
        },
    },
    methods: {
        showFileBrowser(): void {
            this.showDialog();
        },
        removeSelectedFile(selectedFile: string): void {
            if (this.modelValue) {
                this.$emit('update:modelValue', this.values.filter((value) => value !== selectedFile).join(','));
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
            this.$emit('update:modelValue', this.modelValue ? `${this.modelValue},${file.publicUri}` : file.publicUri);
        },
    },
});
</script>
