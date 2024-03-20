<template>
    <div>
        <!-- Category Selection -->
        <div v-if="!productToCustomize && orderStore.ordering">
            <h2>Select a Category</h2>
            <button v-for="category in orderStore.categories" :key="category.id" @click="selectProducts(category)">
                {{ category.name }}
            </button>
        </div>

        <!-- Product Selection -->
        <div v-if="selectedCategory && !productToCustomize">
            <h2>Select a Product from {{ selectedCategory.name }}</h2>
            <button v-for="product in selectedCategoryProducts" :key="product.id" @click="selectProduct(product)">
                {{ product.name }} - ${{ product.price }}
            </button>
            <button @click="goBackToCategories">Back to Categories</button>
        </div>

        <!-- Product Customization -->
        <div v-if="productToCustomize">
            <h2>Customize {{ productToCustomize.name }}</h2>

            <div v-if="flavors.length">
                <h3>Flavors</h3>
                <button v-for="flavor in flavors" :key="flavor.id" @click="selectFlavor(flavor)">
                    {{ flavor.name }}
                </button>
            </div>

            <div v-if="addOns.length">
                <h3>Add Ons</h3>
                <div v-for="addOn in addOns" :key="addOn.id">
                    <button @click="toggleAddOn(addOn)">
                        {{ addOn.name }} (+${{ addOn.price }})
                    </button>
                    <div>Quantity: {{ getAddOnQuantity(addOn) }}</div>
                </div>
            </div>

            <button @click="addToCart(productToCustomize)">Add to Cart</button>
            <button @click="goBackToProducts">Back to Products</button>
        </div>

        <!-- Cart and Actions -->
        <div v-if="orderStore.cart.length && orderStore.ordering">
            <h2>Your Cart</h2>
            <div v-for="(item, index) in orderStore.cart" :key="index">
                {{ item.name }} - Flavors: {{ item.flavor?.name }} - Add-Ons: {{ item.addOns.map(a => a.name).join(', ') }} - Quantity: {{ item.quantity }}
            </div>
            <button @click="continueOrdering">Continue Ordering</button>
            <button @click="reviewOrder">Review Order</button>
            <button @click="cancelOrder">Cancel Order</button>
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
const flavors = computed(() => orderStore.flavors);
const addOns = computed(() => orderStore.addOns);

onMounted(async () => {
    if (!orderStore.categories.length) await orderStore.fetchCategories();
    await orderStore.fetchFlavors();
    await orderStore.fetchAddOns();
});

function selectProducts(category) {
    selectedCategory.value = category;
    orderStore.fetchProducts(category.id);
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

function getAddOnQuantity(addOn) {
    return selectedAddOns.value.filter(a => a.id === addOn.id).length;
}

function addToCart(product) {
    const cartItem = {
        ...product,
        flavor: selectedFlavor.value,
        addOns: [...selectedAddOns.value],
        quantity: 1 // Implement quantity logic if necessary
    };
    orderStore.addToCart(cartItem);
    resetSelections();
}

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

function goBackToProducts() {
    productToCustomize.value = null;  // Deselects the current product, showing products again
}

</script>
