<template>
    <v-dialog max-width="500">
        <template v-slot:activator="{ props: activatorProps }">
            <v-btn
                v-bind="activatorProps"
                color="red-darken-3"
                text="Cancel Order"
                variant="flat"
            />
        </template>

        <template v-slot:default="{ isActive }">
            <v-card>
                <div class="tw-flex tw-flex-col tw-items-center tw-justify-center">
                    <ZaWrappeLogo/>
                </div>
                <v-card-title class="!tw-text-2xl text-center">
                    Cancel Order
                </v-card-title>
                <v-card-text>
                    Are you sure you want to clear your cart? This can't be undone.
                </v-card-text>
                <v-card-actions>
                    <v-spacer/>
                    <v-btn
                        text="No"
                        @click="isActive.value = false"
                        color="green"
                    />
                    <v-btn
                        text="Yes"
                        @click="orderStore.cancelOrder"
                        color="red"
                    />
                </v-card-actions>
            </v-card>
        </template>
    </v-dialog>
</template>

<script setup>
import {useOrderStore} from "@/stores/store-order.js";
import ZaWrappeLogo from "@/components/logo/ZaWrappeLogo.vue";
const orderStore = useOrderStore();
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
