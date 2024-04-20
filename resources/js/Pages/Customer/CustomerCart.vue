<template>
    <div v-if="useOrderStore().cartVisible && useOrderStore().cart.length && useOrderStore().ordering"
         class="fixed bottom-0 left-0 right-0 bg-white shadow-lg p-4">
        <div class="flex justify-between items-start">
            <h2 class="text-2xl font-semibold"><SfIconShoppingCart/> Your Cart</h2>
            <button @click="useOrderStore().cartVisible = !useOrderStore().cartVisible"
                    class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                Close Cart
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
                    <div class="flex flex-row justify-between border-b-2 border-dashed border-gray-500 p-2">
                        <div class="font-medium"> {{ item.quantity }} x {{ item.name }}</div>
                        <div>₱ {{ item.price }}</div>
                    </div>
                    <small class="list-disc" v-if="item.flavor">Flavor: {{ item.flavor }}</small>
                    <div class="flex flex-row">
                        <div class="">
                            <ul>
                                <li v-for="addOn in item.addOns" :key="addOn.id">
                                    Add On: {{ addOn.name }} (+₱{{ addOn.price }} x {{ item.quantity }})
                                </li>
                            </ul>
                        </div>
                        <p class="text-sm">Total Item Price: ₱{{ (item.currentPrice).toFixed(2) }} </p>
                        <button @click.stop="useOrderStore().removeFromCart(item.id)"
                                class="bg-red-600 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                            Remove
                        </button>
                    </div>
                </li>
            </transition-group>
        </div>
        <!-- Fixed Footer Inside the Cart -->
        <div class="cart-footer p-4 font-bold flex justify-between">
            Cart Total: ₱{{ parseFloat(useOrderStore().cartTotal).toFixed(2) }}
            <div class="flex gap-x-2">
                <button @click="useOrderStore().continueOrdering" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                    Continue Ordering
                </button>
                <Summary/>
                <CancelOrder/>
            </div>
        </div>
    </div>
</template>

<script setup>
import Summary from "@/Pages/Customer/Order/Summary.vue";
import CancelOrder from "@/Components/CancelOrder.vue";
import {useOrderStore} from "@/Store/store-order.js";
import {SfIconShoppingCart} from "@storefront-ui/vue";
</script>

<style scoped>
</style>
