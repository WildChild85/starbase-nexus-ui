import '@fontsource/manrope';
import '@fontsource/source-code-pro';
import Notifications from '@kyvg/vue3-notification';
import { createApp } from 'vue';
import {
    ChevronLeftIcon as ChevronLeftIconSolid,
    ChevronRightIcon as ChevronRightIconSolid,
    ChevronDownIcon as ChevronDownIconSolid,
    ChipIcon as ChipIconSolid,
    HeartIcon as HeartIconSolid,
    PencilAltIcon as PencilAltIconSolid,
    PencilIcon as PencilIconSolid,
    PlayIcon as PlayIconSolid,
    XIcon as XIconSolid,
} from '@heroicons/vue/solid';
import {
    ClipboardCopyIcon as ClipboardCopyIconOutline,
    DocumentTextIcon as DocumentTextIconOutline,
    ExternalLinkIcon as ExternalLinkIconOutline,
    HeartIcon as HeartIconOutline,
    MenuIcon as MenuIconOutline,
    LogoutIcon as LogoutIconOutline,
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
    .component('ChevronLeftIconSolid', ChevronLeftIconSolid)
    .component('ChevronRightIconSolid', ChevronRightIconSolid)
    .component('ChevronDownIconSolid', ChevronDownIconSolid)
    .component('ChipIconSolid', ChipIconSolid)
    .component('ClipboardCopyIconOutline', ClipboardCopyIconOutline)
    .component('DocumentTextIconOutline', DocumentTextIconOutline)
    .component('ExternalLinkIconOutline', ExternalLinkIconOutline)
    .component('HeartIconOutline', HeartIconOutline)
    .component('HeartIconSolid', HeartIconSolid)
    .component('LogoutIconOutline', LogoutIconOutline)
    .component('MenuIconOutline', MenuIconOutline)
    .component('PencilAltIconSolid', PencilAltIconSolid)
    .component('PencilIconSolid', PencilIconSolid)
    .component('PlayIconSolid', PlayIconSolid)
    .component('XIconSolid', XIconSolid)
    .mount('#app');
