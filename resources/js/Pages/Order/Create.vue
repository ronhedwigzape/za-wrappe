<template>
    <div>
        <div class="max-w-4xl mx-auto p-4">
            <!-- Category Selection -->
            <div v-if="!productToCustomize && orderStore.ordering" class="space-y-4">
                <h2 class="text-2xl font-semibold">Select a Category</h2>
                <div class="flex flex-wrap">
                    <button v-for="category in orderStore.categories" :key="category.id" @click="selectProducts(category)"
                            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded m-1">
                        {{ category.name }}
                    </button>
                </div>
            </div>

            <!-- Product Selection -->
            <div v-if="selectedCategory && !productToCustomize" class="space-y-4">
                <h2 class="text-2xl font-semibold">Select a Product from {{ selectedCategory.name }}</h2>
                <div class="flex flex-wrap">
                    <button v-for="product in selectedCategoryProducts" :key="product.id" @click="selectProduct(product)"
                            class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded m-1">
                        {{ product.name }} - ${{ product.price }}
                    </button>
                </div>
                <button @click="goBackToCategories"
                        class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded">
                    Back to Categories
                </button>
            </div>

            <!-- Product Customization: Size or Type Selection -->
            <div v-if="productToCustomize && !isCustomizingFlavorAndAddOns" class="space-y-4">
                <h2 class="text-2xl font-semibold">Customize Your {{ productToCustomize.name }}</h2>
                <div class="flex flex-wrap">
                    <template v-if="isBeverageCategory">
                        <button @click="selectVariant('12 oz', 12)" class="bg-purple-500 hover:bg-purple-700 text-white font-bold py-2 px-4 rounded m-1">12 oz</button>
                        <button @click="selectVariant('16 oz', 16)" class="bg-purple-500 hover:bg-purple-700 text-white font-bold py-2 px-4 rounded m-1">16 oz</button>
                    </template>
                    <template v-if="isShawarmaCategory">
                        <button @click="selectVariant('Single Order', 0)" class="bg-yellow-500 hover:bg-yellow-700 text-white font-bold py-2 px-4 rounded m-1">Single Order</button>
                        <button @click="selectVariant('Buy One, Take One', additionalPriceForBOTOT)" class="bg-yellow-500 hover:bg-yellow-700 text-white font-bold py-2 px-4 rounded m-1">Buy One, Take One</button>
                    </template>
                </div>
            </div>

            <!-- Flavor and Add-On Customization -->
            <div v-if="isCustomizingFlavorAndAddOns" class="space-y-4">
                <h3 class="text-xl font-semibold">Current Price: ${{ currentPrice }}</h3>
                <div v-if="selectedFlavors.length" class="space-y-2">
                    <h3 class="text-lg font-medium">Select Flavor</h3>
                    <div class="flex flex-wrap">
                        <button v-for="flavor in selectedFlavors" :key="flavor.id" @click="selectFlavor(flavor)"
                                class="bg-indigo-500 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded m-1">
                            {{ flavor.name }}
                        </button>
                    </div>
                </div>

                <div v-if="selectedAddOnsList.length" class="space-y-2">
                    <h3 class="text-lg font-medium">Add Ons</h3>
                    <div class="flex flex-wrap">
                        <button v-for="addOn in selectedAddOnsList" :key="addOn.id" @click="toggleAddOn(addOn)"
                                class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded m-1">
                            {{ addOn.name }} (+${{ addOn.price }})
                        </button>
                    </div>
                </div>

                <button @click="finalizeCustomization"
                        class="mt-4 bg-blue-600 hover:bg-blue-800 text-white font-bold py-2 px-4 rounded">
                    Add to Cart
                </button>
            </div>

            <!-- Cart Display -->
            <div v-if="orderStore.cart.length && orderStore.ordering" class="mt-8 space-y-4">
                <h2 class="text-2xl font-semibold">Your Cart</h2>
                <ul class="list-disc pl-5">
                    <li v-for="(item, index) in orderStore.cart" :key="index" class="mt-2">
                        <div class="font-medium">{{ item.name }} - Variant: {{ item.variant }}</div>
                        <div v-if="item.flavor">Flavor: {{ item.flavor.name }}</div>
                        <div v-if="item.addOns.length">
                            Add-Ons:
                            <ul class="list-disc pl-5">
                                <li v-for="addOn in item.addOns" :key="addOn.id">
                                    {{ addOn.name }} (+${{ addOn.price }})
                                </li>
                            </ul>
                        </div>
                        <div>Price: ${{ item.currentPrice }}</div>
                    </li>
                </ul>
                <div class="font-bold">Total: ${{ orderStore.cartTotal }}</div>
                <div class="flex space-x-4">
                    <button @click="continueOrdering"
                            class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                        Continue Ordering
                    </button>
                    <button @click="reviewOrder"
                            class="bg-orange-500 hover:bg-orange-700 text-white font-bold py-2 px-4 rounded">
                        Review Order
                    </button>
                    <button @click="cancelOrder"
                            class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
                        Cancel Order
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useOrderStore } from '@/Store/store-order';

