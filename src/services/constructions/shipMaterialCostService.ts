import { AxiosResponse, CancelTokenSource } from 'axios';
import authorizedApiClient from '@/clients/authorizedApiClient';
import {
    CreateShipMaterialCost,
    PatchShipMaterialCost,
    ShipMaterialCost,
} from '@/interfaces/constructions/shipMaterialCost';
import { PatchOperation, SearchParameters, ShapingParameters } from '@/interfaces/api';

const BASE_PATH = '/constructions/shipMaterialCost';

export const getMultiple = async (
    params?: SearchParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<ShipMaterialCost[]>> => (
    authorizedApiClient.get(`${BASE_PATH}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getMultipleByIds = async (
    ids: string[],
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<ShipMaterialCost[]>> => (
    authorizedApiClient.get(`${BASE_PATH}/(${ids.join(',')})`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getOneOrDefault = async (
    id: string,
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<ShipMaterialCost>> => (
    authorizedApiClient.get(`${BASE_PATH}/${id}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const create = async (
    payload: CreateShipMaterialCost,
): Promise<AxiosResponse<ShipMaterialCost>> => (
    authorizedApiClient.post(BASE_PATH, payload)
);

export const patch = async (
    id: string,
    patchObj: PatchShipMaterialCost,
): Promise<AxiosResponse<ShipMaterialCost>> => {
    const keys: string[] = Object.keys(patchObj);
    const patchOperations: PatchOperation[] = keys.map((key: string): PatchOperation => {
        const value = patchObj[key as keyof PatchShipMaterialCost] as number | null;
        return {
            op: 'replace',
            path: `/${key}`,
            value,
        };
    });
    return authorizedApiClient.patch(`${BASE_PATH}/${id}`, patchOperations);
};

export const deleteSingle = async (
    id: string,
): Promise<AxiosResponse> => (
    authorizedApiClient.delete(`${BASE_PATH}/${id}`)
);
