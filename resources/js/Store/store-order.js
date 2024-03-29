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
                let itemTotal = Number(item.currentPrice) || 0;
                const flavor = state.categorySpecificFlavors.find(f => f.id === item.selectedFlavorId);
                if (flavor && !isNaN(Number(flavor.price))) {
                    itemTotal += Number(flavor.price);
                }
                itemTotal += (item.selectedAddOnsIds || []).reduce((addOnTotal, addOnId) => {
                    const addOn = state.categorySpecificAddOns.find(a => a.id === addOnId);
                    if (addOn && !isNaN(Number(addOn.price))) {
                        return addOnTotal + Number(addOn.price);
                    }
                    return addOnTotal;
                }, 0);
                let itemQuantity = Number(item.quantity) || 0;
                itemTotal *= itemQuantity;
                return total + itemTotal;
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
        addToCart(product) {
            console.log("Adding product to cart:", product);
            if (typeof parseFloat(product.currentPrice) === 'number' && Number.isInteger(product.quantity)) {
                const selectedFlavorDetail = this.categorySpecificFlavors.find(flavor => flavor.id === product.selectedFlavorId) || null;

                const selectedAddOnsDetails = (product.selectedAddOnsIds || [])
                    .map(addOnId => this.categorySpecificAddOns.find(a => a.id === addOnId))
                    .filter(Boolean);

                const cartItem = {
                    ...product,
                    selectedFlavor: selectedFlavorDetail,
                    addOns: selectedAddOnsDetails,
                };

                this.cart.push(cartItem);
            } else {
                console.error(`Invalid product price or quantity: ${product}`);
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
        clearCart() {
            this.cart = [];
        },
    }
});
