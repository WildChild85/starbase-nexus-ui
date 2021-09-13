import { AxiosResponse, CancelTokenSource } from 'axios';
import authorizedApiClient from '@/clients/authorizedApiClient';
import {
    CreateYololScript,
    PatchYololScript,
    YololScript,
    YololScriptSearchParameters,
} from '@/interfaces/yolol/yololScript';
import { PatchOperation, ShapingParameters } from '@/interfaces/api';

const BASE_PATH = '/yolol/yololscript';

export const getMultiple = async (
    params?: YololScriptSearchParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<YololScript[]>> => (
    authorizedApiClient.get(`${BASE_PATH}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getMultipleByIds = async (
    ids: string[],
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<YololScript[]>> => (
    authorizedApiClient.get(`${BASE_PATH}/(${ids.join(',')})`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getOneOrDefault = async (
    id: string,
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<YololScript>> => (
    authorizedApiClient.get(`${BASE_PATH}/${id}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const create = async (
    payload: CreateYololScript,
): Promise<AxiosResponse<YololScript>> => (
    authorizedApiClient.post(BASE_PATH, payload)
);

export const patch = async (
    id: string,
    patchObj: PatchYololScript,
): Promise<AxiosResponse<YololScript>> => {
    const keys: string[] = Object.keys(patchObj);
    const patchOperations: PatchOperation[] = keys.map((key: string): PatchOperation => {
        const value = patchObj[key as keyof PatchYololScript] as string | null;
        return {
            op: 'replace',
            path: `/${key}`,
            value,
        };
    });
    return authorizedApiClient.patch(`${BASE_PATH}/${id}`, patchOperations);
};
