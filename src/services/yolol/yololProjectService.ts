import { AxiosResponse, CancelTokenSource } from 'axios';
import authorizedApiClient from '@/clients/authorizedApiClient';
import {
    CreateYololProject,
    PatchYololProject,
    YololProject,
    YololProjectSearchParameters,
} from '@/interfaces/yolol/yololProject';
import { PatchOperation, ShapingParameters } from '@/interfaces/api';

const BASE_PATH = '/yolol/yololproject';

export const getMultiple = async (
    params?: YololProjectSearchParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<YololProject[]>> => (
    authorizedApiClient.get(`${BASE_PATH}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getMultipleByIds = async (
    ids: string[],
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<YololProject[]>> => (
    authorizedApiClient.get(`${BASE_PATH}/(${ids.join(',')})`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getOneOrDefault = async (
    id: string,
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<YololProject>> => (
    authorizedApiClient.get(`${BASE_PATH}/${id}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const create = async (
    payload: CreateYololProject,
): Promise<AxiosResponse<YololProject>> => (
    authorizedApiClient.post(BASE_PATH, payload)
);

export const patch = async (
    id: string,
    patchObj: PatchYololProject,
): Promise<AxiosResponse<YololProject>> => {
    const keys: string[] = Object.keys(patchObj);
    const patchOperations: PatchOperation[] = keys.map((key: string): PatchOperation => {
        const value = patchObj[key as keyof PatchYololProject] as string | null;
        return {
            op: 'replace',
            path: `/${key}`,
            value,
        };
    });
    return authorizedApiClient.patch(`${BASE_PATH}/${id}`, patchOperations);
};
