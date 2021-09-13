export interface ViewsStoreState {
    views: number;
}

const authentication = {
    namespaced: true,
    state: (): ViewsStoreState => ({
        views: 0,
    }),
    getters: {
        views: (state: ViewsStoreState): number => state.views,
    },
    mutations: {
        setViews(state: ViewsStoreState, views: number): void {
            state.views = views;
        },
    },
    actions: {},
};

export default authentication;
