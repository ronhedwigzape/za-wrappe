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
                let itemTotal = Number(item.currentPrice);

                if (item.selectedFlavorId) {
                    const flavor = state.categorySpecificFlavors.find(flavor => flavor.id === item.selectedFlavorId);
                    if (flavor) itemTotal += Number(flavor.price);
                }

                const addOnsTotal = item.selectedAddOnsIds.reduce((total, addOnId) => {
                    const addOn = state.categorySpecificAddOns.find(a => a.id === addOnId);
                    return total + (addOn ? Number(addOn.price) : 0);
                }, 0);

                itemTotal += addOnsTotal;
                itemTotal *= Number(item.quantity);

                return total + itemTotal;
            }, 0);
        }

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
        addToCart(product) {
            console.log("Adding product to cart:", product);
            if (typeof parseFloat(product.currentPrice) === 'number' && Number.isInteger(product.quantity)) {
                const selectedFlavorDetail = this.categorySpecificFlavors.find(flavor => flavor.id === product.selectedFlavorId) || {};

                const selectedAddOnsIds = product.addOns ? product.addOns.map(a => a.id) : [];

                const cartItem = {
                    ...product,
                    selectedFlavor: selectedFlavorDetail,
                    addOns: selectedAddOnsIds.map(id => this.categorySpecificAddOns.find(a => a.id === id)).filter(Boolean),
                    selectedAddOnsIds: selectedAddOnsIds,
                };

                this.cart.push(cartItem);
            } else {
                console.error(`Invalid product price or quantity: ${product}`);
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
        updateCartItem(updatedItem) {
            const index = this.cart.findIndex(item => item.id === updatedItem.id);
            if (index !== -1) {
                this.cart[index] = { ...updatedItem };
            }
        },
        removeFromCart(itemId) {
            this.cart = this.cart.filter(item => item.id !== itemId);
        },
        async fetchOrderSummary() {
            const response = await axios.get('/api/order/summary');
            this.cart = response.data.cartItems;
        },

        async updateOrderItem(updatedItem) {
            const response = await axios.post(`/api/order/items/${updatedItem.id}/update`, updatedItem);
            await this.fetchOrderSummary();
        },

        async cancelOrder() {
            await axios.post('/api/order/cancel');
            this.clearCart();
        },
        clearCart() {
            this.cart = [];
        },
    }
});
