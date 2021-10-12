<template>
<Panel>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <h2 class="text--primary margin-left--f2 margin-right--f2">{{ shipClassId ? $t('editShipClass') : $t('createShipClass') }}</h2>
    <TextField
        class="margin-top"
        v-model.trim="properties.name"
        :label="$t('name')"
        :readonly="isLoading"
        :required="true"
        :errors="errors.name"
    />
    <TextArea
        class="margin-top"
        v-model="properties.description"
        :label="$t('descriptionMD')"
        :readonly="isLoading"
        :required="true"
        :isCode="true"
        :errors="errors.description"
        @input="$emit('update:description', properties.description);"
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
import { CreateShipClass, ShipClass, PatchShipClass } from '@/interfaces/constructions/shipClass';
import * as shipClassService from '@/services/constructions/shipClassService';
import TextField from '@/components/controls/TextField.vue';
import TextArea from '@/components/controls/TextArea.vue';
import Button from '@/components/controls/Button';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import Panel from '@/components/layout/Panel.vue';

interface Properties {
    name: string;
    description: string | null;
}

interface Data {
    shipClass: ShipClass | null;
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
    name: '',
    description: defaultMarkdown,
});

export default defineComponent({
    name: 'EditShipClass',
    components: {
        Button,
        LoadingIndicatorBeam,
        Panel,
        TextField,
        TextArea,
    },
    emits: ['created', 'patched', 'cancelled', 'update:description'],
    props: {
        shipClassId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        shipClass: null,
        isLoading: false,
        errors: {},
        properties: getEmptyProperties(),
    }),
    watch: {
        shipClassId(): void {
            this.refreshData();
        },
        properties(): void {
            this.$emit('update:description', this.properties.description);
        },
    },
    computed: {
        changedProperties(): PatchShipClass {
            const changed: PatchShipClass = {};
            if (this.shipClass !== null) {
                Object.keys(this.properties).forEach((key: string) => {
                    if ((this.shipClass as ShipClass)[key as keyof ShipClass] !== (this.properties as PatchShipClass)[key as keyof PatchShipClass]) {
                        changed[key as keyof PatchShipClass] = (this.properties as PatchShipClass)[key as keyof PatchShipClass] as never;
                    }
                });
            }
            return changed;
        },
    },
    methods: {
        mapToProperties(): void {
            if (!this.shipClass) {
                return;
            }
            Object.keys(this.properties).forEach((key) => {
                (this.properties as PatchShipClass)[key as keyof PatchShipClass] = (this.shipClass as ShipClass)[key as keyof ShipClass] as never;
            });
        },
        async saveChanges(): Promise<void> {
            if (this.shipClassId) {
                if (await this.patch()) {
                    this.$emit('patched', this.shipClass);
                }
            } else if (await this.create()) {
                this.$emit('created', this.shipClass);
            }
        },
        refreshData(): void {
            this.properties = getEmptyProperties();
            this.loadShipClass();
        },
        async loadShipClass(): Promise<void> {
            if (!this.shipClassId) {
                return;
            }
            this.isLoading = true;
            try {
                this.shipClass = (await shipClassService.getOneOrDefault(this.shipClassId)).data;
                this.mapToProperties();
                this.$emit('update:description', this.properties.description);
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async create(): Promise<boolean> {
            this.isLoading = true;
            this.errors = {};
            try {
                this.shipClass = (await shipClassService.create(this.properties as CreateShipClass)).data;
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
                this.shipClass = (await shipClassService.patch(
                    this.shipClassId,
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
