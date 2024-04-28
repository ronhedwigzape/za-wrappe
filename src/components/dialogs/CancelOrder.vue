<template>
    <v-dialog max-width="500">
        <template v-slot:activator="{ props: activatorProps }">
            <v-btn
                v-bind="activatorProps"
                color="surface-variant"
                text="Open Dialog"
                variant="flat"
            ></v-btn>
        </template>

        <template v-slot:default="{ isActive }">
            <v-card title="Clear Cart">
                <v-card-text>
                    Are you sure you want to clear your cart? This can't be undone.
                </v-card-text>
                <v-card-actions>
                    <v-spacer/>
                    <v-btn
                        text="No"
                        @click="isActive.value = false"
                    />
                    <v-btn
                        text="Yes"
                        @click="orderStore.cancelOrder"
                    />
                </v-card-actions>
            </v-card>
        </template>
    </v-dialog>
</template>

<script setup>
import {useOrderStore} from "@/stores/store-order.js";
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
