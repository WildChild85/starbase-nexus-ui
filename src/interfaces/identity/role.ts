import { UuidViewModel } from '@/interfaces/api';

export interface Role extends UuidViewModel {
    name: string;
}

export interface CreateRole {
    name: string;
}

export interface PatchRole {
    name?: string;
}
