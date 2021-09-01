<template>
<video autoplay="" muted="" loop="" id="bg-video">
    <source src="https://starbasegame.com/videos/background.webm" type="video/mp4">
    Your browser does not support HTML5 video.
</video>
<router-view/>
<div id="dialogs"></div>
<div id="loading-indicator-beam-wrapper"></div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { JwtUser } from '@/interfaces/identity/user';

export default defineComponent({
    name: 'App',
    computed: {
        user(): JwtUser | null {
            return this.$store.getters['authentication/user'];
        },
    },
    created() {
        this.$store.commit('authentication/setUser');
    },
});
</script>

<style lang="scss">
    @import "scss/index";
</style>
