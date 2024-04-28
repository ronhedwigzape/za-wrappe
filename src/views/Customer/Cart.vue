<template>
    <div v-if="useOrderStore().cartVisible && useOrderStore().cart.length && useOrderStore().ordering"
         class="tw-fixed tw-bottom-0 tw-left-0 tw-right-0 tw-bg-white tw-shadow-lg tw-p-4 tw-z-40 tw-border">
        <div class="tw-flex tw-justify-between tw-items-start">
            <h2 class="tw-text-2xl tw-font-semibold"><v-icon>mdi-cart</v-icon> Your Cart</h2>
            <v-btn @click="useOrderStore().cartVisible = !useOrderStore().cartVisible">
                <v-icon>mdi-close-box</v-icon>
            </v-btn>
        </div>
        <!-- Scrollable Content Area -->
        <div class="cart-content">
            <transition-group name="list" tag="ul" class="">
                <li v-for="(item, index) in useOrderStore().cart"
                    :key="item.id"
                    @click="useOrderStore().customizeCartItem(item.id)"
                    class="tw-cursor-pointer tw-mt-2 tw-border-2 !tw-rounded-lg tw-border-dashed tw-border-gray-500"
                >
                    <div class="tw-flex tw-flex-row tw-justify-between tw-items-center tw-border-b-2 tw-border-dashed tw-border-gray-500 tw-p-2">
                        <div class="tw-font-medium tw-pr-3"> {{ item.quantity }} x {{ item.name }} (₱ {{ item.price }})</div>
                        <strong class="tw-text-lg">₱ {{ (item.currentPrice).toFixed(2) }}</strong>
                    </div>
                    <div class="tw-py-2 tw-px-4 tw-flex tw-justify-between tw-items-center">
                        <div class="tw-flex tw-flex-col">
                            <small class="" v-if="item.flavor">Flavor: <b>{{ item.flavor }}</b></small>
                            <div v-if="item.addOns.length" class="">
                                <small class="">Add Ons:</small>
                                <ul>
                                    <li class="tw-list-disc tw-ml-6" v-for="addOn in item.addOns" :key="addOn.id">
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
        <div class="cart-footer tw-py-2 tw-font-bold tw-flex tw-justify-end">
            Cart Total: ₱{{ parseFloat(useOrderStore().cartTotal).toFixed(2) }}
        </div>
        <div class="tw-flex tw-gap-x-2 tw-justify-center tw-items-center">
            <v-btn
                @click="useOrderStore().continueOrdering"
            >
                <v-icon>mdi-cart</v-icon>
                Continue Ordering
            </v-btn>
            <Summary/>
            <CancelOrder/>
        </div>
    </div>
</template>

<script setup>
import Summary from "@/views/Customer/Order/Summary.vue";
import CancelOrder from "@/components/dialogs/CancelOrder.vue";
import {useOrderStore} from "@/stores/store-order.js";
import RemoveItemFromCart from "@/components/dialogs/RemoveItemFromCart.vue";
</script>

<style scoped>
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
