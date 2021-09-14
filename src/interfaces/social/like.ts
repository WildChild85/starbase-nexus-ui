import { UuidViewModel, SearchParameters } from '@/interfaces/api';

export interface LikeSearchParameters extends SearchParameters {
    userIds?: string;
    yololProjectIds?: string;
}

export interface Like extends UuidViewModel {
    userId: string;
    yololProjectId: string | null;
}

export interface CreateLike {
    yololProjectId?: string | null;
}
