<template>
<div class="app-bar" data-augmented-ui="b-clip-x border">
    <div class="app-bar__spacer"></div>

    <router-link
        v-for="(navItem, index) in navItems"
        class="app-bar__btn"
        :to="navItem.to"
        :key="index"
    >{{ navItem.label }}</router-link>

    <div class="app-bar__user" v-if="user">
        <div class="app-bar__user-avatar" data-augmented-ui="tl-clip tr-clip-inset br-clip bl-clip-inset border" :style="userAvatarStyle"></div>
        <div class="app-bar__user-name">{{ user.userName }}</div>
    </div>
    <button class="app-bar__btn" v-else @click="redirectToDiscord">Sign in</button>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { RouteLocationRaw } from 'vue-router';
import { JwtUser } from '@/interfaces/identity/user';
import { redirectToDiscord } from '@/helpers';
import { ROLE_ADMINISTRATOR } from '@/constants/roles';

interface NavItem {
    to: RouteLocationRaw,
    label: string;
}

export default defineComponent({
    name: 'AppBar',
    computed: {
        user(): JwtUser | null {
            return this.$store.getters['authentication/user'];
        },
        isAdmin(): boolean {
            return this.$store.getters['authentication/hasOneRoles'](ROLE_ADMINISTRATOR);
        },
        userAvatarStyle(): Record<string, string> {
            if (!this.user) {
                return {};
            }
            return {
                backgroundImage: `url(${this.user.avatarUri})`,
            };
        },
        navItems(): NavItem[] {
            const navItems = [
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
                    to: { name: 'identity_users' },
                    label: this.$t('users'),
                });
            }
            return navItems;
        },
    },
    methods: {
        redirectToDiscord,
    },
});
</script>
