<template>
<DataItem :type="dataItemType">
    <div class="data-item__progress" :style="{width: `${progress}%`}"></div>
    <div class="data-item__name">{{ typedFile.name }}</div>
    <div class="data-item__spacer"></div>
    <div class="data-item__property">{{ status === uploadStateKeys.uploading ? `${progress}%` : $t(status)}}</div>
    <div class="data-item__action" :title="$t('remove')" v-if="canBeRemoved" @click="remove"><XIconSolid class="svg-icon"/></div>
</DataItem>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { AxiosResponse } from 'axios';
import { ALLOWED_IMAGE_TYPES, MAX_FILE_SIZE } from '@/constants/cdn';
import DataItem from '@/components/layout/DataItem.vue';
import * as cdnService from '@/services/cdn/cdnService';

interface Data {
    status: string;
    progress: number;
}

export default defineComponent({
    name: 'FileUploadStatus',
    components: {
        DataItem,
    },
    emits: ['remove', 'uploading', 'error', 'completed'],
    props: {
        path: {
            type: String,
            default: '',
        },
        file: {
            type: Object,
            required: true,
        },
    },
    data: (): Data => ({
        status: '',
        progress: 0,
    }),
    computed: {
        dataItemType(): string {
            if ([
                this.uploadStateKeys.fileExists,
                this.uploadStateKeys.fileTypeNotAllowed,
                this.uploadStateKeys.fileTooBig,
                this.uploadStateKeys.unknownError,
            ].includes(this.status)) {
                return 'error';
            }
            if ([
                this.uploadStateKeys.optimizing,
                this.uploadStateKeys.uploading,
            ].includes(this.status)) {
                return 'info';
            }
            if ([
                this.uploadStateKeys.completed,
            ].includes(this.status)) {
                return 'success';
            }

            return '';
        },
        uploadStateKeys(): Record<string, string> {
            return {
                fileExists: 'fileExists',
                fileTypeNotAllowed: 'fileTypeNotAllowed',
                fileTooBig: 'fileTooBig',
                unknownError: 'unknownError',
                optimizing: 'optimizing',
                completed: 'completed',
                uploading: 'uploading',
                pending: '',
            };
        },
        canBeRemoved(): boolean {
            return ![
                this.uploadStateKeys.optimizing,
                this.uploadStateKeys.completed,
                this.uploadStateKeys.uploading,
            ].includes(this.status);
        },
        canBeUploaded(): boolean {
            return [
                '',
            ].includes(this.status);
        },
        typedFile(): File {
            return this.file as File;
        },
    },
    methods: {
        remove(): void {
            if (this.status === this.uploadStateKeys.uploading) {
                return;
            }
            this.$emit('remove', this.typedFile);
        },
        async upload(): Promise<void> {
            if (!this.canBeUploaded) {
                return;
            }
            try {
                this.status = this.uploadStateKeys.uploading;
                const response = await cdnService.upload(this.typedFile, this.path, (progressEvent) => {
                    this.progress = Math.round((progressEvent.loaded * 100) / this.typedFile.size);
                    if (this.progress === 100) {
                        this.status = this.uploadStateKeys.optimizing;
                    }
                });
                this.status = this.uploadStateKeys.completed;
                this.$emit('completed', response.data.publicUri);
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            } catch (error: any) {
                if (error.response) {
                    const { status } = error.response as AxiosResponse;
                    if (status === 409) {
                        this.status = this.uploadStateKeys.fileExists;
                    } else {
                        this.status = this.uploadStateKeys.unknownError;
                    }
                }
            }
            this.progress = 0;
        },
    },
    created(): void {
        if (this.typedFile.size > MAX_FILE_SIZE) {
            this.status = this.uploadStateKeys.fileTooBig;
        } else if (!ALLOWED_IMAGE_TYPES.includes(this.typedFile.type)) {
            this.status = this.uploadStateKeys.fileTypeNotAllowed;
        } else if (this.canBeUploaded) {
            this.upload();
        }
        console.log(this.file);
    },
});
</script>
