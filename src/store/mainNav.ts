export interface MainNavStoreState {
    open: boolean;
}

const authentication = {
    namespaced: true,
    state: (): MainNavStoreState => ({
        open: false,
    }),
    getters: {
        open: (state: MainNavStoreState): boolean => state.open,
    },
    mutations: {
        setOpen(state: MainNavStoreState, open: boolean): void {
            state.open = open;
        },
    },
    actions: {},
};

export default authentication;
