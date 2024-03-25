import { defineStore } from 'pinia';
import axios from 'axios';

export const useOrderStore = defineStore('order', {
    state: () => ({
        categories: [],
        products: [],
        cart: [],
        ordering: true,
        categorySpecificFlavors: [],
        categorySpecificAddOns: [],
    }),
    getters: {
        cartTotal: (state) => {
            return state.cart.reduce((total, item) => {
                return total + (Number(item.price) * Number(item.quantity));
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
        addToCart(product, quantity = 1, customizations = '') {
            let productPrice = parseFloat(product.price)
            if (typeof productPrice === 'number' && Number.isInteger(quantity)) {
                const cartItem = { ...product, quantity, customizations };
                this.cart.push(cartItem);
                console.log("Cart after adding:", this.cart);
            } else {
                console.error(`Invalid product price or quantity: ${typeof product.price} ${quantity} ${customizations}`);
            }
        },
        async fetchCategorySpecificFlavors(categoryId) {
            try {
                const response = await axios.get(`/api/categories/${categoryId}/flavors`);
                this.categorySpecificFlavors = response.data;
            } catch (error) {
                console.log('Error fetching category-specific flavors:', error);
            }
        },
        async fetchCategorySpecificAddOns(categoryId) {
            try {
                const response = await axios.get(`/api/categories/${categoryId}/add-ons`);
                this.categorySpecificAddOns = response.data;
            } catch (error) {
                console.log('Error fetching category-specific add-ons:', error);
            }
        },
        removeFromCart(itemId) {
            this.cart = this.cart.filter(item => item.id !== itemId);
        },
        clearCart() {
            this.cart = [];
        },
    }
});
