import { createStore } from 'vuex';
import authentication from '@/store/authentication';
import mainNav from '@/store/mainNav';

export default createStore({
    strict: process.env.NODE_ENV !== 'production',
    modules: {
        authentication,
        mainNav,
    },
});
