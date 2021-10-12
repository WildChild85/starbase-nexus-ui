<template>
<Panel>
    <LoadingIndicatorBeam v-if="isLoading"/>
    <div class="flex flex--end">
        <TextField v-model.trim="searchTerm" :placeholder="$t('search')" @keyup.enter="refreshData"/>
        <Button class="margin-left" :loading="isLoading" @click="refreshData">Refresh</Button>
        <Button type="info" class="margin-left" v-if="ownsCurrentPath" @click="showCreateFolder()">Create folder</Button>
        <Button type="info" class="margin-left" v-if="ownsCurrentPath" @click="showUploadFiles()">Upload</Button>
        <Button type="error" class="margin-left" v-if="embedded" @click="$emit('close')">Close</Button>
    </div>
    <div class="file-explorer margin-top">
        <div class="file-explorer__breadcrumb">
            <Button
                v-for="breadcrumbItem in breadcrumbItems" :key="breadcrumbItem.path"
                @click="navigate(breadcrumbItem.path)"
            >
                {{ breadcrumbItem.name }}
            </Button>
        </div>
        <div class="file-explorer__folders">
            <div
                class="file-explorer__folder"
                v-for="folder in resolvedFolders"
                :key="folder"
                data-augmented-ui="tl-clip tr-clip br-clip bl-clip border"
                @click="navigate(folder.path)"
            >{{ folder.name }}</div>
        </div>
        <div class="file-explorer__files">
            <div
                class="file-explorer__file"
                v-for="file in files"
                :key="file.name"
                data-augmented-ui="tl-clip tr-clip br-clip bl-clip border"
                :style="{backgroundImage: `url('${file.publicUri}')`}"
                @click="handleFileClicked(file)"
            >{{ file.name }}</div>
        </div>
    </div>
    <Dialog v-if="uploadFilesShown" :fullWidth="true">
        <UploadFiles :path="currentPath" @close="hideUploadFiles(true)" />
    </Dialog>
    <Dialog v-if="createFolderShown" @close="hideCreateFolder(false)">
        <CreateFolder
            :path="currentPath"
            @created="hideCreateFolder(true)"
            @patched="hideCreateFolder(true)"
            @cancelled="hideCreateFolder(false)"
        />
    </Dialog>
</Panel>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import axios, { CancelTokenSource } from 'axios';
import * as cdnService from '@/services/cdn/cdnService';
import * as publicUserService from '@/services/social/publicUserService';
import { FileResponse } from '@/interfaces/cdn/cdn';
import { JwtUser } from '@/interfaces/identity/user';
import Panel from '@/components/layout/Panel.vue';
import Button from '@/components/controls/Button';
import TextField from '@/components/controls/TextField.vue';
import CreateFolder from '@/components/cdn/CreateFolder.vue';
import Dialog from '@/components/dialogs/Dialog.vue';
import { PublicUser } from '@/interfaces/social/publicUser';
import { GUID_LENGTH } from '@/constants/app';
import UploadFiles from '@/components/cdn/UploadFiles.vue';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';

interface Data {
    folders: string[];
    files: FileResponse[];
    isLoading: boolean;
    currentPath: string;
    searchTerm: string;
    createFolderShown: boolean;
    uploadFilesShown: boolean;
    publicUsers: PublicUser[];
    cancelToken: CancelTokenSource | null;
}

interface FolderItem {
    name: string;
    path: string;
}

const FILE_EXPLORER_CURRENT_PATH_KEY = 'fecp';

export interface FileSelection {
    name: string;
    publicUri: string;
    path: string;
}

