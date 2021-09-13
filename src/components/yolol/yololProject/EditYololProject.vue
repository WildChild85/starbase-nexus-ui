<template>
<div>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ yololProjectId ? $t('editYololProject') : $t('createYololProject') }}</h2>
    <TextField
        class="margin-top"
        v-model.trim="properties.name"
        :label="$t('name')"
        :readonly="isLoading"
        :required="true"
        :errors="errors.name"
    />
    <SelectFile
        class="margin-top"
        :label="$t('Preview image')"
        v-model="properties.previewImageUri"
    />
    <TextField
        class="margin-top"
        v-model.trim="properties.youtubeVideoUri"
        :label="$t('youtubeVideoUri')"
        :readonly="isLoading"
        :errors="errors.youtubeVideoUri"
    />
    <TextArea
        class="margin-top"
        v-model="properties.documentation"
        :label="$t('documentation')"
        :readonly="isLoading"
        :required="true"
        :isCode="true"
        :errors="errors.documentation"
    />

    <div class="panel__actions">
        <Button
            type="success"
            :loading="isLoading"
            @click="saveChanges"
        >{{ $t('save') }}</Button>

        <Button
            :disabled="isLoading"
            :small="true"
            type="secondary"
            @click="$emit('cancelled')"
        >{{ $t('cancel') }}</Button>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { CreateYololProject, YololProject, PatchYololProject } from '@/interfaces/yolol/yololProject';
import * as yololProjectService from '@/services/yolol/yololProjectService';
import TextField from '@/components/controls/TextField.vue';
import TextArea from '@/components/controls/TextArea.vue';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import SelectFile from '@/components/controls/SelectFile.vue';

interface Properties {
    name: string;
    documentation: string;
    previewImageUri: string | null;
    youtubeVideoUri: string | null;
}

interface Data {
    yololProject: YololProject | null;
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const getEmptyProperties = ():Properties => ({
    documentation: '',
    name: '',
    previewImageUri: null,
    youtubeVideoUri: null,
});

export default defineComponent({
    name: 'EditYololProject',
    components: {
        Button,
        LoadingIndicatorBeam,
        SelectFile,
        TextField,
        TextArea,
    },
    emits: ['created', 'patched', 'cancelled', 'update:documentation'],
    props: {
        yololProjectId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        yololProject: null,
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    watch: {
        yololProjectId(): void {
            this.refreshData();
        },
    },
    computed: {
        changedProperties(): PatchYololProject {
            const changed: PatchYololProject = {};
            if (this.yololProject !== null) {
                Object.keys(this.properties).forEach((key: string) => {
                    if ((this.yololProject as YololProject)[key as keyof YololProject] !== (this.properties as PatchYololProject)[key as keyof PatchYololProject]) {
                        changed[key as keyof PatchYololProject] = (this.properties as PatchYololProject)[key as keyof PatchYololProject] as never;
                    }
                });
            }
            return changed;
        },
    },
    methods: {
        mapToProperties(): void {
            if (!this.yololProject) {
                return;
            }
            Object.keys(this.properties).forEach((key) => {
                (this.properties as PatchYololProject)[key as keyof PatchYololProject] = (this.yololProject as YololProject)[key as keyof YololProject] as never;
            });
        },
        async saveChanges(): Promise<void> {
            if (this.yololProjectId) {
                if (await this.patch()) {
                    this.$emit('patched', this.yololProject);
                }
            } else if (await this.create()) {
                this.$emit('created', this.yololProject);
            }
        },
        refreshData(): void {
            this.properties = getEmptyProperties();
            this.loadYololProject();
        },
        async loadYololProject(): Promise<void> {
            if (!this.yololProjectId) {
                return;
            }
            this.isLoading = true;
            try {
                this.yololProject = (await yololProjectService.getOneOrDefault(this.yololProjectId)).data;
                this.mapToProperties();
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async create(): Promise<boolean> {
            this.isLoading = true;
            this.errors = {};
            try {
                this.yololProject = (await yololProjectService.create(this.properties as CreateYololProject)).data;
                this.$notify({
                    type: 'success',
                    text: this.$t('saved'),
                });
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            } catch (error: any) {
                if (error.response && error.response.data && error.response.data.errors) {
                    this.errors = error.response.data.errors;
                }
                this.isLoading = false;
                this.$notify({
                    type: 'error',
                    text: this.$t('savingFailed'),
                });
                return false;
            }
            this.isLoading = false;
            return true;
        },
        async patch(): Promise<boolean> {
            this.isLoading = true;
            this.errors = {};
            try {
                this.yololProject = (await yololProjectService.patch(
                    this.yololProjectId,
                    this.changedProperties,
                )).data;
                this.$notify({
                    type: 'success',
                    text: this.$t('saved'),
                });
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            } catch (error: any) {
                if (error.response && error.response.data && error.response.data.errors) {
                    this.errors = error.response.data.errors;
                }
                this.isLoading = false;
                this.$notify({
                    type: 'error',
                    text: this.$t('savingFailed'),
                });
                return false;
            }
            this.isLoading = false;
            return true;
        },
    },
    async created(): Promise<void> {
        this.refreshData();
    },
});
</script>
