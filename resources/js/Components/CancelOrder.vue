<template>
    <SfButton variant="tertiary" class="border border-red-600 text-red-600 hover:bg-red-600 hover:text-red-50" @click="open">Cancel Order</SfButton>

    <!-- Backdrop -->
    <transition
        enter-active-class="transition duration-200 ease-out"
        leave-active-class="transition duration-200 ease-out"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
    >
        <div v-if="isOpen" class="fixed inset-0 bg-neutral-700 bg-opacity-50" />
    </transition>

    <!-- Modal -->
    <transition
        enter-active-class="transition duration-200 ease-out"
        leave-active-class="transition duration-200 ease-out"
        enter-from-class="opacity-0 translate-y-10"
        enter-to-class="opacity-100 translate-y-0"
        leave-from-class="opacity-100 translate-y-0"
        leave-to-class="opacity-0 translate-y-10"
    >
        <SfModal
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
                        Are you sure you want to clear your cart? This can't be undone.
                    </h2>
                </div>
            </header>
            <footer class="flex justify-end gap-4 mt-4">
                <SfButton variant="secondary" @click="close">No</SfButton>
                <SfButton @click="orderStore.cancelOrder" >Yes</SfButton>
            </footer>
        </SfModal>
    </transition>
</template>

<script setup>
import { SfModal, SfButton, SfIconClose, useDisclosure } from '@storefront-ui/vue';
import { useOrderStore } from '@/Store/store-order.js';

const orderStore = useOrderStore();
const { isOpen, open, close } = useDisclosure({ initialValue: false });
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

</style>
