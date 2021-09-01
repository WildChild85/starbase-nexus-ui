import axios, {
    AxiosError, AxiosInstance, AxiosRequestConfig, AxiosResponse,
} from 'axios';
import store from '@/store';
import unauthorizedApiClient from '@/clients/unauthorizedApiClient';
import { ACCESS_TOKEN, REFRESH_TOKEN } from '@/constants/tokens';
import { AuthenticationTokenSet } from '@/interfaces/authentication/signIn';

export function saveTokens({
    accessToken,
    // eslint-disable-next-line no-shadow
    refreshToken,
}: AuthenticationTokenSet): boolean {
    if (accessToken) {
        localStorage.setItem(ACCESS_TOKEN, accessToken);
    }
    if (refreshToken) {
        localStorage.setItem(REFRESH_TOKEN, refreshToken);
    }
    return true;
}

const authorizedApiClient: AxiosInstance = axios.create({
    baseURL: process.env.VUE_APP_API,
    headers: {
        'Content-Type': 'application/json',
    },
});

function getAccessToken(): string | null {
    return localStorage.getItem(ACCESS_TOKEN);
}

function getRefreshToken(): string | null {
    return localStorage.getItem(REFRESH_TOKEN);
}

function refreshToken(): Promise<AxiosResponse<AuthenticationTokenSet>> {
    return new Promise((resolve, reject) => {
        if (getRefreshToken() === null) {
            reject(new Error('[refresh token] no refresh token found'));
            return;
        }

        const options: AxiosRequestConfig = {
            method: 'post',
            url: '/authentication/signin/refresh',
            data: {
                accessToken: getAccessToken(),
                refreshToken: getRefreshToken(),
            },
        };
        unauthorizedApiClient(options)
            .then((response: AxiosResponse<AuthenticationTokenSet>) => {
                saveTokens(response.data);
                store.commit('authentication/setUser', null, { root: true });
                resolve(response);
            })
            .catch((error: AxiosError) => {
                store.commit('authentication/deleteUser', true, { root: true });
                reject(error);
            });
    });
}

authorizedApiClient.interceptors.request.use((config: AxiosRequestConfig) => {
    const accessToken: string | null = localStorage.getItem(ACCESS_TOKEN);
    const enrichedConfig: AxiosRequestConfig = config;
    if (accessToken !== null) {
        enrichedConfig.headers.Authorization = `Bearer ${accessToken}`;
    }
    return enrichedConfig;
}, (error: AxiosError) => Promise.reject(error));

interface ExtendedAxiosRequestConfig extends AxiosRequestConfig {
    _retry?: boolean;
}

authorizedApiClient.interceptors.response.use(
    (response: AxiosResponse) => response,
    (error: AxiosError) => {
        const originalRequest: ExtendedAxiosRequestConfig = error.config;
        const isUnauthorized: boolean | undefined = error.response && error.response.status === 401;

        // eslint-disable-next-line no-underscore-dangle
        if ((isUnauthorized) && originalRequest._retry !== true) {
            // eslint-disable-next-line no-underscore-dangle
            originalRequest._retry = true;

            return refreshToken()
                .then(() => authorizedApiClient.request(originalRequest))
                // eslint-disable-next-line no-shadow
                .catch((error: AxiosError) => Promise.reject(error));
        }
        return Promise.reject(error);
    },
);
export default authorizedApiClient;
