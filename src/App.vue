<template>
<!-- <video autoplay="" muted="" loop="" id="bg-video">
    <source src="https://starbasegame.com/videos/background.webm" type="video/mp4">
    Your browser does not support HTML5 video.
</video> -->
<div id="page">
    <router-view/>
</div>
<AppBar />
<MainNav />
<div id="dialogs"></div>
<div id="loading-indicator-beam-wrapper"></div>
<notifications position="bottom right">
</notifications>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import * as signalR from '@/signalR';
import AppBar from '@/components/navigation/AppBar.vue';
import MainNav from '@/components/navigation/MainNav.vue';
import { JwtUser } from './interfaces/identity/user';
import { ROLE_MODERATOR } from './constants/roles';

export default defineComponent({
    name: 'App',
    components: {
        AppBar,
        MainNav,
    },
    computed: {
        isAdmin(): boolean {
            return this.$store.getters['authentication/hasOneRoles']([]);
        },
        isModerator(): boolean {
            return this.$store.getters['authentication/hasOneRoles']([ROLE_MODERATOR]);
        },
        user(): JwtUser | null {
            return this.$store.getters['authentication/user'];
        },
    },
    created() {
        this.$store.commit('authentication/setUser');
        window.setInterval(() => {
            if (signalR.isConnected()) {
                signalR.notify();
            } else {
                signalR.startConnection();
            }
        }, 30000);
    },
    mounted(): void {
        (window as any).isModerator = () => this.isModerator;
        (window as any).isAdmin = () => this.isAdmin;
        (window as any).user = () => this.user;
    },
    unmounted(): void {
        (window as any).isModerator = undefined;
        (window as any).isAdmin = undefined;
        (window as any).user = undefined;
    },
});
</script>

<style lang="scss">
    @import "scss/index";
</style>
