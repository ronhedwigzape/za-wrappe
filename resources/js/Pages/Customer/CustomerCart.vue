<template>
    <div v-if="useOrderStore().cartVisible && useOrderStore().cart.length && useOrderStore().ordering"
         class="fixed bottom-0 left-0 right-0 bg-white shadow-lg p-4 z-40 border">
        <div class="flex justify-between items-start">
            <h2 class="text-2xl font-semibold"><SfIconShoppingCart/> Your Cart</h2>
            <button @click="useOrderStore().cartVisible = !useOrderStore().cartVisible">
                 <SfIconClose/>
            </button>
        </div>
        <!-- Scrollable Content Area -->
        <div class="cart-content">
            <transition-group name="list" tag="ul" class="">
                <li v-for="(item, index) in useOrderStore().cart"
                    :key="item.id"
                    @click="useOrderStore().customizeCartItem(item.id)"
                    class="cursor-pointer mt-2 border-2 !rounded-lg border-dashed border-gray-500"
                >
                    <div class="flex flex-row justify-between items-center border-b-2 border-dashed border-gray-500 p-2">
                        <div class="font-medium pr-3"> {{ item.quantity }} x {{ item.name }} (₱ {{ item.price }})</div>
                        <strong class="text-lg">₱ {{ (item.currentPrice).toFixed(2) }}</strong>
                    </div>
                    <div class="py-2 px-4 flex justify-between items-center">
                        <div class="flex flex-col">
                            <small class="" v-if="item.flavor">Flavor: <b>{{ item.flavor }}</b></small>
                            <div v-if="item.addOns.length" class="">
                                <small class="">Add Ons:</small>
                                <ul>
                                    <li class="list-disc ml-6" v-for="addOn in item.addOns" :key="addOn.id">
                                        <small><b>{{ addOn.name }}</b> (+₱{{ addOn.price }})</small>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <RemoveItemFromCart :item-id="item.id" :item-name="item.name" />
                    </div>
                </li>
            </transition-group>
        </div>
        <!-- Fixed Footer Inside the Cart -->
        <div class="cart-footer py-2 font-bold flex justify-end">
            Cart Total: ₱{{ parseFloat(useOrderStore().cartTotal).toFixed(2) }}
        </div>
        <div class="flex gap-x-2 justify-center items-center">
            <SfButton
                variant="secondary"
                @click="useOrderStore().continueOrdering"
            >
                Continue Ordering
            </SfButton>
            <Summary/>
            <CancelOrder/>
        </div>
    </div>
</template>

<script setup>
import Summary from "@/Pages/Customer/Order/Summary.vue";
import CancelOrder from "@/Components/CancelOrder.vue";
import {useOrderStore} from "@/Store/store-order.js";
import {
    SfButton,
    SfIconClose,
    SfIconCloseSm,
    SfIconRemove,
    SfIconRemoveShoppingCart,
    SfIconShoppingCart
} from "@storefront-ui/vue";
import RemoveItemFromCart from "@/Components/RemoveItemFromCart.vue";
</script>

<style scoped>
</style>
