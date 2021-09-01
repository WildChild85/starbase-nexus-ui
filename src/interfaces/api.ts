export interface SearchParameters {
    searchQuery?: string | null;
    page?: number;
    pageSize?: number;
    orderBy?: string;
    fields?: string;
}

export interface ShapingParameters {
    orderBy?: string;
    fields?: string;
}

export interface UuidViewModel {
    id: string;
    createdAt: string;
    updatedAt: string | null;
}

export interface PatchOperation {
    op: string;
    path: string;
    value: any | null;
}

export interface PaginationParameters {
    page: number;
    pages: number;
    pageSize: number;
    total: number;
}
