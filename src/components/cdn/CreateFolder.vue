<template>
<Panel>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ $t('createFolder') }}</h2>
    <TextField
        class="margin-top"
        v-model.trim="properties.folderName"
        :label="$t('name')"
        :readonly="isLoading"
        :required="true"
        :maxLength="30"
        :errors="errors.folderName"
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
</Panel>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { AxiosResponse } from 'axios';
import * as cdnService from '@/services/cdn/cdnService';
import TextField from '@/components/controls/TextField.vue';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import Panel from '@/components/layout/Panel.vue';

interface Properties {
    folderName: string;
}

interface Data {
    isLoading: boolean;
    errors: Record<string, string[]>;
    properties: Properties;
}

const getEmptyProperties = ():Properties => ({
    folderName: '',
});

export default defineComponent({
    name: 'CreateFolder',
    components: {
        Button,
        LoadingIndicatorBeam,
        Panel,
        TextField,
    },
    emits: ['created', 'patched', 'cancelled'],
    props: {
        path: {
            type: String,
            default: '',
        },
    },
    data: (): Data => ({
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    methods: {
        async saveChanges(): Promise<void> {
            if (await this.create()) {
                this.$emit('created', this.properties.folderName);
            }
        },
        async create(): Promise<boolean> {
            this.isLoading = true;
            this.errors = {};
            try {
                (await cdnService.createFolder({
                    folderName: this.properties.folderName,
                    path: this.path,
                }));
                this.$notify({
                    type: 'success',
                    text: this.$t('saved'),
                });
            } catch (error: any) {
                if (error.response && error.response.data && error.response.data.errors) {
                    this.errors = error.response.data.errors;
                    if ((error.response as AxiosResponse).status === 409) {
                        this.$notify({
                            type: 'error',
                            text: this.$t('folderExistsAlready'),
                        });
                    }
                    if ((error.response as AxiosResponse).status === 403) {
                        this.$notify({
                            type: 'error',
                            text: this.$t('Forbidden'),
                        });
                    }
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
});
</script>
