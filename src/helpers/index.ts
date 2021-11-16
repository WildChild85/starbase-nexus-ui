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

export function whatDecimalSeparator(): string {
    const n = 1.1;
    const nf = n.toLocaleString().substring(1, 2);
    return nf;
}

export const numberToLocaleString = (value: number | null | undefined, minimumFractionDigits = 3, maximumFractionDigits = 3): string | null => {
    if ([undefined, null].includes(value as never)) {
        return null;
    }

    const raw = (value as number).toLocaleString(undefined, { minimumFractionDigits, maximumFractionDigits });
    if (maximumFractionDigits > 0) {
        const [beforeFraction, fraction] = raw.split(whatDecimalSeparator());
        if (fraction && fraction.length > 0) {
            return `${beforeFraction},<span class="text--ghost">${fraction}</span>`;
        }
    }
    return raw;
};

export function getRequiredYololChip(code: string): 'Basic' | 'Advanced' | 'Professional' {
    const codeSegmentsProfessional = [
        'SIN ',
        'COS ',
        'TAN ',
        'ASIN ',
        'ACOS ',
        'ATAN ',
    ];
    const codeSegmentsAdvanced = [
        '^=',
        '%=',
        '^',
        '%',
        'ABS ',
        'SQRT ',
    ];
    const codeUC = code.toUpperCase();
    if (codeSegmentsProfessional.some((segment) => codeUC.includes(segment))) return 'Professional';
    if (codeSegmentsAdvanced.some((segment) => codeUC.includes(segment))) return 'Advanced';

    // the Factorial operator ! needs a special treadment, because of != which works everywhere.
    const appearances = codeUC.split('').reduce((indexes: number[], char: string, currentIndex: number) => {
        if (char === '!' && codeUC.substr(currentIndex, 2) !== '!=') indexes.push(currentIndex);
        return indexes;
    }, []);
    if (appearances.length > 0) return 'Advanced';

    return 'Basic';
}
