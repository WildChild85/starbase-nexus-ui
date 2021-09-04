import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router';

const Home = () => import('@/views/Home.vue');
const Users = () => import('@/views/identity/Users.vue');
const DiscordHandleAuthorization = () => import('@/views/sign-in/DiscordHandleAuthorization.vue');
const UiElements = () => import('@/views/contribution/UiElements.vue');
const MaterialCategories = () => import('@/views/ingame/MaterialCategories.vue');
const Materials = () => import('@/views/ingame/Materials.vue');
const ItemCategories = () => import('@/views/ingame/ItemCategories.vue');
const Items = () => import('@/views/ingame/Items.vue');

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
];

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes,
});

export default router;
