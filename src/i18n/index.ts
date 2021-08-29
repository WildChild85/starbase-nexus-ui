import { createI18n, I18nOptions } from 'vue-i18n';
import messagesEn from '@/i18n/en.json';

export const messages = {
    en: messagesEn,
};

export const defaultLocale = 'en';

export function getLanguageFromLocale(locale: string): string | null {
    if (locale.length === 2) {
        return locale.toLocaleLowerCase();
    }
    let parts = locale.split('-');
    if (parts.length > 0) {
        if (parts[0].length === 2) {
            return parts[0].toLocaleLowerCase();
        }
    }
    parts = locale.split('_');
    if (parts.length > 0) {
        if (parts[0].length === 2) {
            return parts[0].toLocaleLowerCase();
        }
    }
    return null;
}

// 2. Create i18n instance with options
export const i18nOptions: I18nOptions = {
    locale: defaultLocale, // set locale
    fallbackLocale: defaultLocale, // set fallback locale
    messages, // set locale messages
    // If you need to specify other options, you can set other options
    // ...
    warnHtmlInMessage: 'off',
};

const i18n = createI18n(i18nOptions);

export default i18n;
