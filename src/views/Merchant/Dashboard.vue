<template>
    <TopNavbar/>

        <div v-if="$route.path === '/merchant'">
            <v-card>
                <v-card-title class="text-h5 !tw-font-bold">Orders</v-card-title>
                <v-card-title>
                    <v-text-field
                        v-model="search"
                        variant="outlined"
                        append-icon="mdi-magnify"
                        label="Search"
                        single-line
                        hide-details
                    ></v-text-field>
                </v-card-title>
                <v-data-table
                    :headers="headers"
                    :items="orders"
                    :search="search"
                    :loading="loading"
                    loading-text="Loading orders..."
                >
                    <template v-slot:item.total_price="{ item }">
                        ${{ item.total_price }}
                    </template>
                    <template v-slot:item.created_at="{ item }">
                        {{ new Date(item.created_at).toLocaleString() }}
                    </template>
                    <template v-slot:item.actions="{ item }">
                        <v-btn color="primary" small @click="viewOrder(item)">View</v-btn>
                    </template>
                </v-data-table>
            </v-card>
        </div>
        <router-view v-else/>

</template>

<script setup>
import { ref, onMounted } from 'vue';
import TopNavbar from "@/components/navbar/TopNavbar.vue";
import { useOrderStore } from "@/stores/store-order.js";
import {useNotificationStore} from "@/stores/store-notification.js";

const orderStore = useOrderStore();
const orders = ref([]);
const loading = ref(true);
const search = ref('');

const headers = [
    { title: 'Order ID', align: 'start', key: 'id' },
    { title: 'Status', key: 'status' },
    { title: 'Customer Contact', key: 'customer_contact' },
    { title: 'Total Price', key: 'total_price' },
    { title: 'Created At', key: 'created_at' },
    { title: 'Actions', key: 'actions', sortable: false },
];

onMounted(async () => {
    await orderStore.fetchAllOrders();
    orders.value = orderStore.orders;
    console.log(orderStore.orders)
    loading.value = false;
});

function viewOrder(order) {
    // Implement logic to view order details
    console.log('View order:', order);
}

onMounted(() => {
    useNotificationStore().fetchNotifications();
})
</script>
