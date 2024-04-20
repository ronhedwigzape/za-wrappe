<template>
    <section class="max-w-md mx-auto">
        <ZaWrappeHeadingOne>
            <template #title>
                Customize Your {{ orderStore.productToCustomize.name }}
            </template>
        </ZaWrappeHeadingOne>
        <SfLink class="flex justify-center items-center">
            <img
                :src="orderStore.productToCustomize.image_url"
                alt="Great product"
                class="border border-neutral-200 rounded-md hover:shadow-lg max-w-[300px]"
                width="250"
                height="250"
            />
        </SfLink>
        <span class="block font-bold text-xl text-center my-4">Current Price: ₱{{ orderStore.currentPrice.toFixed(2) }}</span>
        <div class="flex items-center justify-center mt-4 mb-2">
            <SfRating size="xs" :value="4" :max="5" />
            <SfCounter class="ml-1" size="xs">123</SfCounter>
            <SfLink variant="secondary" class="ml-2 text-xs text-neutral-500">123 reviews</SfLink>
        </div>
        <div class="py-4 mb-4 border-gray-200 border-y">
            <div class="flex flex-col items-center space-y-4">
                <div class="w-full flex flex-col items-center">
                    <div class="flex">
                        <SfButton
                            :disabled="orderStore.quantity <= 1"
                            square
                            class="!rounded-full"
                            :aria-controls="inputId"
                            aria-label="Decrease value"
                            @click="orderStore.quantity > 1 ? orderStore.quantity-- : null"
                        >
                            <SfIconRemove />
                        </SfButton>
                        <input
                            :id="inputId"
                            v-model.number="orderStore.quantity"
                            type="number"
                            class="appearance-none px-2 mx-2 w-12 text-center bg-transparent font-medium [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-inner-spin-button]:display-none [&::-webkit-inner-spin-button]:m-0 [&::-webkit-outer-spin-button]:display-none [&::-webkit-outer-spin-button]:m-0 [-moz-appearance:textfield] [&::-webkit-outer-spin-button]:appearance-none disabled:placeholder-disabled-900 focus-visible:outline focus-visible:outline-offset focus-visible:rounded-sm"                            min="1"
                            :max="999"
                            @input="handleOnChange"
                        />
                        <SfButton
                            :disabled="orderStore.quantity >= 999"
                            square
                            class="!rounded-full"
                            :aria-controls="inputId"
                            aria-label="Increase value"
                            @click="orderStore.quantity < 999 ? orderStore.quantity++ : null"
                        >
                            <SfIconAdd />
                        </SfButton>
                    </div>
                    <p class="my-3 text-xs text-neutral-500">
                        <strong class="text-neutral-900">{{ useOrderStore().productToCustomize.inventory.count }}</strong> in stock
                    </p>
                </div>
                <div v-if="selectedFlavors.length" class="w-full">
                    <ZaWrappeHeadingOne>
                        <template #title>
                            Select your flavor
                        </template>
                    </ZaWrappeHeadingOne>
                    <div class="flex flex-wrap justify-center">
                        <FlavorSlider :flavors="selectedFlavors" />
                    </div>
                </div>
                <div v-if="selectedAddOnsList.length" class="w-full">
                    <ZaWrappeHeadingOne>
                        <template #title>
                            Select your Add-Ons
                        </template>
                    </ZaWrappeHeadingOne>
                    <div class="flex flex-wrap justify-center">
                        <AddOnSlider :add-ons="selectedAddOnsList" />
                    </div>
                </div>
                <SfButton size="lg" class="w-full" @click="orderStore.finalizeCustomization()">
                    <template #prefix>
                        <SfIconShoppingCart size="sm" />
                    </template>
                    {{ orderStore.isCartUpdating ? "Update item to cart" : "Add to cart" }}
                </SfButton>
<!--                <div class="flex justify-center w-full gap-x-4">-->
<!--                    <SfButton size="sm" variant="tertiary">-->
<!--                        <template #prefix>-->
<!--                            <SfIconCompareArrows size="sm" />-->
<!--                        </template>-->
<!--                        Compare-->
<!--                    </SfButton>-->
<!--                    <SfButton size="sm" variant="tertiary">-->
<!--                        <SfIconFavorite size="sm" />-->
<!--                        Add to list-->
<!--                    </SfButton>-->
<!--                </div>-->
                <SfButton
                    variant="secondary"
                    v-if="!orderStore.isCartUpdating"
                    @click="orderStore.goBackToProducts"
                    class=" w-full">
                    <SfIconArrowBack />
                    Go Back to Products
                </SfButton>
            </div>
        </div>
    </section>
</template>


<script setup>
import {
    SfButton,
    SfIconAdd,
    SfIconRemove,
    SfIconShoppingCart,
    SfIconShoppingCartCheckout,
    SfIconSell,
    useId,
    SfRating,
    SfCounter,
    SfLink,
    SfIconCompareArrows,
    SfIconFavorite,
    SfIconArrowBack
} from '@storefront-ui/vue';
import { useOrderStore } from '@/Store/store-order.js';
import { computed } from 'vue';
import FlavorSlider from "@/Components/FlavorSlider.vue";
import AddOnSlider from "@/Components/AddOnSlider.vue";
import ZaWrappeHeadingOne from "@/Components/ZaWrappeHeadingOne.vue";

const orderStore = useOrderStore();
const inputId = useId();

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
