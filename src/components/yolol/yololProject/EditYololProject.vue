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
    <TextField
        class="margin-top"
        v-model.trim="properties.fetchConfigUri"
        :label="$t('fetchConfigUri')"
        :readonly="isLoading"
        :errors="errors.fetchConfigUri"
    />
    <p><strong>IMPORTANT:</strong> The uri has to be the <strong>raw uri</strong>, not the link to the github page. <strong>Click on the raw button to get the raw uri</strong>.</p>
    <FetchConfigCheck v-if="properties.fetchConfigUri" :fetchConfigUri="properties.fetchConfigUri" />

    <TextArea
        v-if="!properties.fetchConfigUri"
        class="margin-top"
        v-model="properties.documentation"
        :label="$t('documentation')"
        :readonly="isLoading"
        :isCode="true"
        :errors="errors.documentation"
        @input="$emit('update:documentation', properties.documentation);"
    />
    <p v-else>{{ $t('yololProjectDocumentationHiddenExplanation') }}</p>

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
import FetchConfigCheck from '@/components/yolol/yololProject/FetchConfigCheck.vue';

interface Properties {
    name: string;
    documentation: string | null;
    fetchConfigUri: string | null;
    previewImageUri: string | null;
    youtubeVideoUri: string | null;
}

interface Data {
    yololProject: YololProject | null;
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const defaultMarkdown = `This script is an extension of the original script from **some player name**.

## Installation

Take the yolol script and put it in a Yolol Chip.

Look at the item, press "U" and rename the left fields to:

| from | to |
| ------ | ------ |
| Property1 | Prop1 |
| Property2 | Prop2 |
| Property3 | Prop3 |
| Property4 | Prop4 |
| Property5 | Prop5 |

Put two Text Panels in your cockpit and rename the **PanelValue** like this:

* Text Panel Property for Prop1: **Prop1**
* Text Panel Property for Prop2: **Prop2**

Add a button to your cockpit and rename the **ButtonValue** property to **Prop5**.

You can find the project on Github: [link text](http://example.com).
If you need support check out our [Discord](http://example.com).
`;

const getEmptyProperties = ():Properties => ({
    documentation: defaultMarkdown,
    fetchConfigUri: null,
    name: '',
    previewImageUri: null,
    youtubeVideoUri: null,
});

export default defineComponent({
    name: 'EditYololProject',
    components: {
        Button,
        FetchConfigCheck,
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
                this.$emit('update:documentation', this.properties.documentation);
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
