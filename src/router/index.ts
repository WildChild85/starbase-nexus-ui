import {
    createRouter, createWebHistory, RouteLocationNormalized, RouteRecordRaw,
} from 'vue-router';

import store from '@/store';
import * as signalR from '@/signalR';

const Home = () => import('@/views/Home.vue');
const Users = () => import('@/views/identity/Users.vue');
const DiscordHandleAuthorization = () => import('@/views/sign-in/DiscordHandleAuthorization.vue');
const UiElements = () => import('@/views/contribution/UiElements.vue');
const MaterialCategories = () => import('@/views/ingame/MaterialCategories.vue');
const Materials = () => import('@/views/ingame/Materials.vue');
const ItemCategories = () => import('@/views/ingame/ItemCategories.vue');
const Items = () => import('@/views/ingame/Items.vue');
const ThrusterComparison = () => import('@/views/tools/ThrusterComparison.vue');
const Maps = () => import('@/views/ingame/Maps.vue');
const FileExplorerView = () => import('@/views/cdn/FileExplorerView.vue');
const YololProjects = () => import('@/views/yolol/YololProjects.vue');
const YololProject = () => import('@/views/yolol/YololProject.vue');
const Companies = () => import('@/views/social/Companies.vue');
const Company = () => import('@/views/social/Company.vue');
const Guides = () => import('@/views/knowledge/Guides.vue');
const Guide = () => import('@/views/knowledge/Guide.vue');

const routes: Array<RouteRecordRaw> = [
    {
        path: '/',
        name: 'home',
        component: Home,
    },
    {
        path: '/identity/users',
        name: 'identity_users',
        component: Users,
    },
    {
        path: '/sign-in/discord',
        name: 'sign-in_discord',
        component: DiscordHandleAuthorization,
    },
    {
        path: '/contribution/ui-elements',
        name: 'contribution_ui-elements',
        component: UiElements,
    },
    {
        path: '/ingame/material-categories',
        name: 'ingame_material-categories',
        component: MaterialCategories,
    },
    {
        path: '/ingame/materials',
        name: 'ingame_materials',
        component: Materials,
    },
    {
        path: '/ingame/item-categories',
        name: 'ingame_item-categories',
        component: ItemCategories,
    },
    {
        path: '/ingame/items',
        name: 'ingame_items',
        component: Items,
    },
    {
        path: '/ingame/maps',
        name: 'ingame_maps',
        component: Maps,
    },
    {
        path: '/tools/thruster-comparison',
        name: 'tools_thruster-comparison',
        component: ThrusterComparison,
    },
    {
        path: '/cdn/file-explorer',
        name: 'cdn_file-explorer',
        component: FileExplorerView,
    },
    {
        path: '/yolol/yolol-projects',
        name: 'yolol_yolol-projects',
        component: YololProjects,
    },
    {
        path: '/yolol/yolol-project/create',
        name: 'yolol_yolol-project_create',
        component: YololProject,
    },
    {
        path: '/yolol/yolol-project/:yololProjectId',
        name: 'yolol_yolol-project',
        component: YololProject,
        props: true,
    },
    {
        path: '/social/companies',
        name: 'social_companies',
        component: Companies,
    },
    {
        path: '/social/company/create',
        name: 'social_company_create',
        component: Company,
    },
    {
        path: '/social/company/:companyId',
        name: 'social_company',
        component: Company,
        props: true,
    },
    {
        path: '/knowledge/guides',
        name: 'knowledge_guides',
        component: Guides,
    },
    {
        path: '/knowledge/guide/create',
        name: 'knowledge_guide_create',
        component: Guide,
    },
    {
        path: '/knowledge/guide/:guideId',
        name: 'knowledge_guide',
        component: Guide,
        props: true,
    },
];

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes,
});

// eslint-disable-next-line consistent-return
router.beforeEach((to: RouteLocationNormalized, from: RouteLocationNormalized): RouteLocationNormalized | boolean | void => {
    if (to.name !== from.name) {
        window.scrollTo({
            top: 0,
        });
    }
    try {
        if (signalR.isConnected()) {
            signalR.notify();
        } else {
            signalR.startConnection();
        }
    } catch (_) {
        // do nothing;
    }
    if (to.meta) {
        if (to.meta.onlySignedOff && store.getters['authentication/user']) {
            // TODO: comment this line out
            // return false;
        }
        if (to.meta.onlySignedIn && !store.getters['authentication/user']) {
            // TODO: comment this line out
            // return false;
        }
    }
});

export default router;
