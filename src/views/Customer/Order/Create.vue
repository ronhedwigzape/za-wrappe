<template>
    <div>
        <ZaWrappeLogo/>

        <div class="tw-max-w-4xl tw-mx-auto tw-p-4">
            <!-- Category Selection -->
            <transition-group
                name="fade"
                mode="out-in"
                @before-enter="beforeEnter"
                @enter="enter"
                @leave="leave"
            >
                <div v-if="!orderStore.productToCustomize && orderStore.ordering && !orderStore.selectedCategory"
                     class="tw-flex tw-flex-col tw-items-center tw-justify-center">
                    <ZaWrappeHeadingOne>
                        <template #title>
                            Select a Category
                        </template>
                    </ZaWrappeHeadingOne>
                    <div class="tw-flex tw-flex-wrap tw-justify-center tw-w-full">
                        <div v-for="category in orderStore.categories"
                             @click="orderStore.selectProducts(category)"
                             :key="category.id"
                             class="tw-m-2 tw-border tw-border-neutral-200 tw-rounded-md hover:tw-shadow-lg tw-w-[228px] lg:tw-w-[292px]">
                            <div class="tw-relative">
                                <div class="tw-block">
                                    <img
                                        :src="`../img/${category.image_url}`"
                                        :alt="category.name"
                                        class="tw-block tw-object-cover tw-rounded-md tw-aspect-square lg:tw-w-[250px] lg:tw-h-[290px]"
                                        width="300"
                                        height="300"
                                    />
                                </div>
                            </div>
                            <div class="tw-p-2 tw-border-t tw-border-neutral-200">
                                <div class="tw-no-underline tw-text-xl tw-font-extrabold">{{ category.name }}</div>
                                <small class="tw-block tw-mt-2">{{ category.description }}</small>
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
                    class="tw-flex tw-flex-col tw-items-center tw-justify-center"
                >
                    <ZaWrappeHeadingOne>
                        <template #title>
                            Select a Product from {{ orderStore.selectedCategory.name }}
                        </template>
                    </ZaWrappeHeadingOne>
                    <div class="tw-flex tw-flex-wrap tw-justify-center tw-w-full">
                        <div v-for="product in selectedCategoryProducts"
                             :key="product.id"
                             @click="orderStore.selectProduct(product)"
                             class="tw-m-2 tw-border tw-border-neutral-200 tw-rounded-md hover:tw-shadow-lg tw-w-[228px] lg:tw-w-[292px]">
                            <div class="tw-relative">
                                <div class="tw-block">
                                    <img
                                        :src="`../img/${product.image_url}`"
                                        :alt="product.name"
                                        class="tw-block tw-object-cover tw-rounded-md tw-aspect-square lg:tw-w-[250px] lg:tw-h-[290px]"
                                        width="300"
                                        height="300"
                                    />
                                </div>
                            </div>
                            <div class="tw-p-2 tw-border-t tw-border-neutral-200">
                                <div class="tw-no-underline tw-text-xl tw-font-extrabold">{{ product.name }} - ₱{{ product.price }}</div>
                                <small class="tw-block tw-mt-2">{{ product.description }}</small>
                            </div>
                        </div>
                    </div>

                    <v-btn @click="orderStore.goBackToCategories"
                              class="hover:tw-bg-gray-700 tw-font-bold tw-py-2 tw-px-4 tw-rounded">
                        <v-icon>mdi-arrow-left</v-icon>
                        Back to Categories
                    </v-btn>
                </div>
            </transition-group>

            <!-- Product Customization: Flavor, Size or Type Selection -->
            <transition-group
                name="fade"
                mode="out-in"
                @before-enter="beforeEnter"
                @enter="enter"
                @leave="leave"
                class="tw-flex tw-flex-wrap tw-justify-center tw-w-full"
            >
                <div v-if="orderStore.productToCustomize && orderStore.isCustomizingFlavorAndAddOns">
                    <ProductCustomization/>
                </div>
            </transition-group>

            <!-- Toggle Button for Cart -->
            <v-btn
                @click="orderStore.cartVisible = !orderStore.cartVisible"
                class="!tw-fixed !tw-bottom-0 !tw-right-0 !tw-m-4 !tw-font-bold !tw-py-2 !tw-px-4 !tw-rounded"
                :class="{
                    'tw-bg-red-700 hover:tw-bg-red-700 tw-cursor-not-allowed': orderStore.cart.length === 0,
                    'tw-bg-blue-500 tw-cursor-pointer': orderStore.cart.length > 0
                }"
                :disabled="orderStore.cart.length === 0"
            >
                <v-badge color="error" :content="orderStore.cart.length">
                    <v-icon size="x-large">mdi-cart-outline</v-icon>
                </v-badge>
            </v-btn>

            <!--  Show success message after order creation   -->
            <Success
                :message="orderStore.order.message"
                :verification-code="orderStore.order.verification_code"
                :order-id="orderStore.order.order_id"
                :total-price="orderStore.order.total_price"
            />
        </div>
        <!-- Cart Display -->
        <transition name="slide-cart" mode="out-in">
            <CustomerCart v-if="orderStore.cartVisible" key="cart"/>
        </transition>
    </div>
</template>

<script setup>
import {computed, reactive, onMounted, ref, onUnmounted} from 'vue';
import {useOrderStore} from "@/stores/store-order.js";

import ZaWrappeLogo from "@/components/logo/ZaWrappeLogo.vue";
import ProductCustomization from "@/views/Customer/Order/ProductCustomization.vue";
import ZaWrappeHeadingOne from "@/components/headers/ZaWrappeHeadingOne.vue";
import CustomerCart from "@/views/Customer/Cart.vue";
import Success from "@/views/Customer/Order/Success.vue";
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


