<script setup>
import {useOrderStore} from "@/stores/store-order.js";
import ZaWrappeLogo from "@/components/logo/ZaWrappeLogo.vue";
import ZaWrappeHeadingOne from "@/components/headers/ZaWrappeHeadingOne.vue";

const props = defineProps({
    message: String,
    verificationCode: String,
    orderId: Number,
    totalPrice: Number
});

const closeAndReset = () => {
    useOrderStore().orderCreated = false;
};
</script>

<template>
    <!-- Order Success Message -->
    <transition name="fade">
        <div v-if="useOrderStore().orderCreated" class="tw-fixed tw-inset-0 tw-bg-white tw-flex tw-flex-col tw-items-center tw-justify-center tw-px-4 tw-text-center">
            <ZaWrappeLogo/>
            <div class="tw-py-6">
                <v-icon size="x-large" class="tw-text-green-500 tw-text-7xl">mdi-check-circle</v-icon>
                <ZaWrappeHeadingOne>
                    <template #title>
                        {{ message }}
                    </template>
                </ZaWrappeHeadingOne>
                <p class="tw-text-gray-600 tw-px-6">Thank you for your order, #{{ orderId }}. Your order will be sent to the kitchen, after you've completed the payment of ₱{{ totalPrice.toFixed(2) }}.</p>
                <!--  <p class="text-gray-600 px-6">Verification Code: {{ verificationCode }}</p> -->
            </div>
            <v-btn size="large" class="tw-mt-4 tw-text-xl" @click="closeAndReset">Okay</v-btn>
        </div>
    </transition>
</template>

<style scoped>

</style>
