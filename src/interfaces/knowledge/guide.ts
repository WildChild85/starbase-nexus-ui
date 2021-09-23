import { UuidViewModel } from '@/interfaces/api';

export interface Guide extends UuidViewModel {
    title: string;
    bodytext: string | null;
    youtubeVideoUri: string | null;
    creatorId: string;
}

export interface CreateGuide {
    title: string;
    bodytext?: string | null;
    youtubeVideoUri?: string | null;
}

export interface PatchGuide {
    title?: string;
    bodytext?: string | null;
    youtubeVideoUri?: string | null;
}
