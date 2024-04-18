<template>
    <div>
        <div class="max-w-4xl mx-auto p-4">
            <!-- Category Selection -->
            <transition-group
                name="fade"
                mode="out-in"
                @before-enter="beforeEnter"
                @enter="enter"
                @leave="leave"
            >
                <div v-if="!orderStore.productToCustomize && orderStore.ordering && !orderStore.selectedCategory"
                     class="flex flex-col items-center justify-center">
                    <h2 class="upperCase"><strong>Select a Category</strong></h2>
                    <div class="flex flex-wrap justify-center w-full">
                        <div v-for="category in orderStore.categories"
                             @click="orderStore.selectProducts(category)"
                             :key="category.id"
                             class="m-2 border border-neutral-200 rounded-md hover:shadow-lg w-[228px] lg:w-[292px]">
                            <div class="relative">
                                <SfLink href="#" class="block">
                                    <img :src="`/${category.image_url}`"
                                         :alt="category.name"
                                         class="block object-cover rounded-md aspect-square lg:w-[250px] lg:h-[290px]"
                                         width="300"
                                         height="300"/>
                                </SfLink>
                            </div>
                            <div class="p-2 border-t border-neutral-200">
                                <SfLink href="#" variant="secondary" class="no-underline text-lg">{{ category.name }}</SfLink>
                                <small class="block mt-2 font-bold">{{ category.description }}</small>
                            </div>
                        </div>
                    </div>
                </div>
            </transition-group>

            <!-- Product Selection -->
            <transition-group
                name="fade"
                mode="out-in"
                @before-enter="beforeEnter"
                @enter="enter"
                @leave="leave"
            >
                <div
                    v-if="orderStore.selectedCategory && !orderStore.productToCustomize"
                    class="flex flex-col items-center justify-center"
                >
                    <h2 class="upperCase"><strong>Select a Product from {{ orderStore.selectedCategory.name }}</strong></h2>
                    <div class="flex flex-wrap justify-center w-full">
                        <div v-for="product in selectedCategoryProducts"
                             :key="product.id"
                             @click="orderStore.selectProduct(product)"
                             class="m-2 border border-neutral-200 rounded-md hover:shadow-lg w-[228px] lg:w-[292px]">
                            <div class="relative">
                                <SfLink href="#" class="block">
                                    <img :src="`/${product.image_url}`"
                                         :alt="product.name"
                                         class="block object-cover rounded-md aspect-square lg:w-[250px] lg:h-[290px]"
                                         width="300"
                                         height="300"/>
                                </SfLink>
                            </div>
                            <div class="p-2 border-t border-neutral-200">
                                <SfLink href="#" variant="secondary" class="no-underline text-lg">{{ product.name }} - ₱{{ product.price }}</SfLink>
                                <small class="block mt-2 font-bold">{{ product.description }}</small>
                            </div>
                        </div>
                    </div>

                    <SfButton variant="secondary" @click="orderStore.goBackToCategories"
                            class="hover:bg-gray-700 font-bold py-2 px-4 rounded">
                        <SfIconArrowBack/>
                        Back to Categories
                    </SfButton>
                </div>
            </transition-group>

            <!-- Product Customization: Flavor, Size or Type Selection -->
            <transition-group
                name="fade"
                mode="out-in"
                @before-enter="beforeEnter"
                @enter="enter"
                @leave="leave"
                class="flex flex-wrap justify-center w-full"
            >
                <div v-if="orderStore.productToCustomize && orderStore.isCustomizingFlavorAndAddOns" class="space-y-4">
                    <ProductCustomization/>
                </div>
            </transition-group>

            <!-- Toggle Button for Cart -->
            <SfButton
                @click="orderStore.cartVisible = !orderStore.cartVisible"
                :class="{
                    'bg-red-700 hover:bg-red-700 cursor-not-allowed': orderStore.cart.length === 0,
                    'bg-blue-500 hover:bg-blue-700 cursor-pointer': orderStore.cart.length > 0
                }"
                :disabled="orderStore.cart.length === 0"
                class="fixed bottom-0 right-0 m-4 text-white font-bold py-2 px-4 rounded">
                Open Cart
            </SfButton>

            <!-- Cart Display -->
            <transition
                name="slide-up"
            >
                <div v-if="orderStore.cartVisible && orderStore.cart.length && orderStore.ordering"
                     class="fixed bottom-0 left-0 right-0 bg-white shadow-lg p-4">
                    <div class="flex justify-between items-start">
                        <h2 class="text-2xl font-semibold">Your Cart</h2>
                        <button @click="orderStore.cartVisible = !orderStore.cartVisible"
                                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                            Close Cart
                        </button>
                    </div>
                    <!-- Scrollable Content Area -->
                    <div class="cart-content">
                        <transition-group name="list" tag="ul" class="list-disc pl-5">
                            <li v-for="(item, index) in orderStore.cart" :key="item.id" @click="orderStore.customizeCartItem(item.id)" class="cursor-pointer mt-2">
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
                                <button @click.stop="orderStore.removeFromCart(item.id)"
                                        class="bg-red-600 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                                    Remove
                                </button>
                            </li>
                        </transition-group>
                    </div>
                    <!-- Fixed Footer Inside the Cart -->
                    <div class="cart-footer p-4 font-bold flex justify-between">
                        Cart Total: ₱{{ parseFloat(orderStore.cartTotal).toFixed(2) }}
                        <div class="flex gap-x-2">
                            <button @click="orderStore.continueOrdering" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                                Continue Ordering
                            </button>
                            <Summary/>
                            <CancelOrder/>
                        </div>
                    </div>
                </div>
            </transition>

        </div>
    </div>
</template>

<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import { computed, onMounted } from 'vue';
import { useOrderStore } from '@/Store/store-order.js';
import Summary from "@/Pages/Customer/Order/Summary.vue";
import {SfButton, SfIconArrowBack, SfLink} from "@storefront-ui/vue";
import CancelOrder from "@/Components/CancelOrder.vue";
import ProductCustomization from "@/Pages/Customer/Order/ProductCustomization.vue";

// store
const orderStore = useOrderStore();

// computed
const selectedCategoryProducts = computed(() => orderStore.products);

// onMounted
onMounted(async () => {
    if (!orderStore.categories.length) await orderStore.fetchCategories();
});

// animations
const beforeEnter = (el) => {
    el.style.opacity = 0;
    el.style.transform = 'translateY(20px)';
};

const enter = (el, done) => {
    el.offsetHeight;
    el.style.transition = 'opacity 0.5s ease-in-out, transform 0.5s ease-in-out';
    el.style.opacity = 1;
    el.style.transform = 'translateY(0)';
    done();
};

const leave = (el, done) => {
    el.style.opacity = 0;
    el.style.transform = 'translateY(-20px)';
    done();
};
</script>

<style scoped>
.fade-enter-active, .fade-leave-active {
    transition: opacity 0.5s ease-in-out;
}
.fade-enter, .fade-leave-to {
    opacity: 0;
}

.list-enter-active, .list-leave-active {
    transition: all 0.5s ease-in-out;
}
.list-enter, .list-leave-to {
    opacity: 0;
    transform: translateY(20px);
}

.slide-up-enter-active, .slide-up-leave-active {
    transition: transform 0.5s ease-in-out;
}
.slide-up-enter, .slide-up-leave-to {
    transform: translateY(100%);
}

.cart-content {
    max-height: 30vh;
    overflow-y: auto;
}

.cart-footer {
    position: sticky;
    bottom: 0;
    background: white;
}

.upperCase {
    text-transform: uppercase !important;
}
</style>


