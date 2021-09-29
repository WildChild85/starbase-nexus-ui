<template>
<div class="app-bar" data-augmented-ui="b-clip-x border">
    <button class="app-bar__btn" @click="openMainNav"><MenuIconOutline class="svg-icon margin-right--f2"/>Menu</button>
    <div class="app-bar__spacer"></div>
    <a class="app-bar__btn" href="https://discord.gg/3AyaHP7aWr" target="_blank">
        <img src="https://cdn.starbase-nexus.net/dd1a4bcf-140b-4bb8-906b-93a18739812d/app-assets/Discord-Logo-White.svg" class="svg-icon margin-right--f2"/>
        Join our discord
    </a>
    <div class="app-bar__views">{{ views }}</div>
    <template v-if="user">
        <div class="app-bar__user">
            <div class="app-bar__user-avatar" data-augmented-ui="tl-clip tr-clip-inset br-clip bl-clip-inset border" :style="userAvatarStyle"></div>
            <div class="app-bar__user-name">{{ user.userName }}</div>
        </div>
        <button class="app-bar__btn padding-left--f2 padding-right--f2" @click="signOut" title="sign out"><LogoutIconOutline class="svg-icon"/></button>
    </template>
    <button class="app-bar__btn" v-else @click="redirectToDiscord">Sign in</button>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { JwtUser } from '@/interfaces/identity/user';
import { redirectToDiscord } from '@/helpers';
import { ROLE_ADMINISTRATOR } from '@/constants/roles';

export default defineComponent({
    name: 'AppBar',
    computed: {
        user(): JwtUser | null {
            return this.$store.getters['authentication/user'];
        },
        isAdmin(): boolean {
            return this.$store.getters['authentication/hasOneRoles'](ROLE_ADMINISTRATOR);
        },
        views(): number {
            return this.$store.getters['views/views'];
        },
        userAvatarStyle(): Record<string, string> {
            if (!this.user) {
                return {};
            }
            return {
                backgroundImage: `url(${this.user.avatarUri})`,
            };
        },
    },
    methods: {
        redirectToDiscord,
        openMainNav(): void {
            this.$store.commit('mainNav/setOpen', true);
        },
        signOut(): void {
            this.$store.commit('authentication/deleteUser');
        },
    },
});
</script>
