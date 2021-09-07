<template>
<div class="app-bar" data-augmented-ui="b-clip-x border">
    <button class="app-bar__btn" @click="openMainNav"><MenuIconOutline class="svg-icon"/></button>
    <div class="app-bar__spacer"></div>

    <div class="app-bar__user" v-if="user">
        <div class="app-bar__user-avatar" data-augmented-ui="tl-clip tr-clip-inset br-clip bl-clip-inset border" :style="userAvatarStyle"></div>
        <div class="app-bar__user-name">{{ user.userName }}</div>
    </div>
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
    },
});
</script>
