import { UuidViewModel } from '@/interfaces/api';

export interface ShipShop extends UuidViewModel {
    moderatorId: string | null;
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
    moderatorId: string | null;
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
    moderatorId?: string | null;
    imageUri?: string | null;
    name?: string;
    description?: string;
    layout?: string;
    height?: number | null;
    width?: number | null;
    left?: number | null;
    top?: number | null;
}
