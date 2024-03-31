<template>
    <div>
        <div class="max-w-4xl mx-auto p-4">
            <!-- Category Selection -->
            <div v-if="!orderStore.productToCustomize && orderStore.ordering" class="space-y-4">
                <h2 class="text-2xl font-semibold">Select a Category</h2>
                <div class="flex flex-wrap">
                    <button v-for="category in orderStore.categories" :key="category.id" @click="orderStore.selectProducts(category)"
                            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded m-1">
                        {{ category.name }}
                    </button>
                </div>
            </div>

            <!-- Product Selection -->
            <div v-if="orderStore.selectedCategory && !orderStore.productToCustomize" class="space-y-4">
                <h2 class="text-2xl font-semibold">Select a Product from {{ orderStore.selectedCategory.name }}</h2>
                <div class="flex flex-wrap">
                    <button v-for="product in selectedCategoryProducts" :key="product.id" @click="orderStore.selectProduct(product)"
                            class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded m-1">
                        {{ product.name }} - ₱{{ product.price }}
                    </button>
                </div>
                <button @click="orderStore.goBackToCategories"
                        class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded">
                    Back to Categories
                </button>
            </div>

            <!-- Product Customization: Flavor, Size or Type Selection -->
            <div v-if="orderStore.productToCustomize && orderStore.isCustomizingFlavorAndAddOns" class="space-y-4">
                <h2 class="text-2xl font-semibold">Customize Your {{ orderStore.productToCustomize.name }}</h2>
                <div class="flex flex-wrap">
                    <h3 class="text-xl font-semibold">Current Price: ₱{{ orderStore.currentPrice.toFixed(2) }}</h3>

                    <!-- Quantity Selection -->
                    <div class="w-full space-y-2">
                        <h3 class="text-lg font-medium">Quantity</h3>
                        <input type="number" v-model.number="orderStore.quantity" min="1" max="100" class="border-2 border-gray-300 rounded py-2 px-4" />
                    </div>

                    <!-- Display currently selected flavor -->
                    <div v-if="orderStore.selectedFlavor" class="w-full mb-4">
                        <span class="text-lg font-medium">Selected Flavor: </span>{{ orderStore.selectedFlavor.name }}
                    </div>

                    <div v-if="selectedFlavors.length" class="w-full space-y-2">
                        <h3 class="text-lg font-medium">Select Flavor</h3>
                        <div class="flex flex-wrap">
                            <button
                                v-for="flavor in selectedFlavors" :key="flavor.id" @click="orderStore.selectFlavor(flavor)"
                                class="hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded m-1"
                                :class="{
                                    'bg-indigo-700': orderStore.selectedFlavor && orderStore.selectedFlavor.id === flavor.id,
                                    'bg-indigo-500': !(orderStore.selectedFlavor && orderStore.selectedFlavor.id === flavor.id)
                                } ">
                                {{ flavor.name }}
                            </button>
                        </div>
                    </div>

                    <div v-if="selectedAddOnsList.length" class="space-y-2">
                        <h3 class="text-lg font-medium">Add Ons</h3>
                        <div class="flex flex-wrap">
                            <button v-for="addOn in selectedAddOnsList" :key="addOn.id" @click="orderStore.toggleAddOn(addOn)"
                                    class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded m-1">
                                {{ addOn.name }} (+₱{{ addOn.price }})
                            </button>
                        </div>
                    </div>

                    <button v-if="!orderStore.isCartUpdating" @click="orderStore.goBackToProducts"
                            class="mt-4 bg-gray-200 hover:bg-blue-800 text-black font-bold py-2 px-4 rounded">
                        Go Back to Products
                    </button>

                    <button @click="orderStore.finalizeCustomization()"
                            class="mt-4 bg-blue-600 hover:bg-blue-800 text-white font-bold py-2 px-4 rounded">
                        {{ orderStore.isCartUpdating ? "Update item to cart" : "Add to cart" }}
                    </button>
                </div>
            </div>

            <!-- Cart Display -->
            <div v-if="orderStore.cart.length && orderStore.ordering">
                <h2 class="text-2xl font-semibold">Your Cart</h2>
                <ul class="list-disc pl-5">
                    <li v-for="(item, index) in orderStore.cart" :key="index" @click="orderStore.customizeCartItem(item.id)" class="cursor-pointer mt-2">
                    <div class="font-medium"> {{ item.quantity }} x {{ item.name }} (₱ {{ item.price }})</div>

                        <div v-if="item.flavor">Flavor: {{ item.flavor }}</div>

                        <div>
                            <ul>
                                <li v-for="addOn in item.addOns" :key="addOn.id">
                                    Add On: {{ addOn.name }} (+₱{{ addOn.price }} x {{ item.quantity }})
                                </li>
                            </ul>
                        </div>

                        <p class="text-sm">Total Item Price: ₱{{ (item.currentPrice).toFixed(2) }} </p>
                        <button @click="orderStore.removeFromCart(item.id)"
                                class="bg-red-600 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                            Remove
                        </button>
                    </li>
                </ul>
                <div class="font-bold">Cart Total: ₱{{ parseFloat(orderStore.cartTotal).toFixed(2) }}</div>
                <div class="flex">
                    <button @click="orderStore.continueOrdering"
                            class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                        Continue Ordering
                    </button>
                    <Summary/>
                    <button @click="orderStore.cancelOrder" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
                        Cancel Order
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import { computed, onMounted } from 'vue';
import { useOrderStore } from '@/Store/store-order';
import Summary from "@/Pages/Order/Summary.vue";

// store
const orderStore = useOrderStore();

// computed
const selectedCategoryProducts = computed(() => orderStore.products);
const selectedFlavors = computed(() => orderStore.categorySpecificFlavors);
const selectedAddOnsList = computed(() => orderStore.categorySpecificAddOns);

// onMounted
onMounted(async () => {
    if (!orderStore.categories.length) await orderStore.fetchCategories();
});

</script>

