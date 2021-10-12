import { UuidViewModel } from '@/interfaces/api';

export interface ShipShop extends UuidViewModel {
    imageUri: string | null;
    name: string;
    description: string;
    layout: string;
    height: number | null;
    width: number | null;
    left: number | null;
    top: number | null;
}

export interface CreateShipShop {
    imageUri?: string | null;
    name: string;
    description: string;
    layout: string;
    height?: number | null;
    width?: number | null;
    left?: number | null;
    top?: number | null;
}

export interface PatchShipShop {
    imageUri?: string | null;
    name?: string;
    description?: string;
    layout?: string;
    height?: number | null;
    width?: number | null;
    left?: number | null;
    top?: number | null;
}
