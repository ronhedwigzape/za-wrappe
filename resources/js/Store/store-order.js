import {defineStore} from 'pinia';
import axios from 'axios';

export const useOrderStore = defineStore('order', {
    state: () => ({
        categories: [],
        products: [],
        cart: [],
        ordering: true,
        categorySpecificFlavors: [],
        categorySpecificAddOns: [],
        selectedCategory: null,
        productToCustomize: null,
        selectedFlavor: null,
        selectedAddOns: [],
        isCustomizingFlavorAndAddOns: false,
        quantity: 1,
        customizations: "",
        isCartUpdating: false,
        combinedFruitSodaTeaAndShawarma: []
    }),
    getters: {
        cartTotal: (state) => {
            return state.cart.reduce((total, item) => {
                return total + item.currentPrice;
            }, 0);
        },
        selectedCategoryProducts: (state) => state.products,
        selectedFlavors: (state) => state.categorySpecificFlavors,
        selectedAddOnsList: (state) => state.categorySpecificAddOns,
        currentPrice: (state) => {
            let basePrice = state.productToCustomize ? parseFloat(state.productToCustomize.price) : 0;
            let flavorPrice = state.selectedFlavor && state.selectedFlavor.price ? parseFloat(state.selectedFlavor.price) : 0;
            let addOnsPrice = state.selectedAddOns && state.selectedAddOns.length > 0
                ? state.selectedAddOns.reduce((sum, addOn) => sum + parseFloat(addOn.price || 0), 0)
                : 0;
            let totalPriceWithoutQuantity = basePrice + flavorPrice + addOnsPrice;
            let totalPrice = totalPriceWithoutQuantity * state.quantity;
            return parseFloat(totalPrice.toFixed(2));
        },
    },
    actions: {
        async fetchCategories() {
            try {
                const response = await axios.get('/api/categories');
                this.categories = response.data;
            } catch (err) {
                console.error('Error fetching categories', err);
            }
        },
        async fetchProducts(productId) {
            try {
                const response = await axios.get(`/api/products/${productId}`);
                this.products = response.data;
            } catch (err) {
                console.error('Error fetching products', err);
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
        async fetchAndCombineFruitSodaTeaAndShawarma() {
            try {
                const fruitSodaTeaCategory = this.categories.find(category => category.name === "Fruit Soda & Tea");
                const shawarmaCategory = this.categories.find(category => category.name === "Shawarma");

                if (!fruitSodaTeaCategory || !shawarmaCategory) {
                    console.error("Categories not found");
                    return;
                }

                const fruitSodaTeaFlavorsResponse = await axios.get(`/api/categories/${fruitSodaTeaCategory.id}/flavors`);
                const fruitSodaTeaFlavors = fruitSodaTeaFlavorsResponse.data;

                const shawarmaProductsResponse = await axios.get(`/api/products/${shawarmaCategory.id}`);
                const shawarmaProducts = shawarmaProductsResponse.data;

                this.combinedFruitSodaTeaAndShawarma = [...fruitSodaTeaFlavors, ...shawarmaProducts];

            } catch (error) {
                console.error("Failed to fetch data", error);
            }
        },
        async goBackToProducts() {
            if (this.selectedCategory && !this.selectedCategoryProducts.length) {
                await this.selectProducts(this.selectedCategory);
            }
            this.productToCustomize = null;
            this.selectedFlavor = null;
            this.selectedAddOns = [];
            this.quantity = 1;
            this.customizations = "";
        },
        async selectProducts(category) {
            this.selectedCategory = category;
            try {
                await this.fetchProducts(category.id);
                await this.fetchCategorySpecificFlavors(category.id);
                await this.fetchCategorySpecificAddOns(category.id);
            } catch (e) {
                console.error(e.toString());
            }
        },
        async customizeCartItem(itemId) {
            const cartItem = this.cart.find(item => item.id === itemId);
            if (cartItem) {
                this.selectedCategory = this.categories.find(category => category.id === cartItem.category_id);

                await this.fetchCategorySpecificFlavors(cartItem.category_id);
                await this.fetchCategorySpecificAddOns(cartItem.category_id);

                this.productToCustomize = { ...cartItem };
                this.selectedFlavor = this.categorySpecificFlavors.find(flavor => flavor.id === cartItem.selectedFlavorId);
                this.selectedAddOns = cartItem.addOns;
                this.quantity = cartItem.quantity;
                this.isCartUpdating = true;
            }
        },
        async setOrderAwaitingPayment(orderId) {
            try {
                await axios.post(`/api/orders/${orderId}/awaiting-payment`);
                await this.fetchOrder(orderId);
            } catch (error) {
                console.error('Error setting order to awaiting payment:', error);
            }
        },
        async createOrGetOrder() {
            try {
                const response = await axios.post('/api/orders/create-or-get');
                if (response.data.order) {
                    this.order = response.data.order;
                }
                return response.data;
            } catch (error) {
                console.error('Error creating or getting order:', error);
                return null;
            }
        },
        async confirmOrderPayment(orderId) {
            try {
                const response = await axios.post('/api/payments/confirm', { order_id: orderId });
                await this.fetchOrder(orderId);
                return response.data;
            } catch (error) {
                console.error('Error confirming order payment:', error);
            }
        },
        async fetchOrder(orderId) {
            try {
                const response = await axios.get(`/api/orders/${orderId}`);
            } catch (error) {
                console.error('Error fetching order:', error);
            }
        },
        goBackToCategories() {
            this.selectedCategory = null;
            this.productToCustomize = null;
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
        selectProduct(product) {
            this.productToCustomize = product;
            this.isCustomizingFlavorAndAddOns = true;
        },
        selectFlavor(flavor) {
            if (this.selectedFlavor && this.selectedFlavor.id === flavor.id) {
                this.selectedFlavor = null;
            } else {
                this.selectedFlavor = flavor;
            }
        },
        toggleAddOn(addOn) {
            console.log(`Toggling add on: AddOn ID:${addOn.id}, Add Ons:${this.selectedAddOns}`)
            const index = this.selectedAddOns.findIndex(a => a.id === addOn.id);
            if (index > -1) {
                this.selectedAddOns.splice(index, 1);
            } else {
                this.selectedAddOns.push(addOn);
            }
        },
        finalizeCustomization() {
            const cartItem = {
                id: this.productToCustomize.id,
                ...this.productToCustomize,
                variant: this.productToCustomize,
                selectedFlavorId: this.selectedFlavor ? this.selectedFlavor.id : null,
                selectedAddOnsIds: this.selectedAddOns.map(addOn => addOn.id),
                flavor: this.selectedFlavor ? this.selectedFlavor.name : 'None',
                addOns: this.selectedAddOns,
                currentPrice: this.currentPrice,
                quantity: this.quantity,
                customizations: this.customizations,
            };
            if (this.isCartUpdating) {
                this.updateCartItem(cartItem);
            } else {
                this.addToCart(cartItem);
            }
            this.resetSelections();
        },
        resetSelections() {
            this.productToCustomize = null;
            this.selectedFlavor = null;
            this.selectedAddOns = [];
            this.selectedCategory = null;
            this.quantity = 1;
            this.isCartUpdating = false;
        },
        continueOrdering() {
            this.ordering = true;
            this.resetSelections();
        },
        cancelOrder() {
            this.clearCart();
            this.ordering = true;
        },
    }
});
