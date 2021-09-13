<template>
<div>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ yololScriptId ? $t('editYololScript') : $t('createYololScript') }}</h2>
    <TextArea
        class="margin-top"
        v-model="properties.code"
        :label="$t('code')"
        :readonly="isLoading"
        :required="true"
        :isCode="true"
        :errors="errors.code"
        :rows="20"
        :cols="70"
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
import { CreateYololScript, YololScript, PatchYololScript } from '@/interfaces/yolol/yololScript';
import * as yololScriptService from '@/services/yolol/yololScriptService';
import TextArea from '@/components/controls/TextArea.vue';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';

interface Properties {
    code: string;
}

interface Data {
    yololScript: YololScript | null;
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const getEmptyProperties = ():Properties => ({
    code: '',
});

export default defineComponent({
    name: 'EditYololScript',
    components: {
        Button,
        LoadingIndicatorBeam,
        TextArea,
    },
    emits: ['created', 'patched', 'cancelled', 'update:documentation'],
    props: {
        yololScriptId: {
            type: String,
            default: null,
        },
        yololProjectId: {
            type: String,
        },
    },
    data: (): Data => ({
        yololScript: null,
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    watch: {
        yololScriptId(): void {
            this.refreshData();
        },
    },
    computed: {
        changedProperties(): PatchYololScript {
            const changed: PatchYololScript = {};
            if (this.yololScript !== null) {
                Object.keys(this.properties).forEach((key: string) => {
                    if ((this.yololScript as YololScript)[key as keyof YololScript] !== (this.properties as PatchYololScript)[key as keyof PatchYololScript]) {
                        changed[key as keyof PatchYololScript] = (this.properties as PatchYololScript)[key as keyof PatchYololScript] as never;
                    }
                });
            }
            return changed;
        },
    },
    methods: {
        mapToProperties(): void {
            if (!this.yololScript) {
                return;
            }
            Object.keys(this.properties).forEach((key) => {
                (this.properties as PatchYololScript)[key as keyof PatchYololScript] = (this.yololScript as YololScript)[key as keyof YololScript] as never;
            });
        },
        async saveChanges(): Promise<void> {
            if (this.yololScriptId) {
                if (await this.patch()) {
                    this.$emit('patched', this.yololScript);
                }
            } else if (await this.create()) {
                this.$emit('created', this.yololScript);
            }
        },
        refreshData(): void {
            this.properties = getEmptyProperties();
            this.loadYololScript();
        },
        async loadYololScript(): Promise<void> {
            if (!this.yololScriptId) {
                return;
            }
            this.isLoading = true;
            try {
                this.yololScript = (await yololScriptService.getOneOrDefault(this.yololScriptId)).data;
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
                this.yololScript = (await yololScriptService.create({
                    ...this.properties as CreateYololScript,
                    projectId: this.yololProjectId as string,
                })).data;
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
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth',
                });
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
                this.yololScript = (await yololScriptService.patch(
                    this.yololScriptId,
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
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth',
                });
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
