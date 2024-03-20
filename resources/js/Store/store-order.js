import { defineStore } from 'pinia';
import axios from 'axios';

export const useOrderStore = defineStore('order', {
    state: () => ({
        categories: [],
        products: [],
        cart: [],
        ordering: true,
        flavors: [],
        addOns: [],
    }),
    getters: {
        cartTotal: (state) => {
            return state.cart.reduce((total, item) => {
                return total + (item.price * item.quantity);
            }, 0);
        },
    },
    actions: {
        async fetchCategories() {
            const response = await axios.get('/api/categories');
            this.categories = response.data;
        },
        async fetchProducts(categoryId) {
            const response = await axios.get(`/api/products/${categoryId}`);
            this.products = response.data;
        },
        addToCart(product, quantity, customizations) {
            const cartItem = { ...product, quantity, customizations };
            this.cart.push(cartItem);

            // TODO: Add a function for updating backend
        },
        async fetchFlavors() {
            try {
                const response = await axios.get('/api/flavors');
                this.flavors = response.data;
                console.log('Fetched flavors:', this.flavors);
            } catch (error) {
                console.error('Error fetching flavors:', error);
            }
        },
        async fetchAddOns() {
            try {
                const response = await axios.get('/api/add-ons');
                this.addOns = response.data;
                console.log('Fetched add-ons:', this.addOns);
            } catch (error) {
                console.error('Error fetching add-ons:', error);
            }
        },
        clearCart() {
            this.cart = [];
        },
    }
});
