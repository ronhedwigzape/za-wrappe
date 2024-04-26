import { defineStore } from 'pinia';
import { useStore } from "@/stores/index.js";
import { useAuthStore } from "@/stores/store-auth.js";
import $ from 'jquery';

export const useOrderStore = defineStore('order', {
    state: () => ({
        categories: [],
        products: [],
        cart: JSON.parse(localStorage.getItem('cart')) || [],
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
        combinedFruitSodaTeaAndShawarma: [],
        showError: false,
        cartVisible: false,
        orderCreated: false,
        order: {}
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
            await $.ajax({
                url: `${useStore().appURL}/${useAuthStore().getUser.userType}.php`,
                type: 'GET',
                xhrFields: {
                    withCredentials: true
                },
                data: {
                    fetchCategories: ''
                },
                success: (data) => {
                    this.categories = JSON.parse(data);
                },
                error: (error) => {
                    alert(`ERROR ${error.status}: ${error.statusText}`);
                    throw error;
                },
            });
        },
        async fetchProductsByCategory(categoryId) {
            await $.ajax({
                url: `${useStore().appURL}/${useAuthStore().getUser.userType}.php`,
                type: 'GET',
                xhrFields: {
                    withCredentials: true
                },
                data: {
                    fetchProductsByCategory: categoryId
                },
                success: (data) => {
                    this.products = JSON.parse(data);
                },
                error: (error) => {
                    alert(`ERROR ${error.status}: ${error.statusText}`);
                },
            });
        },
        async fetchCategorySpecificFlavors(categoryId) {
            await $.ajax({
                url: `${useStore().appURL}/${useAuthStore().getUser.userType}.php`,
                type: 'GET',
                xhrFields: {
                    withCredentials: true
                },
                data: {
                    fetchCategoryFlavors: categoryId
                },
                success: (data) => {
                    this.categorySpecificFlavors = JSON.parse(data);
                },
                error: (error) => {
                    alert(`ERROR ${error.status}: ${error.statusText}`);
                },
            });
        },
        async fetchCategorySpecificAddOns(categoryId) {
            await $.ajax({
                url: `${useStore().appURL}/${useAuthStore().getUser.userType}.php`,
                type: 'GET',
                xhrFields: {
                    withCredentials: true
                },
                data: {
                    fetchCategoryAddOns: categoryId
                },
                success: (data) => {
                    this.categorySpecificAddOns = JSON.parse(data);
                },
                error: (error) => {
                    alert(`ERROR ${error.status}: ${error.statusText}`);
                },
            });
        },
        async fetchAndCombineFruitSodaTeaAndShawarma() {
            try {
                const fruitSodaTeaCategory = this.categories.find(category => category.name === "Fruit Soda & Tea");
                const shawarmaCategory = this.categories.find(category => category.name === "Shawarma");

                if (!fruitSodaTeaCategory || !shawarmaCategory) {
                    console.error("Categories not found");
                    return;
                }

                // Fetch flavors for the Fruit Soda & Tea category
                const fruitSodaTeaFlavorsResponse = await $.ajax({
                    url: `${useStore().appURL}/${useAuthStore().getUser.userType}.php`,
                    type: 'GET',
                    xhrFields: { withCredentials: true },
                    data: { fetchCategoryFlavors: fruitSodaTeaCategory.id }
                });

                const fruitSodaTeaFlavors = JSON.parse(fruitSodaTeaFlavorsResponse);

                // Fetch products for the Shawarma category
                const shawarmaProductsResponse = await $.ajax({
                    url: `${useStore().appURL}/${useAuthStore().getUser.userType}.php`,
                    type: 'GET',
                    xhrFields: { withCredentials: true },
                    data: { fetchProductsByCategory: shawarmaCategory.id }
                });

                const shawarmaProducts = JSON.parse(shawarmaProductsResponse);

                this.combinedFruitSodaTeaAndShawarma = [...fruitSodaTeaFlavors, ...shawarmaProducts];
            } catch (error) {
                console.error("Failed to fetch data", error);
                alert(`ERROR ${error.status}: ${error.statusText}`);
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
                await this.fetchProductsByCategory(category.id);
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
                this.isCustomizingFlavorAndAddOns = true;
                this.isCartUpdating = true;
            } else {
                console.error("Item not found in cart for customization");
            }
        },
        async confirmOrderPayment(orderId) {
            await $.ajax({
                url: `${useStore().appURL}/${useAuthStore().getUser.userType}.php`,
                type: 'POST',
                xhrFields: {
                    withCredentials: true
                },
                data: {
                    confirmPayment: orderId
                },
                error: (error) => {
                    alert(`ERROR ${error.status}: ${error.statusText}`);
                },
            });
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
                this.updateLocalStorageCart();
            } else {
                console.error(`Invalid product price or quantity: ${product}`);
            }
        },
        updateCartItem(updatedItem) {
            const index = this.cart.findIndex(item => item.id === updatedItem.id);
            if (index !== -1) {
                this.cart[index] = { ...updatedItem };
                this.updateLocalStorageCart()
            }
        },
        removeFromCart(itemId) {
            if (this.cart.length === 1) {
                this.cart = this.cart.filter(item => item.id !== itemId);
                this.updateLocalStorageCart();
                this.resetSelections();
            } else {
                this.cart = this.cart.filter(item => item.id !== itemId);
                this.updateLocalStorageCart();
            }
        },
        clearCart() {
            this.cart = [];
            this.clearLocalStorageCart();
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
            if (!this.selectedFlavor) {
                this.showError = true;
                setTimeout(() => {
                    this.showError = false;
                }, 3000);
                return;
            }

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
                if (this.cart.length === 1) {
                    this.cartVisible = true;
                }
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
            this.resetSelections();
            this.ordering = true;
        },
        updateLocalStorageCart() {
            localStorage.setItem('cart', JSON.stringify(this.cart));
        },
        clearLocalStorageCart() {
            localStorage.removeItem('cart');
        },
        async createOrder(customerContact) {
            try {
                const orderData = {
                    customer_contact: customerContact,
                    items: this.cart ? this.cart.map(item => ({
                        product_id: item.id,
                        quantity: item.quantity,
                        add_ons: item.selectedAddOns && item.selectedAddOns.length > 0 ? item.selectedAddOns.map(addOn => addOn.id) : [],
                        flavor_id: item.selectedFlavorId
                    })) : []
                };

                const response = await $.ajax({
                    url: `${useStore().appURL}/${useAuthStore().getUser.userType}.php`,
                    type: 'POST',
                    xhrFields: { withCredentials: true },
                    data: { orderData }
                });

                this.clearCart();

                this.order = response.data;
            } catch (error) {
                console.error('Error creating order:', error);
                throw error;
            }
        }

    }
});
