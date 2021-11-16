import { SearchParameters, UuidViewModel } from '@/interfaces/api';
import { FetchedYololScript } from '@/interfaces/yolol/yololScript';

export interface YololProjectSearchParameters extends SearchParameters {
    creatorIds?: string | null;
}

export interface YololProject extends UuidViewModel {
    name: string
    documentation: string | null;
    fetchConfigUri: string | null;
    creatorId: string;
    previewImageUri: string | null;
    youtubeVideoUri: string | null;
}

export interface CreateYololProject {
    name: string
    documentation?: string | null;
    fetchConfigUri?: string | null;
    previewImageUri: string | null;
    youtubeVideoUri: string | null;
}

export interface PatchYololProject {
    name?: string
    documentation?: string | null;
    fetchConfigUri?: string | null;
    previewImageUri?: string | null;
    youtubeVideoUri?: string | null;
}

export interface FetchedYololProject {
    documentation: string;
    scripts: FetchedYololScript[];
}
