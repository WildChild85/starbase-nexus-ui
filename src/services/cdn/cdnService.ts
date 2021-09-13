import { AxiosResponse, CancelTokenSource } from 'axios';
import authorizedApiClient from '@/clients/authorizedApiClient';
import { FileResponse, FolderContentResponse, CreateFolder } from '@/interfaces/cdn/cdn';

const BASE_PATH = '/cdn/cdn';

// eslint-disable-next-line import/prefer-default-export
export const getFolderContents = async (
    path?: string,
    cancelToken?: CancelTokenSource,
): Promise<AxiosResponse<FolderContentResponse>> => (
    authorizedApiClient.get(`${BASE_PATH}`, { params: { path }, cancelToken: cancelToken ? cancelToken.token : undefined })
);

export const createFolder = async (
    payload: CreateFolder,
): Promise<AxiosResponse> => (
    authorizedApiClient.post(`${BASE_PATH}/create-folder`, payload)
);

export const upload = async (
    file: File,
    path: string,
    onUploadProgress: (progressEvent: ProgressEvent) => void,
): Promise<AxiosResponse<FileResponse>> => {
    const payload = new FormData();
    payload.append('file', file);
    return authorizedApiClient.post(`${BASE_PATH}/upload`, payload, {
        headers: { 'Content-Type': 'multipart/form-data' },
        onUploadProgress,
        params: { path },
    });
};
