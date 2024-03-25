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

            <!-- Product Customization: Flavor, Size or Type Selection -->
            <div v-if="productToCustomize && isCustomizingFlavorAndAddOns" class="space-y-4">
                <h2 class="text-2xl font-semibold">Customize Your {{ productToCustomize.name }}</h2>
                <div class="flex flex-wrap">
                    <h3 class="text-xl font-semibold">Current Price: ${{ currentPrice }}</h3>

                    <!-- Display currently selected flavor -->
                    <div v-if="selectedFlavor" class="mb-4">
                        <h4 class="text-lg font-medium">Current Flavor: {{ selectedFlavor.name }}</h4>
                    </div>

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
            </div>

            <!-- Cart Display -->
            <div v-if="orderStore.cart.length && orderStore.ordering" class="mt-8 space-y-4">
                <h2 class="text-2xl font-semibold">Your Cart</h2>
                <ul class="list-disc pl-5">
                    <li v-for="(item, index) in orderStore.cart" :key="index" class="mt-2">
                        <div class="font-medium">{{ item.name }} - Variant: {{ item.variant }}</div>
                        <div v-if="item.flavor">Flavor: {{ item.flavor }}</div>
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

const currentPrice = computed(() => {
    let price = productToCustomize.value ? productToCustomize.value.price : 0;
    if (selectedFlavor.value && selectedFlavor.value.price) {
        price += selectedFlavor.value.price;
    }
    if (selectedAddOns.value && selectedAddOns.value.length > 0) {
        price += selectedAddOns.value.reduce((sum, addOn) => sum + (addOn.price || 0), 0);
    }
    return price;
});

// Ensure the finalizeCustomization method correctly handles the absence of a selected flavor.
function finalizeCustomization() {
    const cartItem = {
        ...productToCustomize.value,
        variant: productToCustomize.value.variant,
        flavor: selectedFlavor.value ? selectedFlavor.value.name : 'None', // Handle no flavor selected.
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
    isCustomizingFlavorAndAddOns.value = true;
}

// Updated selectFlavor method to handle flavor toggling more robustly.
function selectFlavor(flavor) {
    if (selectedFlavor.value && selectedFlavor.value.id === flavor.id) {
        selectedFlavor.value = null; // Deselect if clicked again
    } else {
        selectedFlavor.value = flavor; // Select new flavor
    }
}

function toggleAddOn(addOn) {
    const index = selectedAddOns.value.findIndex(a => a.id === addOn.id);
    index > -1 ? selectedAddOns.value.splice(index, 1) : selectedAddOns.value.push(addOn);
}

function continueOrdering() {
    orderStore.ordering = true;
    resetSelections();
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
    selectedCategory.value = null;
}

function goBackToCategories() {
    selectedCategory.value = null;
    productToCustomize.value = null;
}

</script>

