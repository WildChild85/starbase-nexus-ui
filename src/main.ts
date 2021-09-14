import '@fontsource/manrope';
import '@fontsource/source-code-pro';
import Notifications from '@kyvg/vue3-notification';
import { createApp } from 'vue';
import {
    PencilIcon as PencilIconSolid,
    ChevronRightIcon as ChevronRightIconSolid,
    XIcon as XIconSolid,
    PencilAltIcon as PencilAltIconSolid,
    HeartIcon as HeartIconSolid,
} from '@heroicons/vue/solid';
import {
    ClipboardCopyIcon as ClipboardCopyIconOutline,
    ExternalLinkIcon as ExternalLinkIconOutline,
    MenuIcon as MenuIconOutline,
    HeartIcon as HeartIconOutline,
} from '@heroicons/vue/outline';

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
    .component('ClipboardCopyIconOutline', ClipboardCopyIconOutline)
    .component('ExternalLinkIconOutline', ExternalLinkIconOutline)
    .component('MenuIconOutline', MenuIconOutline)
    .component('PencilAltIconSolid', PencilAltIconSolid)
    .component('HeartIconSolid', HeartIconSolid)
    .component('HeartIconOutline', HeartIconOutline)
    .mount('#app');
