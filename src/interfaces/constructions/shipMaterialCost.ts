import { SearchParameters, UuidViewModel } from '@/interfaces/api';

export interface ShipMaterialCostSearchParameters extends SearchParameters {
    shipIds?: string | null;
    materialIds?: string | null;
}

export interface ShipMaterialCost extends UuidViewModel {
    shipId: string;
    materialId: string;
    voxels: number;
}

export interface CreateShipMaterialCost {
    shipId: string;
    materialId: string;
    voxels: number;
}

export interface PatchShipMaterialCost {
    voxels: number;
}
