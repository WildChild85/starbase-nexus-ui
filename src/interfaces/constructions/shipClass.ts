import { UuidViewModel } from '@/interfaces/api';

export interface ShipClass extends UuidViewModel {
    name: string;
    description: string;
}

export interface CreateShipClass {
    name: string;
    description: string;
}

export interface PatchShipClass {
    name?: string;
    description?: string;
}
