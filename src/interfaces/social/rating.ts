import { SearchParameters, UuidViewModel } from '@/interfaces/api';

export interface RatingSearchParameters extends SearchParameters {
    shipIds?: string | null;
    userIds?: string | null;
}

export interface Rating extends UuidViewModel {
    stars: number;
    shipId: string;
    userId: string;
    comment: string | null;
}

export interface CreateRating {
    stars: number;
    shipId: string;
    comment?: string | null;
}

export interface PatchRating {
    stars?: number;
    comment?: string | null;
}
