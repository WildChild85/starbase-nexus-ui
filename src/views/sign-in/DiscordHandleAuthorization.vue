<template>
    <div class="padding-container">
        <Panel>
            <h2>{{ error }}</h2>
            <p>{{ errorDescription }}</p>
        </Panel>
    </div>
</template>

<script lang="ts">
import { AxiosResponse } from 'axios';
import { defineComponent } from 'vue';
import ViewMixin from '@/mixins/ViewMixin';
import { JwtUser } from '@/interfaces/identity/user';
import * as signInService from '@/services/authentication/signInService';
import { AuthenticationTokenSet } from '@/interfaces/authentication/signIn';
import { ACCESS_TOKEN, REFRESH_TOKEN } from '@/constants/tokens';
import { getDiscordHandleRedirectUri } from '@/helpers';
import Panel from '@/components/layout/Panel.vue';

export default defineComponent({
    name: 'DiscordHandleAuthorization',
    components: {
        Panel,
    },
    mixins: [ViewMixin],
    data: () => ({
        isLoading: false,
        error: '',
        errorDescription: '',
    }),
    computed: {
        user(): JwtUser | null {
            return this.$store.getters['authentication/user'];
        },
    },
    async created(): Promise<void> {
        this.setPageTitle(['Discord Authorization']);
        if (this.user) {
            this.$router.push('/');
            return;
        }

        // ?error=access_denied&error_description=The+resource+owner+or+authorization+server+denied+the+request

        const { query } = this.$route;

        if (query.error) {
            this.error = query.error as string;
        }
        if (query.error_description) {
            this.errorDescription = query.error_description as string;
        }
        if (this.$route.query.code) {
            try {
                const response: AxiosResponse<AuthenticationTokenSet> = await signInService.signInWithDiscord({
                    code: this.$route.query.code as string,
                    redirectUri: getDiscordHandleRedirectUri(),
                });
                const { accessToken, refreshToken } = response.data;
                localStorage.setItem(ACCESS_TOKEN, accessToken);
                localStorage.setItem(REFRESH_TOKEN, refreshToken);
                this.$store.commit('authentication/setUser');
                this.$router.push({ name: 'home' });
            } catch (_) {
                // TODO: show error message
            }
        }
    },
});
</script>
