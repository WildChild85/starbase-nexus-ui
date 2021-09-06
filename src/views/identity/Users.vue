<template>
<div class="home">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <Panel>
            <div class="flex flex--end flex--wrap">
                <TextField v-model.trim="searchTerm" :placeholder="$t('search')" @keyup.enter="refreshData"/>
                <Button class="margin-left" :loading="isLoading" @click="refreshData">Refresh</Button>
            </div>
            <DataItem v-for="user in users" :key="user.id" class="margin-top--f2">
                <div class="data-item__icon" :style="{ backgroundImage: `url(${user.avatarUri})`}"></div>
                <div class="data-item__name">{{ user.userName }}</div>
                <div class="data-item__property"><DateTimeFormatter :isoString="user.createdAt"/></div>
                <div class="data-item__property"><DateTimeFormatter :isoString="user.lastLogin"/></div>
                <div class="data-item__spacer"></div>
                <div
                    class="data-item__action data-item__action--no-icon"
                    v-for="role in roles"
                    :key="role.id"
                    @click="handleRoleAssignment(user, role)"
                >{{ user.roles.includes(role.name) ? '-' : '+'}} {{ role.name }}</div>
            </DataItem>
        </Panel>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Panel from '@/components/layout/Panel.vue';
import ViewMixin from '@/mixins/ViewMixin';
import TextField from '@/components/controls/TextField.vue';
import Button from '@/components/controls/Button';
import * as userService from '@/services/identity/userService';
import * as roleService from '@/services/identity/roleService';
import { User } from '@/interfaces/identity/user';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import DataItem from '@/components/layout/DataItem.vue';
import { ROLE_ADMINISTRATOR } from '@/constants/roles';
import { Role } from '@/interfaces/identity/role';
import DateTimeFormatter from '@/components/formatters/DateTimeFormatter.vue';

interface Data {
    searchTerm: string;
    isLoading: boolean;
    users: User[];
    roles: Role[];
}

export default defineComponent({
    name: 'Users',
    components: {
        Button,
        DataItem,
        LoadingIndicatorBeam,
        Panel,
        TextField,
        DateTimeFormatter,
    },
    mixins: [ViewMixin],
    data: (): Data => ({
        searchTerm: '',
        isLoading: false,
        users: [],
        roles: [],
    }),
    computed: {
        isAdmin(): boolean {
            return this.$store.getters['authentication/hasOneRoles'](ROLE_ADMINISTRATOR);
        },
    },
    methods: {
        async handleRoleAssignment(user: User, role: Role): Promise<void> {
            if (this.isLoading) {
                return;
            }
            this.isLoading = true;
            try {
                if (user.roles.includes(role.name)) {
                    await userService.removeUserFromRole(user.id, {
                        roleId: role.id,
                    });
                    this.$notify({
                        type: 'success',
                        text: this.$t('roleRemoved'),
                    });
                } else {
                    await userService.assignUserToRole(user.id, {
                        roleId: role.id,
                    });
                    this.$notify({
                        type: 'success',
                        text: this.$t('roleAssigned'),
                    });
                }
                this.loadUsers();
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            } catch (error: any) {
                this.$notify({
                    type: 'error',
                    text: error,
                });
            }
            this.isLoading = false;
        },
        async refreshData(): Promise<void> {
            await this.loadRoles();
            await this.loadUsers();
        },
        async loadUsers(): Promise<void> {
            this.isLoading = true;
            try {
                const response = await userService.getMultiple({
                    pageSize: -1,
                    searchQuery: this.searchTerm,
                });
                this.users = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
        async loadRoles(): Promise<void> {
            this.isLoading = true;
            try {
                const response = await roleService.getMultiple({
                    pageSize: -1,
                });
                this.roles = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('users'), this.$t('identity')]);
        this.refreshData();
    },
});
</script>
