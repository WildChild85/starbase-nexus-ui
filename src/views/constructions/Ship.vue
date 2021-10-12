<template>
<div class="ship">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <div class="flex flex--stretch-vertical flex--space-between-children flex--wrap-lg">
            <Panel class="flex__item flex__item--w-50-lg">
                <EditShip
                    v-if="showEdit || !shipId"
                    :shipId="shipId"
                    ref="editShip"
                    @created="handleCreated"
                    @patched="handlePatched"
                    @cancelled="handleCancelled"
                    @update:description="handleUpdateDescription"
                />
                <template v-else>
                    <div class="ship__header-actions" v-if="hasEditRights">
                        <SelectSingleReference
                            v-if="isModerator"
                            class="margin-right"
                            v-model="newCreatorId"
                            :label="$t('creator')"
                            :readonly="isLoading"
                            :service="publicUserService"
                            orderBy="userName"
                            labelProperty="userName"
                            imageProperty="avatarUri"
                            @update:modelValue="patchCreator"
                        />
                        <Button :title="$t('edit')" @click="showEdit = true">
                            <PencilAltIconSolid class="svg-icon"/>
                        </Button>
                    </div>
                    <div class="ship__meta">
                        <div class="ship__header">
                            <h1 class="ship__name">{{ ship ? ship.name : '' }}</h1>
                            <div class="ship__description">
                                <Markdown
                                    v-if="ship && ship.description"
                                    :source="ship.description"
                                    :plugins="markdownPlugins"
                                />
                            </div>
                        </div>
                        <div class="ship__class">
                            <template v-if="shipClass">
                                <h2>{{ $t('shipClass')}}: {{ shipClass.name }}</h2>
                                <Markdown
                                    :source="shipClass.description"
                                    :plugins="markdownPlugins"
                                />
                            </template>
                        </div>
                    </div>
                    <ShipInfoMatrix
                        :ship="ship"
                        :creator="creator"
                        :armorMaterial="armorMaterial"
                        :shipClass="shipClass"
                        :company="company"
                    />
                </template>
            </Panel>
            <Panel class="flex__item flex__item--w-50-lg">
                <div v-if="!shipId || showEdit">
                    <h2 class="text--primary">Guides for creating a ship</h2>
                    <ol>
                        <li>First of all: Thank you for participation.</li>
                        <li>A preview image is not required, but it helps alot.</li>
                        <li>A youtube video is also not required.</li>
                        <li>The description supports markdown (<a href="https://en.wikipedia.org/wiki/Markdown" target="_blank">Wikipedia</a>).</li>
                        <li>After the description, you can select gallery images.</li>
                    </ol>
                    <div class="ship__description" style="margin-top: 180px">
                        <h2>{{ $t('description') }} ({{ $t('preview') }})</h2>
                        <Markdown
                            :source="editDescription"
                            :plugins="markdownPlugins"
                        />
                    </div>
                </div>
                <template v-else>
                    <div
                        class="ship__youtube-video"
                        data-augmented-ui="tl-clip t-clip-x tr-clip r-clip-y br-clip b-clip-x bl-clip l-clip-y border"
                    >
                        <YouTube
                            v-if="ship && ship.youtubeVideoUri"
                            :src="ship.youtubeVideoUri"
                            ref="youtube"
                        />
                    </div>
                    <img
                        v-for="imageUri in imageUris"
                        :key="imageUri"
                        class="ship__image"
                        data-augmented-ui="tl-clip t-clip-x tr-clip r-clip-y br-clip b-clip-x bl-clip l-clip-y border"
                        :src="imageUri"
                    />
                </template>
            </Panel>
        </div>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Markdown from 'vue3-markdown-it';
import MarkdownAbbr from 'markdown-it-abbr';
import MarkdownAnchor from 'markdown-it-anchor';
import MarkdownDeflist from 'markdown-it-deflist';
import MarkdownEmoji from 'markdown-it-emoji';
import MarkdownFootnote from 'markdown-it-footnote';
import MarkdownHighlightJs from 'markdown-it-highlightjs';
import MarkdownIns from 'markdown-it-ins';
import MarkdownMark from 'markdown-it-mark';
import MarkdownSub from 'markdown-it-sub';
import MarkdownSup from 'markdown-it-sup';
import MarkdownTaskLists from 'markdown-it-task-list';
import MarkdownTocDoneRight from 'markdown-it-toc-done-right';
import YouTube from 'vue3-youtube';

import Panel from '@/components/layout/Panel.vue';
import ViewMixin from '@/mixins/ViewMixin';
import * as shipService from '@/services/constructions/shipService';
import * as shipClassService from '@/services/constructions/shipClassService';
import * as publicUserService from '@/services/social/publicUserService';
import * as materialService from '@/services/ingame/materialService';
import * as companyService from '@/services/social/companyService';
import { Ship } from '@/interfaces/constructions/ship';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import EditShip from '@/components/constructions/ship/EditShip.vue';
import 'highlight.js';
import 'highlight.js/styles/monokai.css';
import { JwtUser } from '@/interfaces/identity/user';
import Button from '@/components/controls/Button';
import { PublicUser } from '@/interfaces/social/publicUser';
import { redirectToDiscord } from '@/helpers/index';
import { ROLE_MODERATOR } from '@/constants/roles';
import ShipInfoMatrix from '@/components/constructions/ship/ShipInfoMatrix.vue';
import { Material } from '@/interfaces/ingame/material';
import { ShipClass } from '@/interfaces/constructions/shipClass';
import { Company } from '@/interfaces/social/company';
import SelectSingleReference from '@/components/controls/SelectSingleReference.vue';

