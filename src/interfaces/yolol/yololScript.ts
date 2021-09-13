import { SearchParameters, UuidViewModel } from '@/interfaces/api';

export interface YololScriptSearchParameters extends SearchParameters {
    projectIds?: string | null;
}

export interface YololScript extends UuidViewModel {
    code: string;
    projectId: string;
}

export interface CreateYololScript {
    code: string;
    projectId: string;
}

export interface PatchYololScript {
    code?: string;
}
