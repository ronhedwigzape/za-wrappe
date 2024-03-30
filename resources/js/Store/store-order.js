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
        selectedCategory: null,
        productToCustomize: null,
        selectedFlavor: null,
        selectedAddOns: [],
        isCustomizingFlavorAndAddOns: false,
        quantity: 1,
        customizations: "",
        isCartUpdating: false,
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
        goBackToCategories() {
            this.selectedCategory = null;
            this.productToCustomize = null;
        },
        async goBackToProducts() {
            if (this.selectedCategory && !this.selectedCategoryProducts.length) {
                try {
                    await this.selectProducts(this.selectedCategory);
                    this.productToCustomize = null;
                    this.selectedFlavor = null;
                    this.selectedAddOns = [];
                    this.quantity = 1;
                    this.customizations = "";
                } catch (e) {
                    console.error(e.toString())
                }
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
        async customizeCartItem(itemId) {
            const cartItem = this.cart.find(item => item.id === itemId);
            if (cartItem) {
                try {
                    await this.fetchCategorySpecificFlavors(cartItem.category_id);
                    await this.fetchCategorySpecificAddOns(cartItem.category_id);
                    this.productToCustomize = { ...cartItem };
                    this.selectedFlavor = cartItem.selectedFlavor;
                    this.selectedAddOns = cartItem.addOns.map(addOn => {
                        return this.categorySpecificAddOns.find(a => a.id === addOn.id);
                    }).filter(Boolean);
                    this.quantity = cartItem.quantity;
                    this.isCartUpdating = true;
                } catch (e) {
                    console.error(e.toString());
                }
            }
        },
        continueOrdering() {
            this.ordering = true;
            this.resetSelections();
        },
        cancelOrder() {
            this.clearCart();
            this.ordering = true;
        }
    }
});
