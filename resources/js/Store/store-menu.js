// store/menuStore.js
import { defineStore } from 'pinia';
import axios from 'axios';
import {useAuthStore} from "@/Store/store-auth.js";

export const useMenuStore = defineStore('menu', {
    state: () => ({
        menuItems: [],
        categories: [],
        items: [],
        orderComplete: false,
        helpInfo: '',
    }),
    actions: {
        async fetchCategories() {
            this.categories = await axios.get('/api/categories', {
                headers: {
                    Authorization: `Bearer ${useAuthStore().token}`
                }
            }).then(res => res.data);
        },
    }
});
