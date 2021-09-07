<template>
<div class="main-nav" v-if="showMainNav">
    <Overlay @click="hideMainNav" />
    <div class="main-nav__content" data-augmented-ui="r-clip-y border">
        <div data-augmented-ui-reset>
            <template
                v-for="(navItem, index) in navItems"
                :key="index"
            >
                <router-link
                    v-if="navItem.to"
                    class="main-nav__item"
                    :to="navItem.to"
                    @click="hideMainNav"
                >{{ navItem.label }}</router-link>
                <div v-else class="main-nav__separator" data-augmented-ui="br-clip-x bl-clip-x border">{{ navItem.label }}</div>
            </template>
        </div>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { RouteLocationRaw } from 'vue-router';
import { JwtUser } from '@/interfaces/identity/user';
import { redirectToDiscord } from '@/helpers';
import { ROLE_ADMINISTRATOR } from '@/constants/roles';
import Overlay from '@/components/dialogs/Overlay.vue';

interface NavItem {
    to?: RouteLocationRaw,
    label: string;
}

export default defineComponent({
    name: 'MainNav',
    components: {
        Overlay,
    },
    computed: {
        user(): JwtUser | null {
            return this.$store.getters['authentication/user'];
        },
        showMainNav(): JwtUser | null {
            return this.$store.getters['mainNav/open'];
        },
        isAdmin(): boolean {
            return this.$store.getters['authentication/hasOneRoles'](ROLE_ADMINISTRATOR);
        },
        navItems(): NavItem[] {
            const navItems = [
                {
                    to: { name: 'home' },
                    label: this.$t('Home'),
                },
                {
                    label: this.$t('tools'),
                },
                {
                    to: { name: 'ingame_maps' },
                    label: this.$t('maps'),
                },
                {
                    to: { name: 'tools_engine-comparison' },
                    label: this.$t('engineComparison'),
                },
                {
                    label: this.$t('dataManagement'),
                },
                {
                    to: { name: 'ingame_material-categories' },
                    label: this.$t('materialCategories'),
                },
                {
                    to: { name: 'ingame_materials' },
                    label: this.$t('materials'),
                },
                {
                    to: { name: 'ingame_item-categories' },
                    label: this.$t('itemCategories'),
                },
                {
                    to: { name: 'ingame_items' },
                    label: this.$t('items'),
                },
            ];
            if (this.isAdmin) {
                navItems.push({
                    label: this.$t('administration'),
                });
                navItems.push({
                    to: { name: 'identity_users' },
                    label: this.$t('users'),
                });
            }
            return navItems;
        },
    },
    methods: {
        redirectToDiscord,
        hideMainNav(): void {
            this.$store.commit('mainNav/setOpen', false);
        },
    },
});
</script>
