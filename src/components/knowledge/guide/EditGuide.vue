<template>
<div>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ guideId ? $t('editGuide') : $t('createGuide') }}</h2>
    <TextField
        class="margin-top"
        v-model.trim="properties.title"
        :label="$t('title')"
        :readonly="isLoading"
        :required="true"
        :errors="errors.title"
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
        v-model="properties.bodytext"
        :label="$t('bodytext')"
        :readonly="isLoading"
        :required="true"
        :isCode="true"
        :errors="errors.bodytext"
        @input="$emit('update:bodytext', properties.bodytext);"
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
import { CreateGuide, Guide, PatchGuide } from '@/interfaces/knowledge/guide';
import * as guideService from '@/services/knowledge/guideService';
import TextField from '@/components/controls/TextField.vue';
import TextArea from '@/components/controls/TextArea.vue';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';

interface Properties {
    title: string;
    bodytext: string | null;
    youtubeVideoUri?: string | null;
}

interface Data {
    guide: Guide | null;
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const defaultMarkdown = `The folowing text is a default template. Change it as you like :) There is no required structure or content. Just write something.

## This is a title
This is a paragraph.

This is another paragraph.

## Second title
More paragraphs.

## Table example

| Header A | Header B |
| ------ | ------ |
| a | b |
| c | d |
| e | f |
| g | h |

Some additional link: [link text](http://example.com).
`;

const getEmptyProperties = ():Properties => ({
    title: '',
    bodytext: defaultMarkdown,
    youtubeVideoUri: null,
});

export default defineComponent({
    name: 'EditGuide',
    components: {
        Button,
        LoadingIndicatorBeam,
        TextField,
        TextArea,
    },
    emits: ['created', 'patched', 'cancelled', 'update:bodytext'],
    props: {
        guideId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        guide: null,
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    watch: {
        guideId(): void {
            this.refreshData();
        },
        properties(): void {
            this.$emit('update:bodytext', this.properties.bodytext);
        },
    },
    computed: {
        changedProperties(): PatchGuide {
            const changed: PatchGuide = {};
            if (this.guide !== null) {
                Object.keys(this.properties).forEach((key: string) => {
                    if ((this.guide as Guide)[key as keyof Guide] !== (this.properties as PatchGuide)[key as keyof PatchGuide]) {
                        changed[key as keyof PatchGuide] = (this.properties as PatchGuide)[key as keyof PatchGuide] as never;
                    }
                });
            }
            return changed;
        },
    },
    methods: {
        mapToProperties(): void {
            if (!this.guide) {
                return;
            }
            Object.keys(this.properties).forEach((key) => {
                (this.properties as PatchGuide)[key as keyof PatchGuide] = (this.guide as Guide)[key as keyof Guide] as never;
            });
        },
        async saveChanges(): Promise<void> {
            if (this.guideId) {
                if (await this.patch()) {
                    this.$emit('patched', this.guide);
                }
            } else if (await this.create()) {
                this.$emit('created', this.guide);
            }
        },
        refreshData(): void {
            this.properties = getEmptyProperties();
            this.loadGuide();
        },
        async loadGuide(): Promise<void> {
            if (!this.guideId) {
                return;
            }
            this.isLoading = true;
            try {
                this.guide = (await guideService.getOneOrDefault(this.guideId)).data;
                this.mapToProperties();
                this.$emit('update:bodytext', this.properties.bodytext);
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async create(): Promise<boolean> {
            this.isLoading = true;
            this.errors = {};
            try {
                this.guide = (await guideService.create(this.properties as CreateGuide)).data;
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
                this.guide = (await guideService.patch(
                    this.guideId,
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