interface Data {
    isLoading: boolean;
    ship: Ship | null;
    creator: PublicUser | null;
    armorMaterial: Material | null;
    shipClass: ShipClass | null;
    company: Company | null;
    showEdit: boolean;
    editDescription: string;
    newCreatorId: string | null;
}

export default defineComponent({
    name: 'Ship',
    components: {
        Button,
        EditShip,
        LoadingIndicatorBeam,
        Markdown,
        Panel,
        SelectSingleReference,
        ShipInfoMatrix,
        YouTube,
    },
    mixins: [ViewMixin],
    props: {
        shipId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        isLoading: false,
        ship: null,
        creator: null,
        armorMaterial: null,
        shipClass: null,
        company: null,
        showEdit: false,
        editDescription: '',
        newCreatorId: null,
    }),
    watch: {
        shipId(): void {
            this.ship = null;
            this.creator = null;
            this.armorMaterial = null;
            this.shipClass = null;
            this.company = null;
            this.refreshData();
        },
    },
    computed: {
        isModerator(): boolean {
            return this.$store.getters['authentication/hasOneRoles'](ROLE_MODERATOR);
        },
        hasEditRights(): boolean | null {
            return this.isModerator || (this.user && this.ship && this.user.id === this.ship.creatorId);
        },
        user(): JwtUser | null {
            return this.$store.getters['authentication/user'];
        },
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        markdownPlugins(): Record<string, any>[] {
            return [
                { plugin: MarkdownAbbr },
                { plugin: MarkdownAnchor },
                { plugin: MarkdownDeflist },
                { plugin: MarkdownEmoji },
                { plugin: MarkdownFootnote },
                { plugin: MarkdownHighlightJs },
                { plugin: MarkdownMark },
                { plugin: MarkdownIns },
                { plugin: MarkdownSub },
                { plugin: MarkdownSup },
                { plugin: MarkdownTaskLists },
                { plugin: MarkdownTocDoneRight },
            ];
        },
        imageUris(): string[] {
            if (this.ship && this.ship.imageUris) {
                return this.ship.imageUris.split(',');
            }
            return [];
        },
        publicUserService(): unknown {
            return publicUserService;
        },
    },
    methods: {
        redirectToDiscord,
        handleUpdateDescription(description: string): void {
            this.editDescription = description;
        },
        handleCreated(ship: Ship): void {
            this.$router.push({
                name: 'constructions_ship',
                params: {
                    shipId: ship.id,
                },
            });
        },
        handlePatched(): void {
            this.showEdit = false;
            this.refreshData();
        },
        handleCancelled(): void {
            this.showEdit = false;
            if (!this.shipId) {
                this.$router.back();
            }
        },
        async refreshData(): Promise<void> {
            await this.loadShip();
            await this.loadCreator();
            await this.loadArmorMaterial();
            await this.loadShipClass();
            await this.loadCompany();
        },
        async loadShip(): Promise<void> {
            if (!this.shipId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await shipService.getOneOrDefault(this.shipId);
                this.ship = response.data;
                this.newCreatorId = this.ship.creatorId;
                this.setPageTitle([this.ship.name, this.$t('ship'), this.$t('constructions')]);
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadCreator(): Promise<void> {
            if (!this.ship || !this.ship.creatorId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await publicUserService.getOneOrDefault(this.ship.creatorId);
                this.creator = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadArmorMaterial(): Promise<void> {
            if (!this.ship || !this.ship.armorMaterialId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await materialService.getOneOrDefault(this.ship.armorMaterialId);
                this.armorMaterial = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadShipClass(): Promise<void> {
            if (!this.ship || !this.ship.shipClassId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await shipClassService.getOneOrDefault(this.ship.shipClassId);
                this.shipClass = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadCompany(): Promise<void> {
            if (!this.ship || !this.ship.companyId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await companyService.getOneOrDefault(this.ship.companyId);
                this.company = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async patchCreator(): Promise<void> {
            if (!this.ship) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await shipService.patchCreator(
                    this.ship.id,
                    {
                        creatorId: this.newCreatorId,
                    },
                );
                this.ship = response.data;
                this.$notify({
                    type: 'success',
                    text: this.$t('saved'),
                });
            } catch (_) {
                this.$notify({
                    type: 'error',
                    text: this.$t('savingFailed'),
                });
                this.newCreatorId = this.ship.creatorId;
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('ship'), this.$t('constructions')]);
        this.refreshData();
    },
});
</script>
