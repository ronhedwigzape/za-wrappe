<template>
    <SfButton @click="open"><SfIconCheckCircle/> Review Order</SfButton>

    <!-- Backdrop and Modal Wrapped Together -->
    <transition
        name="fade"
        enter-active-class="transition-opacity duration-300 ease-out"
        leave-active-class="transition-opacity duration-300 ease-in"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
    >
        <div v-if="isOpen" class="fixed inset-0 bg-neutral-700 bg-opacity-50">
            <transition
                name="slide-up"
                enter-active-class="transition duration-300 ease-out"
                leave-active-class="transition duration-300 ease-in"
                enter-from-class="opacity-0 translate-y-10"
                enter-to-class="opacity-100 translate-y-0"
                leave-from-class="opacity-100 translate-y-0"
                leave-to-class="opacity-0 translate-y-10"
            >
                <SfModal
                    v-if="!useOrderStore().orderCreated"
                    v-model="isOpen"
                    class="max-w-[90%] md:max-w-lg"
                    tag="section"
                    role="alertdialog"
                    aria-labelledby="promoModalTitle"
                    aria-describedby="promoModalDesc"
                >
                    <header class="mb-5">
                        <SfButton square variant="tertiary" class="absolute right-2 top-2" @click="close">
                            <SfIconClose />
                        </SfButton>
                        <div class="flex flex-col items-center justify-center">
                            <img src="/za_wrappe_logo.png" class="h-40" alt="Za-Wrappe logo"/>
                            <h2 id="promoModalTitle" class="text-2xl font-semibold">
                                Is this order correct?
                            </h2>
                        </div>
                    </header>
                    <div class="scrollable-container" v-if="useOrderStore().cartVisible && useOrderStore().cart.length && useOrderStore().ordering">
                        <div class="cart-content">
                            <transition-group name="list" tag="ul" class="">
                                <li v-for="(item, index) in useOrderStore().cart"
                                    :key="item.id"
                                    class="mt-2 border-2 !rounded-lg border-dashed border-gray-500"
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
                                    </div>
                                </li>
                            </transition-group>
                        </div>
                        <div class="cart-footer py-2 font-bold flex justify-end">Total: ₱{{ parseFloat(useOrderStore().cartTotal).toFixed(2) }}</div>
                    </div>
                    <div class="pb-6">
                        <h2 class="typography-label-lg mb-2">Your contact: </h2>
                        <SfInput
                            v-model="customerContact"
                            placeholder="e.g., 09123456789"
                            :valid="isPhoneValid"
                            :error-message="errorMessage"
                            @input="validatePhone"
                            size="base"
                            style="border: none; outline: none !important; box-shadow: none;"
                        />
                    </div>
                    <footer class="flex justify-end gap-4 mt-4">
                        <SfButton variant="secondary" @click="close">No</SfButton>
                        <SfButton :disabled="!isPhoneValid" @click="createOrder">Yes</SfButton>
                    </footer>
                </SfModal>
            </transition>
        </div>
    </transition>
</template>

<script setup>
import { ref } from 'vue';
import { SfModal, SfButton, SfIconClose, SfIconCheckCircle, SfInput, useDisclosure } from '@storefront-ui/vue';
import { useOrderStore } from '@/Store/store-order.js';

const { isOpen, open, close } = useDisclosure({ initialValue: false });
const customerContact = ref('');
const isPhoneValid = ref(false);
const errorMessage = ref('');

const validatePhone = () => {
    const regex = /^(?:\+639|639|09)\d{9}$/;
    isPhoneValid.value = regex.test(customerContact.value);
    errorMessage.value = isPhoneValid.value ? '' : 'Invalid phone number format';
};

const createOrder = async () => {
    if (isPhoneValid.value) {
        try {
            await useOrderStore().createOrder(customerContact.value);
            useOrderStore().orderCreated = true;
            customerContact.value = '';
        } catch (error) {
            console.error('Failed to create order:', error);
            alert('Failed to process order.');
        }
    }
};

</script>

<style scoped>
.scrollable-container {
    overflow-y: auto;
    max-height: 300px;
}

.scrollable-container::-webkit-scrollbar-track {
    background-color: #f0f0f0;
    border-radius: 10px;
}

.scrollable-container::-webkit-scrollbar-thumb {
    background-color: #8c8c8c;
    border-radius: 10px;
}

.scrollable-container::-webkit-scrollbar {
    width: 8px;
}

.fade-enter-active, .fade-leave-active {
    transition: opacity 0.3s ease;
}
.fade-enter, .fade-leave-to {
    opacity: 0;
}

.slide-up-enter-active, .slide-up-leave-active {
    transition: all 0.3s ease-out;
}
.slide-up-enter, .slide-up-leave-to {
    transform: translateY(20px);
    opacity: 0;
}
</style>
