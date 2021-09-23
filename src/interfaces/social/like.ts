import { UuidViewModel, SearchParameters } from '@/interfaces/api';

export interface LikeSearchParameters extends SearchParameters {
    userIds?: string;
    yololProjectIds?: string | null;
    guideIds?: string | null;
}

export interface Like extends UuidViewModel {
    userId: string;
    yololProjectId: string | null;
    guideId: string | null;
}

export interface CreateLike {
    yololProjectId?: string | null;
    guideId?: string | null;
}
