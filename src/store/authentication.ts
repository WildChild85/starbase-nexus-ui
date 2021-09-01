import { ROLE_ADMINISTRATOR } from '@/constants/roles';
import { ACCESS_TOKEN, REFRESH_TOKEN } from '@/constants/tokens';
import { JwtUser } from '@/interfaces/identity/user';

export interface AuthenticationStoreState {
    user: JwtUser | null;
}

const authentication = {
    namespaced: true,
    state: (): AuthenticationStoreState => ({
        user: null,
    }),
    getters: {
        user: (state: AuthenticationStoreState): JwtUser | null => state.user,
        hasOneRoles: (state: AuthenticationStoreState) => (targetRoles: string[]): boolean => {
            const { user } = state;
            let hasOneRole = false;

            const combinedTargetRoles = [ROLE_ADMINISTRATOR, ...targetRoles];
            if (!user) {
                return false;
            }

            combinedTargetRoles.forEach((targetRole) => {
                user.roles.forEach((role: string) => {
                    if (role.toUpperCase() === targetRole.toUpperCase()) {
                        hasOneRole = true;
                    }
                });
            });
            return hasOneRole;
        },
    },
    mutations: {
        setUser(state: AuthenticationStoreState): void {
            const accessToken: string | null = localStorage.getItem(ACCESS_TOKEN);
            if (accessToken) {
                state.user = JSON.parse(window.atob(accessToken.split('.')[1]));
            } else {
                state.user = null;
            }
        },
        deleteUser(state: AuthenticationStoreState, deleteOnly = false): void {
            if (state.user) {
                if (deleteOnly) {
                    localStorage.removeItem(ACCESS_TOKEN);
                    localStorage.removeItem(REFRESH_TOKEN);
                    state.user = null;
                } else {
                    localStorage.removeItem(ACCESS_TOKEN);
                    localStorage.removeItem(REFRESH_TOKEN);
                    state.user = null;
                }
            } else {
                localStorage.removeItem(ACCESS_TOKEN);
                localStorage.removeItem(REFRESH_TOKEN);
            }
        },
    },
    actions: {},
};

export default authentication;
