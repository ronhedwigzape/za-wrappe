<template>
    <section class="tw-max-w-md tw-mx-auto">
        <ZaWrappeHeadingOne>
            <template #title>
                Customize Your {{ orderStore.productToCustomize.name }}
            </template>
        </ZaWrappeHeadingOne>
        <div class="tw-flex tw-justify-center tw-items-center">
            <img
                :src="`../img/${orderStore.productToCustomize.image_url}`"
                alt="Great product"
                class="tw-border tw-border-neutral-200 tw-rounded-md hover:tw-shadow-lg tw-max-w-[300px]"
                width="250"
                height="250"
            />
        </div>
        <span class="tw-block tw-font-bold tw-text-xl tw-text-center tw-my-4">Current Price: ₱{{ orderStore.currentPrice.toFixed(2) }}</span>
        <div class="tw-flex tw-items-center tw-justify-center tw-mt-4 tw-mb-2">
        </div>
        <div class="tw-py-4 tw-mb-4 tw-border-gray-200 tw-border-y">
            <div class="tw-flex tw-flex-col tw-items-center tw-space-y-4">
                <div class="tw-w-full tw-flex tw-flex-col tw-items-center">
                    <div class="tw-flex">
                        <v-btn
                            :disabled="orderStore.quantity <= 1"
                            square
                            class="!tw-rounded-full"
                            aria-label="Decrease value"
                            icon="mdi-minus"
                            @click="orderStore.quantity > 1 ? orderStore.quantity-- : null"
                        />
                        <input
                            v-model.number="orderStore.quantity"
                            type="number"
                            class="tw-appearance-none tw-px-2 tw-mx-2 tw-w-12 tw-text-center tw-bg-transparent tw-font-medium [&::-webkit-inner-spin-button]:tw-appearance-none [&::-webkit-inner-spin-button]:tw-display-none [&::-webkit-inner-spin-button]:tw-m-0 [&::-webkit-outer-spin-button]:tw-display-none [&::-webkit-outer-spin-button]:tw-m-0 [-moz-appearance:textfield] [&::-webkit-outer-spin-button]:tw-appearance-none disabled:tw-placeholder-disabled-900 focus-visible:tw-outline focus-visible:tw-outline-offset focus-visible:tw-rounded-sm"                            min="1"
                            :max="999"
                            @input="handleOnChange"
                        />
                        <v-btn
                            :disabled="orderStore.quantity >= 999"
                            square
                            class="!tw-rounded-full"
                            icon="mdi-plus"
                            aria-label="Increase value"
                            @click="orderStore.quantity < 999 ? orderStore.quantity++ : null"
                        />
                    </div>
                    <p class="tw-my-3 tw-text-xs tw-text-neutral-500">
                        <strong class="tw-text-neutral-900">{{ useOrderStore().productToCustomize.inventory.count }}</strong> in stock
                    </p>
                </div>
                <div v-if="selectedFlavors.length" class="tw-w-full">
                    <ZaWrappeHeadingOne>
                        <template #title>
                            Select your flavor
                        </template>
                    </ZaWrappeHeadingOne>
                    <div class="tw-flex tw-flex-wrap tw-justify-center">
                        <FlavorSlider :flavors="selectedFlavors" />
                    </div>
                </div>
                <div v-if="selectedAddOnsList.length" class="tw-w-full">
                    <ZaWrappeHeadingOne>
                        <template #title>
                            Select your Add-Ons
                        </template>
                    </ZaWrappeHeadingOne>
                    <div class="tw-flex tw-flex-wrap tw-justify-center">
                        <AddOnSlider :add-ons="selectedAddOnsList" />
                    </div>
                </div>
                <v-btn
                    size="large"
                    class="tw-w-full"
                    :prepend-icon="`${orderStore.isCartUpdating ? 'mdi-update' : 'mdi-add'}`"
                    :text="`${orderStore.isCartUpdating ? 'Update item to cart' : 'Add to cart'}`"
                    @click="orderStore.finalizeCustomization()"
                />
                <v-btn
                    v-if="!orderStore.isCartUpdating"
                    @click="orderStore.goBackToProducts"
                    class="tw-w-full"
                    text="Go Back to Products"
                    prepend-icon="mdi-arrow-left"
                />
            </div>
        </div>
    </section>
</template>


<script setup>

import {useOrderStore} from "@/stores/store-order.js";
import { computed } from 'vue';
import FlavorSlider from "@/components/sliders/FlavorSlider.vue";
import AddOnSlider from "@/components/sliders/AddOnSlider.vue";
import ZaWrappeHeadingOne from "@/components/headers/ZaWrappeHeadingOne.vue";

const orderStore = useOrderStore();

function handleOnChange(event) {
    const target = event.target;
    const currentValue = target && target.value;
    const nextValue = parseInt(currentValue, 10);
    if (!isNaN(nextValue)) {
        orderStore.quantity = Math.max(1, Math.min(999, nextValue));
    }
}

// Compute values for selected flavors and add-ons from the orderStore
const selectedFlavors = computed(() => orderStore.categorySpecificFlavors);
const selectedAddOnsList = computed(() => orderStore.categorySpecificAddOns);
</script>