const orderStore = useOrderStore();
const selectedCategory = ref(null);
const selectedCategoryProducts = computed(() => orderStore.products);
const productToCustomize = ref(null);
const selectedFlavor = ref(null);
const selectedAddOns = ref([]);
const selectedFlavors = computed(() => orderStore.categorySpecificFlavors);
const selectedAddOnsList = computed(() => orderStore.categorySpecificAddOns);
const isCustomizingFlavorAndAddOns = ref(false);
const currentVariantPrice = ref(0);
const additionalPriceForBOTOT = 46; // Example additional price for Shawarma Buy One Take One
const isBeverageCategory = computed(() => selectedCategory.value?.name === 'Fruit Soda & Tea' || selectedCategory.value?.name === 'Yakult Series');
const isShawarmaCategory = computed(() => selectedCategory.value?.name === 'Shawarma');
const currentPrice = computed(() => productToCustomize.value.price + currentVariantPrice.value + selectedAddOns.value.reduce((sum, addOn) => sum + addOn.price, 0));

function selectVariant(variant, priceAdjustment) {
    productToCustomize.value.variant = variant;
    currentVariantPrice.value = priceAdjustment;
    isCustomizingFlavorAndAddOns.value = true;
}

function finalizeCustomization() {
    const cartItem = {
        ...productToCustomize.value,
        variant: productToCustomize.value.variant,
        flavor: selectedFlavor.value,
        addOns: [...selectedAddOns.value],
        currentPrice: currentPrice.value
    };
    orderStore.addToCart(cartItem);
    resetSelections();
}

onMounted(async () => {
    if (!orderStore.categories.length) await orderStore.fetchCategories();
});

function selectProducts(category) {
    selectedCategory.value = category;
    orderStore.fetchProducts(category.id);
    orderStore.fetchCategorySpecificFlavors(category.id);
    orderStore.fetchCategorySpecificAddOns(category.id);
}

function selectProduct(product) {
    productToCustomize.value = product;
}

function selectFlavor(flavor) {
    selectedFlavor.value = flavor;
}

function toggleAddOn(addOn) {
    const index = selectedAddOns.value.findIndex(a => a.id === addOn.id);
    index > -1 ? selectedAddOns.value.splice(index, 1) : selectedAddOns.value.push(addOn);
}

// function getAddOnQuantity(addOn) {
//     return selectedAddOns.value.filter(a => a.id === addOn.id).length;
// }
//
// function addToCart(product) {
//     const cartItem = {
//         ...product,
//         flavor: selectedFlavor.value,
//         addOns: [...selectedAddOns.value],
//         quantity: 1 // Implement quantity logic if necessary
//     };
//     orderStore.addToCart(cartItem);
//     resetSelections();
// }

function continueOrdering() {
    orderStore.ordering = true;
    resetSelections();
}

function reviewOrder() {
    // Implement the review order logic or navigation
}

function cancelOrder() {
    orderStore.clearCart();
    orderStore.ordering = true;
    resetSelections();
}

function resetSelections() {
    productToCustomize.value = null;
    selectedFlavor.value = null;
    selectedAddOns.value = [];
    selectedCategory.value = null;  // Clear the selected category
}

// Navigation functions to go back in the order flow
function goBackToCategories() {
    selectedCategory.value = null;  // Clears the selected category, showing categories again
    productToCustomize.value = null;  // Ensures no product is selected
}

// function goBackToProducts() {
//     productToCustomize.value = null;  // Deselects the current product, showing products again
// }

</script>
