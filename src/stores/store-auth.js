import { defineStore } from 'pinia';

export const useAuthStore = defineStore('auth', {
    state: () => ({
        user: null,
    }),

    getters: {
        getUser(state) {
            return state.user;
        },
        isAuthenticated: state => !!state.user
    },

    actions: {
        setUser(user) {
            this.user = user;
        }
    },
});
