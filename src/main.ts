import '@fontsource/manrope';
import Notifications from '@kyvg/vue3-notification';
import { createApp } from 'vue';
import {
    PencilIcon as PencilIconSolid,
    ChevronRightIcon as ChevronRightIconSolid,
    XIcon as XIconSolid,
} from '@heroicons/vue/solid';
import App from '@/App.vue';
import router from '@/router';
import store from '@/store';
import i18n from '@/i18n';

createApp(App)
    .use(store)
    .use(router)
    .use(i18n)
    .use(Notifications)
    .component('PencilIconSolid', PencilIconSolid)
    .component('ChevronRightIconSolid', ChevronRightIconSolid)
    .component('XIconSolid', XIconSolid)
    .mount('#app');
