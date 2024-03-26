<template>
    <div>
        <h2>Your Order Summary</h2>
        <ul>
            <li v-for="(item, index) in orderStore.cart" :key="index">
                {{ item.name }} - Quantity: {{ item.quantity }}
                <button @click="updateOrderItem(item)">Update</button>
                <button @click="removeFromCart(item.id)">Remove</button>
            </li>
        </ul>
        <p>Total: ${{ orderStore.cartTotal }}</p>
        <button @click="confirmOrder">Confirm Order</button>
        <button @click="cancelOrder">Cancel Order</button>
    </div>
</template>

<script setup>
import { useOrderStore } from '@/Store/store-order';

const orderStore = useOrderStore();

const updateOrderItem = (item) => {

};

const removeFromCart = (itemId) => {
    orderStore.removeFromCart(itemId);
};

const confirmOrder = () => {

};

const cancelOrder = () => {
    orderStore.cancelOrder();
};
</script>
