<template>
<div class="company">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <div class="flex flex--stretch-vertical flex--space-between-children flex--wrap-lg">
            <Panel class="flex__item flex__item--w-50-lg">
                <EditCompany
                    v-if="showEdit || !companyId"
                    :companyId="companyId"
                    ref="editCompany"
                    @created="handleCreated"
                    @patched="handlePatched"
                    @cancelled="handleCancelled"
                    @update:aboutUs="handleUpdateAboutUs"
                />
                <template v-else>
                    <div
                        class="company__logo"
                        :style="logoStyle"
                    ></div>
                    <div class="company__header">
                        <h1 class="company__name">{{ company ? company.name : '' }}</h1>
                        <Button v-if="hasEditRights" :title="$t('edit')" @click="showEdit = true"><PencilAltIconSolid class="svg-icon"/></Button>
                    </div>
                    <div class="company__meta">
                        <Button v-if="company && company.discordUri" :href="company.discordUri">
                            <img src="https://cdn.starbase-nexus.net/dd1a4bcf-140b-4bb8-906b-93a18739812d/app-assets/Discord-Logo-White.svg" class="svg-icon margin-right--f2"/>
                            Discord
                        </Button>
                        <Button v-if="company && company.websiteUri" :href="company.websiteUri">
                            <ExternalLinkIconOutline class="svg-icon margin-right--f2" />
                            Website
                        </Button>
                        <Button v-if="company && company.youtubeUri" :href="company.youtubeUri">
                            <img src="https://cdn.starbase-nexus.net/dd1a4bcf-140b-4bb8-906b-93a18739812d/app-assets/1280px-YouTube_light_icon_2017.svg.png" class="svg-icon margin-right--f2"/>
                            Youtube
                        </Button>
                        <Button v-if="company && company.twitchUri" :href="company.twitchUri">
                            <img src="https://cdn.starbase-nexus.net/dd1a4bcf-140b-4bb8-906b-93a18739812d/app-assets/twitch-seeklogo.com.svg" class="svg-icon margin-right--f2"/>
                            Twitch
                        </Button>
                    </div>
                </template>
            </Panel>
            <Panel class="flex__item flex__item--w-50-lg">
                <div v-if="!companyId || showEdit">
                    <h2 class="text--primary">Rules for creating a company</h2>
                    <ol>
                        <li>Only create a company, if you are in the leadership of the company or got permission from the leadership of the company.</li>
                        <li>This website is a neutral space. If you create fake companies or create the company record where rule #1 doesn't match, the entry will be deleted.</li>
                        <li>Don't use your company record to talk bad about other companies or players.</li>
                        <li>The about us supports markdown (<a href="https://en.wikipedia.org/wiki/Markdown" target="_blank">Wikipedia</a>).</li>
                    </ol>
                    <div class="company__about-us" style="margin-top: 610px">
                        <h2>{{ $t('aboutUs') }} ({{ $t('preview') }})</h2>
                        <Markdown
                            :source="editAboutUs"
                            :plugins="markdownPlugins"
                        />
                    </div>
                </div>
                <div v-else class="company__about-us">
                    <Markdown
                        v-if="company"
                        :source="company.aboutUs"
                        :plugins="markdownPlugins"
                    />
                </div>
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

import Panel from '@/components/layout/Panel.vue';
import ViewMixin from '@/mixins/ViewMixin';
import * as companyService from '@/services/social/companyService';
import { Company } from '@/interfaces/social/company';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import EditCompany from '@/components/social/company/EditCompany.vue';
import 'highlight.js';
import 'highlight.js/styles/monokai.css';
import { JwtUser } from '@/interfaces/identity/user';
import Button from '@/components/controls/Button';

interface Data {
    isLoading: boolean;
    company: Company | null;
    showEdit: boolean;
    editAboutUs: string;
}

export default defineComponent({
    name: 'Company',
    components: {
        Button,
        EditCompany,
        Markdown,
        Panel,
        LoadingIndicatorBeam,
    },
    mixins: [ViewMixin],
    props: {
        companyId: {
            type: String,
            default: null,
        },
    },
    data: (): Data => ({
        isLoading: false,
        company: null,
        showEdit: false,
        editAboutUs: '',
    }),
    watch: {
        companyId(): void {
            this.company = null;
            this.refreshData();
        },
    },
    computed: {
        hasEditRights(): boolean | null {
            return this.user && this.company && this.user.id === this.company.creatorId;
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
        logoStyle(): Record<string, string> {
            return {
                backgroundImage: this.company && this.company.logoUri ? `url('${this.company.logoUri}')` : '',
            };
        },
    },
    methods: {
        handleUpdateAboutUs(aboutUs: string): void {
            this.editAboutUs = aboutUs;
        },
        handleCreated(company: Company): void {
            this.$router.push({
                name: 'social_company',
                params: {
                    companyId: company.id,
                },
            });
        },
        handlePatched(): void {
            this.showEdit = false;
            this.refreshData();
        },
        handleCancelled(): void {
            this.showEdit = false;
            if (!this.companyId) {
                this.$router.push({ name: 'social_companies' });
            }
        },
        async refreshData(): Promise<void> {
            await this.loadCompany();
        },
        async loadCompany(): Promise<void> {
            if (!this.companyId) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await companyService.getOneOrDefault(this.companyId);
                this.company = response.data;
                this.setPageTitle([this.company.name, this.$t('company'), this.$t('social')]);
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('company'), this.$t('social')]);
        this.refreshData();
    },
});
</script>
