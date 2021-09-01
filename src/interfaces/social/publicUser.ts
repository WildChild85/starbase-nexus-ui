export interface PublicUser {
    id: string;
    createdAt: string;
    updatedAt: string | null;
    lastLogin: string | null;
    aboutMe: string | number;
    avatarUri: string | null;
}
