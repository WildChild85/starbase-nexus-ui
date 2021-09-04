import { SearchParameters, UuidViewModel } from '@/interfaces/api';

export interface MaterialSearchParameters extends SearchParameters {
    materialCategoryIds?: string | null;
}

export interface Material extends UuidViewModel {
    name: string;
    description: string;
    materialCategoryId: string;
    armor: number | null;
    minArmor: number | null;
    voxelPenetrationMultiplier: number | null;
    corrosionResistance: number | null;
    transformability: number | null;
    structuralDurability: number | null;
    density: number | null;
    oreDensity: number | null;
    iconUriRaw: string | null;
    iconUriRefined: string | null;
    iconUriOreChunk: string | null;
}

export interface CreateMaterial {
    name: string;
    description: string;
    materialCategoryId: string;
    armor?: number | null;
    minArmor?: number | null;
    voxelPenetrationMultiplier?: number | null;
    corrosionResistance?: number | null;
    transformability?: number | null;
    structuralDurability?: number | null;
    density?: number | null;
    oreDensity?: number | null;
    iconUriRaw?: string | null;
    iconUriRefined?: string | null;
    iconUriOreChunk? : string | null;
}

export interface PatchMaterial {
    name?: string;
    description?: string;
    materialCategoryId?: string;
    armor?: number | null;
    minArmor?: number | null;
    voxelPenetrationMultiplier?: number | null;
    corrosionResistance?: number | null;
    transformability?: number | null;
    structuralDurability?: number | null;
    density?: number | null;
    oreDensity?: number | null;
    iconUriRaw?: string | null;
    iconUriRefined?: string | null;
    iconUriOreChunk? : string | null;
}
