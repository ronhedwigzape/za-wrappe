<script setup>

import {SfButton, SfIconCheckCircle} from "@storefront-ui/vue";
import {useOrderStore} from "@/Store/store-order.js";
import ZaWrappeTopBar from "@/Components/ZaWrappeTopBar.vue";
import ZaWrappeHeadingOne from "@/Components/ZaWrappeHeadingOne.vue";
const closeAndReset = () => {
    useOrderStore().orderCreated = false;
    window.location.href = '/initialize';
    close();
};
</script>

<template>
    <!-- Order Success Message -->
    <transition name="fade">
        <div v-if="useOrderStore().orderCreated" class="fixed inset-0 bg-white flex flex-col items-center justify-center p-4 text-center">
            <ZaWrappeTopBar/>
            <SfIconCheckCircle class="text-green-500 text-7xl" size="3xl"/>
            <ZaWrappeHeadingOne>
                <template #title>
                    Order Successfully Created!
                </template>
            </ZaWrappeHeadingOne>
            <p class="text-gray-600 px-6">Thank you for your order. Your order will be sent to the kitchen, after you've completed the payment.</p>
            <SfButton variant="primary" class="mt-4" @click="closeAndReset">Okay</SfButton>
        </div>
    </transition>
</template>

<style scoped>

</style>
