// store/menuStore.js
import { defineStore } from 'pinia';
import axios from 'axios';

export const useMenuStore = defineStore('menu', {
    state: () => ({
        menuItems: [],
        categories: [],
        helpInfo: '',
        orderComplete: false
    }),
    actions: {
        async fetchMenuItems() {
            const response = await axios.get('/api/menu');
            this.menuItems = response.data;
        },
        async fetchCategories() {
            const response = await axios.get('/api/categories');
            this.categories = response.data;
        },
        async fetchHelpInfo() {
            const response = await axios.get('/api/help');
            this.helpInfo = response.data;
        }
    }
});
