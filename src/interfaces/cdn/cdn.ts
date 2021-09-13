export interface CreateFolder {
    folderName: string;
    path: string;
}

export interface FileResponse {
    name: string;
    publicUri: string;
}

export interface FolderContentResponse {
    folderNames: string[];
    files: FileResponse[];
}
