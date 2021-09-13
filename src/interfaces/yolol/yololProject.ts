import { SearchParameters, UuidViewModel } from '@/interfaces/api';

export interface YololProjectSearchParameters extends SearchParameters {
    creatorIds?: string | null;
}

export interface YololProject extends UuidViewModel {
    name: string
    documentation: string;
    creatorId: string;
    previewImageUri: string | null;
    youtubeVideoUri: string | null;
}

export interface CreateYololProject {
    name: string
    documentation: string;
    previewImageUri: string | null;
    youtubeVideoUri: string | null;
}

export interface PatchYololProject {
    name?: string
    documentation?: string;
    previewImageUri?: string | null;
    youtubeVideoUri?: string | null;
}
