// store/menuStore.js
import { defineStore } from 'pinia';
import axios from 'axios';

export const useMenuStore = defineStore('menu', {
    state: () => ({
        menuItems: [],
        categories: [],
        items: [],
        orderComplete: false,
        helpInfo: '',
    }),
    actions: {
        async fetchMenuItems() {
            const response = await axios.get('/api/menu');
            this.menuItems = response.data;
        },
        async fetchHelpInfo() {
            const response = await axios.get('/api/help');
            this.helpInfo = response.data;
        },
        async fetchCategories() {
            this.categories = await axios.get('/api/categories').then(res => res.data);
        },
        async fetchItemsByCategory(categoryId) {
            this.items = await axios.get(`/api/items/${categoryId}`).then(res => res.data);
        },
    }
});
