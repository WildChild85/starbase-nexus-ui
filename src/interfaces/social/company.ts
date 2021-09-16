import { UuidViewModel } from '@/interfaces/api';

export interface Company extends UuidViewModel {
    name: string;
    aboutUs: string;
    logoUri: string | null;
    discordUri: string | null;
    websiteUri: string | null;
    youtubeUri: string | null;
    twitchUri: string | null;
    creatorId: string;
}

export interface CreateCompany {
    name: string;
    aboutUs: string;
    logoUri?: string | null;
    discordUri?: string | null;
    websiteUri?: string | null;
    youtubeUri?: string | null;
    twitchUri?: string | null;
}

export interface PatchCompany {
    name?: string;
    aboutUs?: string;
    logoUri?: string | null;
    discordUri?: string | null;
    websiteUri?: string | null;
    youtubeUri?: string | null;
    twitchUri?: string | null;
}
