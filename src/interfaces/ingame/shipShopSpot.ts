import { SearchParameters, UuidViewModel } from '@/interfaces/api';
import { Ship } from '@/interfaces/constructions/ship';

export interface ShipShopSpotSearchParameters extends SearchParameters {
    shipShopIds?: string | null;
    shipIds?: string | null;
}

export interface ShipShopSpot extends UuidViewModel {
    shipShopId: string;
    shipId: string | null;
    position: number;
    size: number;
    height: number | null;
    width: number | null;
    left: number | null;
    top: number | null;
}

export interface CreateShipShopSpot {
    shipShopId: string;
    shipId?: string | null;
    position: number;
    size: number;
    height?: number | null;
    width?: number | null;
    left?: number | null;
    top?: number | null;
}

export interface PatchShipShopSpot {
    shipId?: string | null;
    size?: number;
    height?: number | null;
    width?: number | null;
    left?: number | null;
    top?: number | null;
}

export interface ShipShopSpotConfigSize {
    size: number;
    width: number;
    height: number;
    hides?: number[];
}
export interface ShipShopSpotConfig {
    id: number;
    class: string;
    x: number;
    y: number;
    sizes: ShipShopSpotConfigSize[];
    spot?: ShipShopSpot | null;
    ship?: Ship | null;
}
