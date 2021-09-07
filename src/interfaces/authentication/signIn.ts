export interface AuthenticationTokenSet {
    accessToken: string;
    refreshToken: string;
}

export interface DiscordSignIn {
    code: string;
    redirectUri: string;
}
