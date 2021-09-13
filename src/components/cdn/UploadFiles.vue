<template>
<Panel>
    <div class="flex">
        <div class="flex__item flex__item--grow">
            <label class="file-upload-input" data-augmented-ui="tl-clip tr-clip bl-clip br-clip border">
                <span>{{ $t('clickToUploadFiles') }}</span>
                <input type="file" multiple="true" @input="handleFilesSelected"/>
            </label>
        </div>
        <Button type="info" class="margin-left" @click="$emit('close')">Close</Button>
    </div>
    <FileUploadStatus
        v-for="file in files"
        :key="file.name"
        class="margin-top--f2"
        :path="path"
        :file="file"
        @remove="removeFile(file)"
    />
</Panel>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import FileUploadStatus from '@/components/cdn/FileUploadStatus.vue';
import Panel from '@/components/layout/Panel.vue';
import Button from '@/components/controls/Button';

interface Data {
    files: File[];
}

export default defineComponent({
    name: 'UploadFiles',
    components: {
        Button,
        FileUploadStatus,
        Panel,
    },
    emits: ['close'],
    props: {
        path: {
            type: String,
            default: '',
        },
    },
    data: (): Data => ({
        files: [],
    }),
    computed: {
    },
    methods: {
        removeFile(rfile: File): void {
            this.files = this.files.filter((file) => file.name !== rfile.name);
        },
        handleFilesSelected(event: InputEvent) {
            const target = event.target as HTMLInputElement;
            if (!target.files) {
                return;
            }
            (target.files as unknown as File[]).forEach(async (newFile) => {
                if (!this.files.some((file) => file.name === newFile.name)) {
                    this.files.push(newFile);
                }
            });
        },
    },
});
</script>
