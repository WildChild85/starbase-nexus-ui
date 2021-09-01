import { AxiosResponse, CancelTokenSource } from 'axios';
import authorizedApiClient from '@/clients/authorizedApiClient';
import {
    User,
    PatchUser,
    UserRoleChangeRequest,
    LockUnlockRequest,
} from '@/interfaces/identity/user';
import { PatchOperation, SearchParameters, ShapingParameters } from '@/interfaces/api';

const BASE_PATH = '/identity/user';

export const getMultiple = async (
    params?: SearchParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<User[]>> => (
    authorizedApiClient.get(BASE_PATH, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getMultipleByIds = async (
    ids: string[],
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<User[]>> => (
    authorizedApiClient.get(`${BASE_PATH}/(${ids.join(',')})`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const getOneOrDefault = async (
    id: string,
    params?: ShapingParameters,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<User>> => (
    authorizedApiClient.get(`${BASE_PATH}/${id}`, { params, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const patch = async (
    id: string,
    patchObj: PatchUser,
): Promise<AxiosResponse<User>> => {
    const keys: string[] = Object.keys(patchObj);
    const patchOperations: PatchOperation[] = keys.map((key: string): PatchOperation => {
        const value = patchObj[key as keyof PatchUser] as never;
        return {
            op: 'replace',
            path: `/${key}`,
            value,
        };
    });
    return authorizedApiClient.patch(`${BASE_PATH}/${id}`, patchOperations);
};

export const lockOrUnlock = async (
    id: string,
    payload: LockUnlockRequest,
): Promise<AxiosResponse> => (
    authorizedApiClient.patch(`${BASE_PATH}/${id}/lock-unlock`, payload)
);

export const assignUserToRole = async (
    id: string,
    payload: UserRoleChangeRequest,
): Promise<AxiosResponse> => (
    authorizedApiClient.patch(`${BASE_PATH}/${id}/assign-user-to-role`, payload)
);

export const removeUserFromRole = async (
    id: string,
    payload: UserRoleChangeRequest,
): Promise<AxiosResponse> => (
    authorizedApiClient.patch(`${BASE_PATH}/${id}/remove-user-from-role`, payload)
);
