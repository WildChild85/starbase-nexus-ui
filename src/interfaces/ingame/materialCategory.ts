import { UuidViewModel } from '@/interfaces/api';

export interface MaterialCategory extends UuidViewModel {
    name: string;
    description: string;
}

export interface CreateMaterialCategory {
    name: string;
    description: string;
}

export interface PatchMaterialCategory {
    name?: string;
    description?: string;
}
