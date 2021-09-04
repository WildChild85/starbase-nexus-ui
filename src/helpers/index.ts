// eslint-disable-next-line import/prefer-default-export
export function uniqueId(): string {
    return `_${Math.random().toString(36).substr(2, 9)}`;
}

export function getDiscordHandleRedirectUri(): string {
    return `${window.location.origin}/sign-in/discord`;
}

export function redirectToDiscord(): void {
    const redirectUri = encodeURIComponent(getDiscordHandleRedirectUri());
    window.location.href = `https://discord.com/api/oauth2/authorize?client_id=${process.env.VUE_APP_DISCORD_CLIENT_ID}&redirect_uri=${redirectUri}&response_type=code&scope=identify`;
}
