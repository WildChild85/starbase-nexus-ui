export interface JwtUser {
    id: string;
    username: string;
    avatarUri: string;
    roles: string[];
    nbf: number;
    exp: number;
    iss: string;
    aud: string;
}

export interface User {
    id: string;
    userName: string;
    email: string;
    createdAt: string;
    updatedAt: string | null;
    lastLogin: string | null;
    emailConfirmed: boolean;
    lockoutEnd: string | null;
    lockoutEnabled: boolean;
    accessFailedCount: number;
    aboutMe: string | number;
    avatarUri: string | null;
    discordId: string | null;
    roles: string[];
}

export interface PatchUser {
    aboutMe?: string | null;
    avatarUri?: string | null;
}

export interface LockUnlockRequest {
    LockUser: boolean;
}

export interface UserRoleChangeRequest {
    roleId: string;
}
