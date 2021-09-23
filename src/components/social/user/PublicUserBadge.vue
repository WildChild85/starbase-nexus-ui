<template>
<div class="public-user-badge">
    <div class="public-user-badge__avatar" data-augmented-ui="tl-clip tr-clip-inset br-clip bl-clip-inset border" :style="userAvatarStyle"></div>
    <div class="public-user-badge__name">{{ user.userName }}</div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { PublicUser } from '@/interfaces/social/publicUser';

export default defineComponent({
    name: 'PublicUserBadge',
    props: {
        user: {
            type: Object,
            required: true,
        },
    },
    computed: {
        typedUser(): PublicUser {
            return this.user as PublicUser;
        },
        userAvatarStyle(): Record<string, string> {
            return {
                backgroundImage: `url(${this.user.avatarUri})`,
            };
        },
    },
});
</script>
