import { AxiosResponse, CancelTokenSource } from 'axios';
import authorizedApiClient from '@/clients/authorizedApiClient';
import {
    CreateLike,
    Like,
    LikeSearchParameters,
} from '@/interfaces/social/like';
import { ShapingParameters } from '@/interfaces/api';

const BASE_PATH = '/social/like';

export const getMultiple = async (
    params?: LikeSearchParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<Like[]>> => (
    authorizedApiClient.get(`${BASE_PATH}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getMultipleByIds = async (
    ids: string[],
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<Like[]>> => (
    authorizedApiClient.get(`${BASE_PATH}/(${ids.join(',')})`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getOneOrDefault = async (
    id: string,
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<Like>> => (
    authorizedApiClient.get(`${BASE_PATH}/${id}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const create = async (
    payload: CreateLike,
): Promise<AxiosResponse<Like>> => (
    authorizedApiClient.post(BASE_PATH, payload)
);

export const deleteSingle = async (
    id: string,
): Promise<AxiosResponse> => (
    authorizedApiClient.delete(`${BASE_PATH}/${id}`)
);
