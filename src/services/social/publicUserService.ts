import { AxiosResponse, CancelTokenSource } from 'axios';
import authorizedApiClient from '@/clients/authorizedApiClient';
import { SearchParameters, ShapingParameters } from '@/interfaces/api';
import { PublicUser } from '@/interfaces/social/publicUser';

const BASE_PATH = '/social/publicuser';

export const getMultiple = async (
    params?: SearchParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<PublicUser[]>> => (
    authorizedApiClient.get(`${BASE_PATH}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getMultipleByIds = async (
    ids: string[],
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<PublicUser[]>> => (
    authorizedApiClient.get(`${BASE_PATH}/(${ids.join(',')})`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getOneOrDefault = async (
    id: string,
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<PublicUser>> => (
    authorizedApiClient.get(`${BASE_PATH}/${id}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);
