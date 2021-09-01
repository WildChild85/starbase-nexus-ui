import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router';

const Home = () => import('@/views/Home.vue');
const UiElements = () => import('@/views/contribution/UiElements.vue');
const Items = () => import('@/views/ingame/Items.vue');

const routes: Array<RouteRecordRaw> = [
    {
        path: '/',
        name: 'home',
        component: Home,
    },
    {
        path: '/contribution/ui-elements',
        name: 'contribution_ui-elements',
        component: UiElements,
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