export default defineComponent({
    name: 'FileExplorer',
    components: {
        Button,
        CreateFolder,
        Dialog,
        LoadingIndicatorBeam,
        Panel,
        TextField,
        UploadFiles,
    },
    emits: ['fileSelected', 'close'],
    props: {
        embedded: {
            type: Boolean,
            default: false,
        },
    },
    data: (): Data => ({
        folders: [],
        files: [],
        isLoading: false,
        currentPath: '',
        searchTerm: '',
        createFolderShown: false,
        uploadFilesShown: false,
        publicUsers: [],
        cancelToken: null,
    }),
    computed: {
        breadcrumbItems(): FolderItem[] {
            const items: FolderItem[] = [
                {
                    name: '/',
                    path: '',
                },
            ];
            let tempPath = '';

            this.currentPathSegments.forEach((segment, index) => {
                if (tempPath.length > 0) {
                    tempPath = `${tempPath}/${segment}`;
                } else {
                    tempPath = segment;
                }
                let user: PublicUser | null | undefined;
                if (index === 0) {
                    user = this.publicUsers.find(({ id }) => id === segment);
                }
                items.push({
                    name: user ? user.userName : segment,
                    path: tempPath,
                });
            });
            return items;
        },
        currentPathSegments(): string[] {
            return this.currentPath.split('/').filter((segment) => segment.length > 0);
        },
        userIds(): string[] {
            const userIds = this.folders.filter((folder) => folder.length === GUID_LENGTH);

            if (this.currentPathSegments.length > 0) {
                userIds.push(this.currentPathSegments[0]);
            }

            return userIds;
        },
        user(): JwtUser | null {
            return this.$store.getters['authentication/user'];
        },
        ownsCurrentPath(): boolean | null {
            return this.user && this.currentPath.startsWith(this.user.id);
        },
        resolvedFolders(): FolderItem[] {
            return this.folders.map((folder) => {
                let user;
                if (folder.length === GUID_LENGTH) {
                    user = this.publicUsers.find(({ id }) => id === folder);
                }
                return {
                    name: user ? user.userName : folder,
                    path: `${this.currentPath}/${folder}`,
                };
            });
        },
    },
    methods: {
        handleFileClicked(file: FileResponse): void {
            if (this.embedded) {
                this.$emit('fileSelected', {
                    name: file.name,
                    publicUri: file.publicUri,
                    path: this.currentPath,
                } as FileSelection);
            } else {
                window.open(file.publicUri);
            }
        },
        async navigate(path: string): Promise<void> {
            localStorage.setItem(FILE_EXPLORER_CURRENT_PATH_KEY, path);
            this.currentPath = path;
            await this.refreshData();
        },
        showUploadFiles(): void {
            this.uploadFilesShown = true;
        },
        hideUploadFiles(refreshData = false): void {
            this.uploadFilesShown = false;
            if (refreshData) {
                this.refreshData();
            }
        },
        showCreateFolder(): void {
            this.createFolderShown = true;
        },
        hideCreateFolder(refreshData = false): void {
            this.createFolderShown = false;
            if (refreshData) {
                this.refreshData();
            }
        },
        async refreshData(): Promise<void> {
            await this.getFolderContents();
            this.$nextTick(() => {
                this.getUsers();
            });
        },
        async getFolderContents(): Promise<void> {
            this.isLoading = true;
            if (this.cancelToken) {
                this.cancelToken.cancel();
            }
            this.cancelToken = axios.CancelToken.source();
            try {
                const response = await cdnService.getFolderContents(this.currentPath, this.cancelToken);
                this.folders = response.data.folderNames;
                this.files = response.data.files;
            } catch (error) {
                this.$notify({
                    type: 'error',
                    title: this.$t('folderContentNotLoaded'),
                });
            }
            this.isLoading = false;
        },
        async getUsers(): Promise<void> {
            this.isLoading = true;
            if (!this.userIds.length) {
                return;
            }
            try {
                const response = await publicUserService.getMultipleByIds(this.userIds);
                this.publicUsers = response.data;
            } catch (error) {
                // do nothing here
            }
            this.isLoading = false;
        },
    },
    created(): void {
        const lastPath = localStorage.getItem(FILE_EXPLORER_CURRENT_PATH_KEY);
        if (lastPath) {
            this.currentPath = lastPath;
        } else {
            this.currentPath = this.user ? this.user.id : '';
        }
        this.refreshData();
    },
});
</script>
