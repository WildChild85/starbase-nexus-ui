import { UuidViewModel } from '@/interfaces/api';

export interface ShipRole extends UuidViewModel {
    name: string;
}

export interface CreateShipRole {
    name: string;
}

export interface PatchShipRole {
    name?: string;
}
