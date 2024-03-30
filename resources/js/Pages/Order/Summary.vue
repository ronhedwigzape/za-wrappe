<template>
    <div class="max-w-2xl mx-auto p-4 bg-white shadow-lg rounded-lg">
        <h2 class="text-xl font-bold text-center mb-4">Your Order Summary</h2>
        <Link :href="route('order')">
            <button class="mb-4 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                Back to Order
            </button>
        </Link>
        <ul class="divide-y divide-gray-200">
            <li class="flex justify-between items-center py-3" v-for="(item, index) in orderStore.cart" :key="index">
                <span>
                    {{ item.name }} - Quantity: {{ item.quantity }}
                </span>
                <div>
                    <button class="text-sm bg-blue-500 hover:bg-blue-700 text-white py-1 px-3 rounded-lg mr-2"
                            @click="updateCartItem(item)">Update</button>
                    <button class="text-sm bg-red-500 hover:bg-red-700 text-white py-1 px-3 rounded-lg"
                            @click="removeFromCart(item.id)">Remove</button>
                </div>
            </li>
        </ul>
        <p class="text-lg font-semibold mt-4">Total: <span class="text-green-500">₱{{ orderStore.cartTotal }}</span></p>
        <div class="flex justify-center gap-4 mt-6">
            <button class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded"
                    @click="confirmOrder">Confirm Order</button>
            <button class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded"
                    @click="cancelOrder">Cancel Order</button>
        </div>
    </div>
</template>

<script setup>
import { useOrderStore } from '@/Store/store-order';
import { Head, Link, useForm } from '@inertiajs/vue3';

const orderStore = useOrderStore();

const updateCartItem = async (item) => {
    let newQuantity = parseInt(prompt(`Update quantity for ₱{item.product.name}:`, item.quantity));
    if (isNaN(newQuantity) || newQuantity < 1) {
        alert('Invalid quantity');
        return;
    }
    await orderStore.updateCartItem({ ...item, quantity: newQuantity });
};

const removeFromCart = (itemId) => {
    orderStore.removeFromCart(itemId);
};

const confirmOrder = () => {

};

const cancelOrder = async () => {
    await orderStore.cancelOrder();
    alert('Order has been canceled.');
};
</script>
