import { SearchParameters, UuidViewModel } from '@/interfaces/api';

export interface YololScriptSearchParameters extends SearchParameters {
    projectIds?: string | null;
}

export interface YololScript extends UuidViewModel {
    code: string;
    name: string | null;
    projectId: string;
}

export interface CreateYololScript {
    code: string;
    name?: string | null;
    projectId: string;
}

export interface PatchYololScript {
    code?: string;
    name?: string | null;
}

export interface FetchedYololScript {
    code: string;
    name: string | null;
}
