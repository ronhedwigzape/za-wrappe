<template>
    <section class="max-w-md mx-auto">
        <div class="inline-flex items-center justify-center text-sm font-medium text-white bg-secondary-600 py-1.5 px-3 mb-4">
            <SfIconSell size="sm" class="mr-1.5" />
            Sale
        </div>
        <h1 class="mb-1 font-bold text-lg text-center">Customize Your {{ orderStore.productToCustomize.name }}</h1>
        <strong class="block font-bold text-lg text-center mb-4">Current Price: ₱{{ orderStore.currentPrice.toFixed(2) }}</strong>
        <div class="flex items-center justify-center mt-4 mb-2">
            <SfRating size="xs" :value="4" :max="5" />
            <SfCounter class="ml-1" size="xs">123</SfCounter>
            <SfLink href="#" variant="secondary" class="ml-2 text-xs text-neutral-500">123 reviews</SfLink>
        </div>
        <div class="py-4 mb-4 border-gray-200 border-y">
            <div class="flex flex-col items-center space-y-4">
                <div class="w-full flex flex-col items-center">
                    <div class="flex border border-neutral-300 rounded-md">
                        <SfButton
                            variant="tertiary"
                            :disabled="orderStore.quantity <= 1"
                            square
                            class="rounded-r-none p-3"
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
                            class="grow appearance-none text-center bg-transparent font-medium focus-visible:outline-none [&::-webkit-inner-spin-button]:hidden"
                            min="1"
                            :max="999"
                            @input="handleOnChange"
                        />
                        <SfButton
                            variant="tertiary"
                            :disabled="orderStore.quantity >= 999"
                            square
                            class="rounded-l-none p-3"
                            :aria-controls="inputId"
                            aria-label="Increase value"
                            @click="orderStore.quantity < 999 ? orderStore.quantity++ : null"
                        >
                            <SfIconAdd />
                        </SfButton>
                    </div>
                    <p class="text-xs text-neutral-500">
                        <strong class="text-neutral-900">999</strong> in stock
                    </p>
                </div>
                <div v-if="orderStore.selectedFlavor" class="w-full mb-4">
                    <span class="text-lg font-medium">Selected Flavor: </span>{{ orderStore.selectedFlavor.name }}
                </div>
                <div v-if="selectedFlavors.length" class="w-full">
                    <h3 class="text-lg font-medium">Select Flavor</h3>
                    <div class="flex flex-wrap justify-center">
                        <button
                            v-for="flavor in selectedFlavors"
                            :key="flavor.id"
                            @click="orderStore.selectFlavor(flavor)"
                            class="hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded m-1"
                            :class="{'bg-indigo-700': orderStore.selectedFlavor && orderStore.selectedFlavor.id === flavor.id, 'bg-indigo-500': !(orderStore.selectedFlavor && orderStore.selectedFlavor.id === flavor.id)}"
                        >
                            {{ flavor.name }}
                        </button>
                    </div>
                </div>
                <div v-if="selectedAddOnsList.length" class="w-full">
                    <h3 class="text-lg font-medium">Add Ons</h3>
                    <div class="flex flex-wrap justify-center">
                        <button
                            v-for="addOn in selectedAddOnsList"
                            :key="addOn.id"
                            @click="orderStore.toggleAddOn(addOn)"
                            class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded m-1"
                        >
                            {{ addOn.name }} (+₱{{ addOn.price }})
                        </button>
                    </div>
                </div>
                <SfButton size="lg" class="w-full" @click="orderStore.finalizeCustomization()">
                    <template #prefix>
                        <SfIconShoppingCart size="sm" />
                    </template>
                    {{ orderStore.isCartUpdating ? "Update item to cart" : "Add to cart" }}
                </SfButton>
                <div class="flex justify-center w-full gap-x-4">
                    <SfButton size="sm" variant="tertiary">
                        <template #prefix>
                            <SfIconCompareArrows size="sm" />
                        </template>
                        Compare
                    </SfButton>
                    <SfButton size="sm" variant="tertiary">
                        <SfIconFavorite size="sm" />
                        Add to list
                    </SfButton>
                </div>
                <div
                    v-if="!orderStore.isCartUpdating"
                    @click="orderStore.goBackToProducts"
                    class="bg-primary-100 text-primary-700 flex justify-center gap-1.5 py-1.5 items-center cursor-pointer mb-4 rounded-md w-full">
                    <SfIconArrowBack />
                    Go Back to Products
                </div>
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
