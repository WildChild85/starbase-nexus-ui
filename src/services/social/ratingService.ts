import { AxiosResponse, CancelTokenSource } from 'axios';
import authorizedApiClient from '@/clients/authorizedApiClient';
import {
    CreateRating,
    Rating,
    RatingSearchParameters,
} from '@/interfaces/social/rating';
import { ShapingParameters } from '@/interfaces/api';

const BASE_PATH = '/social/rating';

export const getMultiple = async (
    params?: RatingSearchParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<Rating[]>> => (
    authorizedApiClient.get(`${BASE_PATH}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getMultipleByIds = async (
    ids: string[],
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<Rating[]>> => (
    authorizedApiClient.get(`${BASE_PATH}/(${ids.join(',')})`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getOneOrDefault = async (
    id: string,
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<Rating>> => (
    authorizedApiClient.get(`${BASE_PATH}/${id}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const create = async (
    payload: CreateRating,
): Promise<AxiosResponse<Rating>> => (
    authorizedApiClient.post(BASE_PATH, payload)
);

export const deleteSingle = async (
    id: string,
): Promise<AxiosResponse> => (
    authorizedApiClient.delete(`${BASE_PATH}/${id}`)
);
