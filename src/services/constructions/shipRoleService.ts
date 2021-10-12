import { AxiosResponse, CancelTokenSource } from 'axios';
import authorizedApiClient from '@/clients/authorizedApiClient';
import {
    CreateShipRole,
    PatchShipRole,
    ShipRole,
} from '@/interfaces/constructions/shipRole';
import { PatchOperation, SearchParameters, ShapingParameters } from '@/interfaces/api';

const BASE_PATH = '/constructions/shipRole';

export const getMultiple = async (
    params?: SearchParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<ShipRole[]>> => (
    authorizedApiClient.get(`${BASE_PATH}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getMultipleByIds = async (
    ids: string[],
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<ShipRole[]>> => (
    authorizedApiClient.get(`${BASE_PATH}/(${ids.join(',')})`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getOneOrDefault = async (
    id: string,
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<ShipRole>> => (
    authorizedApiClient.get(`${BASE_PATH}/${id}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const create = async (
    payload: CreateShipRole,
): Promise<AxiosResponse<ShipRole>> => (
    authorizedApiClient.post(BASE_PATH, payload)
);

export const patch = async (
    id: string,
    patchObj: PatchShipRole,
): Promise<AxiosResponse<ShipRole>> => {
    const keys: string[] = Object.keys(patchObj);
    const patchOperations: PatchOperation[] = keys.map((key: string): PatchOperation => {
        const value = patchObj[key as keyof PatchShipRole] as string | null;
        return {
            op: 'replace',
            path: `/${key}`,
            value,
        };
    });
    return authorizedApiClient.patch(`${BASE_PATH}/${id}`, patchOperations);
};
