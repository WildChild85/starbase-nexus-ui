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

export default defineComponent({
    name: 'App',
    components: {
        AppBar,
        MainNav,
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
});
</script>

<style lang="scss">
    @import "scss/index";
</style>
