import { AxiosResponse } from 'axios';
import unauthorizedApiClient from '@/clients/unauthorizedApiClient';
import { AuthenticationTokenSet, DiscordSignIn } from '@/interfaces/authentication/signIn';

const BASE_PATH = '/authentication/signin';

export const refreshAccessToken = async (
    payload: AuthenticationTokenSet,
): Promise<AxiosResponse<AuthenticationTokenSet>> => (
    unauthorizedApiClient.post(`${BASE_PATH}/refresh`, payload)
);

export const signInWithDiscord = async (
    payload: DiscordSignIn,
): Promise<AxiosResponse<AuthenticationTokenSet>> => (
    unauthorizedApiClient.post(`${BASE_PATH}/discord`, payload)
);
