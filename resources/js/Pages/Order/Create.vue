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
                    <h3 class="text-xl font-semibold">Current Price: ${{ currentPrice.toFixed(2) }}</h3>

                    <!-- Quantity Selection -->
                    <div class="w-full space-y-2">
                        <h3 class="text-lg font-medium">Quantity</h3>
                        <input type="number" v-model.number="quantity" min="1" class="border-2 border-gray-300 rounded py-2 px-4" />
                    </div>

                    <!-- Display currently selected flavor -->
                    <div v-if="selectedFlavor" class="w-full mb-4">
                        <span class="text-lg font-medium">Selected Flavor: </span>{{ selectedFlavor.name }}
                    </div>

                    <div v-if="selectedFlavors.length" class="w-full space-y-2">
                        <h3 class="text-lg font-medium">Select Flavor</h3>
                        <div class="flex flex-wrap">
                            <button
                                v-for="flavor in selectedFlavors" :key="flavor.id" @click="selectFlavor(flavor)"
                                class="hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded m-1"
                                :class="{
                                    'bg-indigo-700': selectedFlavor && selectedFlavor.id === flavor.id,
                                    'bg-indigo-500': !(selectedFlavor && selectedFlavor.id === flavor.id)
                                } ">
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

                    <button @click="goBackToProducts"
                            class="mt-4 bg-gray-200 hover:bg-blue-800 text-black font-bold py-2 px-4 rounded">
                        Go Back to Products
                    </button>

                    <button @click="finalizeCustomization()"
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
                        <div class="font-medium">{{ item.name }}</div>

                        <div v-if="item.flavor">{{ item.flavor }}</div>

                        <div>
                            <ul>
                                <li v-for="addOn in item.addOns" :key="addOn.id">
                                    {{ addOn.name }} (+${{ addOn.price }})
                                </li>
                            </ul>
                        </div>

                        <div>Quantity:
                            <input type="number" v-model="item.quantity" min="1" class="border-2 border-gray-300 rounded py-2 px-4" />
                        </div>
                        <div>Price: ${{ (item.currentPrice * item.quantity).toFixed(2) }}</div>
                        <button @click="removeFromCart(item.id)"
                                class="bg-red-600 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                            Remove
                        </button>
                    </li>
                </ul>
                <div class="font-bold">Total: ${{ parseFloat(orderStore.cartTotal).toFixed(2) }}</div>

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

// store
const orderStore = useOrderStore();

// data
const selectedCategory = ref(null);
const productToCustomize = ref(null);
const selectedFlavor = ref(null);
const selectedAddOns = ref([]);
const isCustomizingFlavorAndAddOns = ref(false);
const quantity = ref(1);
const customizations = ref("");

// computed
const selectedCategoryProducts = computed(() => orderStore.products);
const selectedFlavors = computed(() => orderStore.categorySpecificFlavors);
const selectedAddOnsList = computed(() => orderStore.categorySpecificAddOns);

const currentPrice = computed(() => {
    let basePrice = productToCustomize.value ? parseFloat(productToCustomize.value.price) : 0;
    let flavorPrice = selectedFlavor.value && selectedFlavor.value.price ? parseFloat(selectedFlavor.value.price) : 0;
    let addOnsPrice = selectedAddOns.value && selectedAddOns.value.length > 0
        ? selectedAddOns.value.reduce((sum, addOn) => sum + parseFloat(addOn.price || 0), 0)
        : 0;

    let totalPriceWithoutQuantity = basePrice + flavorPrice + addOnsPrice;
    let totalPrice = totalPriceWithoutQuantity * quantity.value;

    return parseFloat(totalPrice.toFixed(2));
});

// methods
function finalizeCustomization() {
    const cartItem = {
        id: Date.now(),
        ...productToCustomize.value,
        variant: productToCustomize.value,
        flavor: selectedFlavor.value ? selectedFlavor.value.name : 'None',
        addOns: [...selectedAddOns.value],
        currentPrice: currentPrice.value,
        quantity: quantity.value,
        customizations: customizations.value
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

function selectFlavor(flavor) {
    if (selectedFlavor.value && selectedFlavor.value.id === flavor.id) {
        selectedFlavor.value = null;
    } else {
        selectedFlavor.value = flavor;
    }
}

function toggleAddOn(addOn) {
    console.log(`Toggling add on: ${addOn.id} ${selectedAddOns.value}`)
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
}

function resetSelections() {
    productToCustomize.value = null;
    selectedFlavor.value = null;
    selectedAddOns.value = [];
    selectedCategory.value = null;
    quantity.value = 1;
}

function goBackToCategories() {
    selectedCategory.value = null;
    productToCustomize.value = null;
}

function goBackToProducts() {
    if (selectedCategory.value && !selectedCategoryProducts.value.length) {
        selectProducts(selectedCategory.value);
    }
    productToCustomize.value = null;
    selectedFlavor.value = null;
    selectedAddOns.value = [];
    quantity.value = 1;
    customizations.value = "";
}

function removeFromCart(itemId) {
    orderStore.removeFromCart(itemId);
}

</script>

