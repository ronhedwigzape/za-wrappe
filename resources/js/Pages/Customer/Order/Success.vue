<script setup>
import {SfButton, SfIconCheckCircle} from "@storefront-ui/vue";
import {useOrderStore} from "@/Store/store-order.js";
import ZaWrappeTopBar from "@/Components/ZaWrappeTopBar.vue";
import ZaWrappeHeadingOne from "@/Components/ZaWrappeHeadingOne.vue";

const props = defineProps({
    message: String,
    verificationCode: String,
    orderId: Number,
    totalPrice: Number
});

const closeAndReset = () => {
    useOrderStore().orderCreated = false;
    window.location.href = '/initialize';
};
</script>

<template>
    <!-- Order Success Message -->
    <transition name="fade">
        <div v-if="useOrderStore().orderCreated" class="fixed inset-0 bg-white flex flex-col items-center justify-center px-4 text-center">
            <ZaWrappeTopBar/>
            <div class="py-6">
                <SfIconCheckCircle class="text-green-500 text-7xl" size="2xl"/>
                <ZaWrappeHeadingOne>
                    <template #title>
                        {{ message }}
                    </template>
                </ZaWrappeHeadingOne>
                <p class="text-gray-600 px-6">Thank you for your order, #{{ orderId }}. Your order will be sent to the kitchen, after you've completed the payment of ₱{{ totalPrice.toFixed(2) }}.</p>
                <p class="text-gray-600 px-6">Verification Code: {{ verificationCode }}</p>

            </div>
            <SfButton variant="primary" size="lg" class="mt-4 text-xl" @click="closeAndReset">Okay</SfButton>
        </div>
    </transition>
</template>

<style scoped>

</style>
