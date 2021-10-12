import { AxiosResponse, CancelTokenSource } from 'axios';
import authorizedApiClient from '@/clients/authorizedApiClient';
import {
    CreateShipShopSpot,
    PatchShipShopSpot,
    ShipShopSpot,
    ShipShopSpotSearchParameters,
} from '@/interfaces/ingame/shipShopSpot';
import { PatchOperation, ShapingParameters } from '@/interfaces/api';

const BASE_PATH = '/ingame/shipShopSpot';

export const getMultiple = async (
    params?: ShipShopSpotSearchParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<ShipShopSpot[]>> => (
    authorizedApiClient.get(`${BASE_PATH}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getMultipleByIds = async (
    ids: string[],
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<ShipShopSpot[]>> => (
    authorizedApiClient.get(`${BASE_PATH}/(${ids.join(',')})`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getOneOrDefault = async (
    id: string,
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<ShipShopSpot>> => (
    authorizedApiClient.get(`${BASE_PATH}/${id}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const create = async (
    payload: CreateShipShopSpot,
): Promise<AxiosResponse<ShipShopSpot>> => (
    authorizedApiClient.post(BASE_PATH, payload)
);

export const patch = async (
    id: string,
    patchObj: PatchShipShopSpot,
): Promise<AxiosResponse<ShipShopSpot>> => {
    const keys: string[] = Object.keys(patchObj);
    const patchOperations: PatchOperation[] = keys.map((key: string): PatchOperation => {
        const value = patchObj[key as keyof PatchShipShopSpot] as string | null;
        return {
            op: 'replace',
            path: `/${key}`,
            value,
        };
    });
    return authorizedApiClient.patch(`${BASE_PATH}/${id}`, patchOperations);
};
