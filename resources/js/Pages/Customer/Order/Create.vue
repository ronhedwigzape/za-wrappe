<template>
    <div>
        <ZaWrappeTopBar/>

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
                    <ZaWrappeHeadingOne>
                        <template #title>
                            Select a Category
                        </template>
                    </ZaWrappeHeadingOne>
                    <div class="flex flex-wrap justify-center w-full">
                        <div v-for="category in orderStore.categories"
                             @click="orderStore.selectProducts(category)"
                             :key="category.id"
                             class="m-2 border border-neutral-200 rounded-md hover:shadow-lg w-[228px] lg:w-[292px]">
                            <div class="relative">
                                <SfLink href="#" class="block">
                                    <img
                                        :src="`/${category.image_url}`"
                                        :alt="category.name"
                                        class="block object-cover rounded-md aspect-square lg:w-[250px] lg:h-[290px]"
                                        width="300"
                                        height="300"
                                    />
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
                    <ZaWrappeHeadingOne>
                        <template #title>
                            Select a Product from {{ orderStore.selectedCategory.name }}
                        </template>
                    </ZaWrappeHeadingOne>
                    <div class="flex flex-wrap justify-center w-full">
                        <div v-for="product in selectedCategoryProducts"
                             :key="product.id"
                             @click="orderStore.selectProduct(product)"
                             class="m-2 border border-neutral-200 rounded-md hover:shadow-lg w-[228px] lg:w-[292px]">
                            <div class="relative">
                                <SfLink href="#" class="block">
                                    <img
                                        :src="`/${product.image_url}`"
                                        :alt="product.name"
                                        class="block object-cover rounded-md aspect-square lg:w-[250px] lg:h-[290px]"
                                        width="300"
                                        height="300"
                                    />
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
                <div v-if="orderStore.productToCustomize && orderStore.isCustomizingFlavorAndAddOns">
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
                <SfIconShoppingCart size="lg"/>
            </SfButton>

            <!-- Cart Display -->
            <transition name="slide-cart" mode="out-in">
                <CustomerCart v-if="orderStore.cartVisible" key="cart"/>
            </transition>

        </div>
    </div>
</template>

<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import { computed, reactive, onMounted } from 'vue';
import { useOrderStore } from '@/Store/store-order.js';
import {
    SfButton,
    SfIconArrowBack,
    SfIconOpenInNew,
    SfIconShoppingCart,
    SfIconShoppingCartCheckout,
    SfLink
} from "@storefront-ui/vue";
import ZaWrappeTopBar from "@/Components/ZaWrappeTopBar.vue";
import ProductCustomization from "@/Pages/Customer/Order/ProductCustomization.vue";
import Summary from "@/Pages/Customer/Order/Summary.vue";
import CancelOrder from "@/Components/CancelOrder.vue";
import ZaWrappeHeadingOne from "@/Components/ZaWrappeHeadingOne.vue";
import CustomerCart from "@/Pages/Customer/CustomerCart.vue";

// store
const orderStore = useOrderStore();

// computed
const selectedCategoryProducts = computed(() => orderStore.products);

// animations
const beforeEnter = (el) => {
    el.style.opacity = 0;
    el.style.transform = 'translateY(20px)';
};

// methods
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

// onMounted
onMounted(async () => {
    if (!orderStore.categories.length) await orderStore.fetchCategories();
});

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

.slide-cart-enter-active, .slide-cart-leave-active {
    transition: transform 0.5s ease-in-out;
}

.slide-cart-enter-from, .slide-cart-leave-to {
    transform: translateY(100%);
}

.slide-cart-enter-to, .slide-cart-leave-from {
    transform: translateY(0);
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
</style>


