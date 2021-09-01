import { createStore } from 'vuex';
import authentication from '@/store/authentication';

export default createStore({
    strict: process.env.NODE_ENV !== 'production',
    modules: {
        authentication,
    },
});
