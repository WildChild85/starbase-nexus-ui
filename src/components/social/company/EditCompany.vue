<template>
<div>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ companyId ? $t('editCompany') : $t('createCompany') }}</h2>
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
        :label="$t('logo')"
        v-model="properties.logoUri"
    />
    <TextField
        class="margin-top"
        v-model.trim="properties.discordUri"
        :label="$t('discordUri')"
        :readonly="isLoading"
        :errors="errors.discordUri"
    />
    <TextField
        class="margin-top"
        v-model.trim="properties.websiteUri"
        :label="$t('websiteUri')"
        :readonly="isLoading"
        :errors="errors.websiteUri"
    />
    <TextField
        class="margin-top"
        v-model.trim="properties.youtubeUri"
        :label="$t('youtubeUri')"
        :readonly="isLoading"
        :errors="errors.youtubeUri"
    />
    <TextField
        class="margin-top"
        v-model.trim="properties.twitchUri"
        :label="$t('twitchUri')"
        :readonly="isLoading"
        :errors="errors.twitchUri"
    />
    <TextArea
        class="margin-top"
        v-model="properties.aboutUs"
        :label="$t('aboutUs')"
        :readonly="isLoading"
        :required="true"
        :isCode="true"
        :errors="errors.aboutUs"
        @input="$emit('update:aboutUs', properties.aboutUs);"
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
import { CreateCompany, Company, PatchCompany } from '@/interfaces/social/company';
import * as companyService from '@/services/social/companyService';
import TextField from '@/components/controls/TextField.vue';
import TextArea from '@/components/controls/TextArea.vue';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import SelectFile from '@/components/controls/SelectFile.vue';

interface Properties {
    name: string;
    aboutUs: string;
    logoUri?: string | null;
    discordUri?: string | null;
    websiteUri?: string | null;
    youtubeUri?: string | null;
    twitchUri?: string | null;
}

interface Data {
    company: Company | null;
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const defaultMarkdown = `The folowing text is a default template. Change it as you like :) There is no required structure or content. Just write something.

## Who we are
A description of who you are, what you are doing in the game.

## Vision
Your long term vision of the game. What will you do in a year maybe.

## Special Achievements
Did your group something awesome? :)

## Parameters

|||
| ------ | ------ |
| Founded | 2021-09-16 |
| Leader | Player A |
| Founders | Player A, Player B, Placer C |
| Members | 999 |
| Main Origin | 01 |

Some additional link: [link text](http://example.com).
`;

const getEmptyProperties = ():Properties => ({
    name: '',
    aboutUs: defaultMarkdown,
    logoUri: null,
    discordUri: null,
    websiteUri: null,
    youtubeUri: null,
    twitchUri: null,
});

export default defineComponent({
    name: 'EditCompany',
    components: {
        Button,
        LoadingIndicatorBeam,
        SelectFile,
        TextField,
        TextArea,
    },
    emits: ['created', 'patched', 'cancelled', 'update:aboutUs'],
    props: {
        companyId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        company: null,
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    watch: {
        companyId(): void {
            this.refreshData();
        },
        properties(): void {
            this.$emit('update:aboutUs', this.properties.aboutUs);
        },
    },
    computed: {
        changedProperties(): PatchCompany {
            const changed: PatchCompany = {};
            if (this.company !== null) {
                Object.keys(this.properties).forEach((key: string) => {
                    if ((this.company as Company)[key as keyof Company] !== (this.properties as PatchCompany)[key as keyof PatchCompany]) {
                        changed[key as keyof PatchCompany] = (this.properties as PatchCompany)[key as keyof PatchCompany] as never;
                    }
                });
            }
            return changed;
        },
    },
    methods: {
        mapToProperties(): void {
            if (!this.company) {
                return;
            }
            Object.keys(this.properties).forEach((key) => {
                (this.properties as PatchCompany)[key as keyof PatchCompany] = (this.company as Company)[key as keyof Company] as never;
            });
        },
        async saveChanges(): Promise<void> {
            if (this.companyId) {
                if (await this.patch()) {
                    this.$emit('patched', this.company);
                }
            } else if (await this.create()) {
                this.$emit('created', this.company);
            }
        },
        refreshData(): void {
            this.properties = getEmptyProperties();
            this.loadCompany();
        },
        async loadCompany(): Promise<void> {
            if (!this.companyId) {
                return;
            }
            this.isLoading = true;
            try {
                this.company = (await companyService.getOneOrDefault(this.companyId)).data;
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
                this.company = (await companyService.create(this.properties as CreateCompany)).data;
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
                this.company = (await companyService.patch(
                    this.companyId,
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
