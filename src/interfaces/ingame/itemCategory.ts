import { SearchParameters, UuidViewModel } from '@/interfaces/api';

export interface ItemCategorySearchParameters extends SearchParameters {
    parentIds?: string | null;
}

export interface ItemCategory extends UuidViewModel {
    name: string;
    description: string | null;
    parentId: string | null;
}

export interface CreateItemCategory {
    name: string;
    description?: string | null;
    parentId?: string | null;
}

export interface PatchItemCategory {
    name?: string;
    description?: string | null;
    parentId?: string | null;
}
