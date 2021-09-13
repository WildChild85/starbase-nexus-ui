import { createStore } from 'vuex';
import authentication from '@/store/authentication';
import mainNav from '@/store/mainNav';
import views from '@/store/views';

export default createStore({
    strict: process.env.NODE_ENV !== 'production',
    modules: {
        authentication,
        mainNav,
        views,
    },
});
