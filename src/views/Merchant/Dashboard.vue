<template>
	<TopNavbar/>

	<div v-if="$route.path === '/merchant'">
		<v-card>
			<v-card-title class="text-h5 !tw-font-bold">
				Orders
				<v-btn size="small" color="green" prepend-icon="mdi-file-export" @click="exportOrders">Export to XLS</v-btn>
			</v-card-title>
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
					₱{{ item.total_price }}
				</template>
				<template v-slot:item.created_at="{ item }">
					{{ new Date(item.created_at).toLocaleString() }}
				</template>
				<template v-slot:item.actions="{ item }">
					<v-btn color="primary" small @click="showDialog(item)">View</v-btn>
				</template>
			</v-data-table>
		</v-card>
	</div>
	<router-view v-else/>

	<!-- Order Details Dialog -->
	<v-dialog v-model="dialog" :fullscreen="$vuetify.display.mdAndDown" max-width="800px">
		<v-card>
			<v-card-title class="headline">Order Details - #{{ selectedOrder.id }}</v-card-title>
			<v-card-text>
				<v-container>
					<v-row>
						<v-col cols="12" md="6">
							<div><strong>Customer Contact:</strong> {{ selectedOrder.customer_contact }}</div>
							<div><strong>Status:</strong> {{ selectedOrder.status }}</div>
							<div><strong>Total Price:</strong> ₱{{ selectedOrder.total_price }}</div>
							<div><strong>Verification Code:</strong> {{ selectedOrder.verification_code }}</div>
							<div><strong>Created At:</strong> {{ new Date(selectedOrder.created_at).toLocaleString() }}</div>
							<div><strong>Updated At:</strong> {{ new Date(selectedOrder.updated_at).toLocaleString() }}</div>
						</v-col>
						<v-col cols="12" md="6">
							<v-list-item-title class="!tw-font-bold">Ordered Items:</v-list-item-title>
							<v-list dense>
								<v-list-item v-for="item in selectedOrder.order_items" :key="item.id">
									<v-list-img src="" :src="`../../../${useStore().assetsUrl}/img/${item.product.image_url}`"></v-list-img>
									<v-list-item>
										<v-list-item-title>{{ item.product.name }} x{{ item.quantity }}</v-list-item-title>
										<v-list-item-subtitle>₱{{ item.subtotal }}</v-list-item-subtitle>
									</v-list-item>
								</v-list-item>
							</v-list>
						</v-col>
					</v-row>
				</v-container>
			</v-card-text>
			<v-card-actions>
				<v-row class="flex-column flex-md-row">
					<v-col cols="12" md="auto">
						<v-btn color="blue" block @click="confirmAndProcessPayment(selectedOrder)">Pay</v-btn>
					</v-col>
					<v-col cols="12" md="auto">
						<v-btn color="red" block @click="confirmAndCancelOrder(selectedOrder.id)">Cancel</v-btn>
					</v-col>
					<v-col cols="12" md="auto">
						<v-btn color="orange" block @click="confirmAndPrepareOrder(selectedOrder.id)">Prepare</v-btn>
					</v-col>
					<v-col cols="12" md="auto">
						<v-btn color="green" block @click="confirmAndSetReadyForPickup(selectedOrder.id)">Ready for Pickup</v-btn>
					</v-col>
					<v-col v-if="selectedOrder.payment" cols="12" md="auto">
						<v-btn color="blue darken-1" block @click="printOrderDetails" v-if="selectedOrder.receipt">
							Print Receipt
						</v-btn>
					</v-col>
					<v-col cols="12" md="auto">
						<v-btn color="red darken-1" block text="Close" @click="dialog = false"></v-btn>
					</v-col>
				</v-row>
			</v-card-actions>
		</v-card>
	</v-dialog>
	<div class="print-container tw-hidden">
		<div class="tw-flex tw-flex-col tw-items-center tw-p-5 tw-text-sm tw-w-full tw-max-w-xs tw-mx-auto">
			<img :src="`${useStore().assetsUrl}/img/za_wrappe_logo.png`" alt="Logo" class="tw-w-20 tw-mb-2">
			<h1 class="tw-text-lg tw-font-bold tw-mb-2 tw-text-center">Order Details - #{{ selectedOrder.id }}</h1>
			<div class="tw-w-full tw-mb-2 tw-text-center">
				<p><strong>Total Price:</strong> ₱{{ selectedOrder.total_price }}</p>
				<p><strong>Status:</strong> {{ selectedOrder.status }}</p>
				<p><strong>Verification Code:</strong> {{ selectedOrder.verification_code }}</p>
			</div>
			<div class="tw-w-full tw-text-center">
				<h2 class="tw-text-base tw-font-semibold tw-mb-1">Items Ordered:</h2>
				<div v-for="item in selectedOrder.order_items" :key="item.id" class="tw-py-1">
					<p>{{ item.product.name }} x{{ item.quantity }}</p>
					<p>Subtotal: ₱{{ item.subtotal }}</p>
				</div>
			</div>
		</div>
	</div>
</template>

<script setup>
import axios from 'axios';
import {onMounted, ref, watch} from 'vue';
import TopNavbar from "@/components/navbar/TopNavbar.vue";
import {useOrderStore} from "@/stores/store-order.js";
import {useNotificationStore} from "@/stores/store-notification.js";
import {useStore} from "@/stores/index.js";
import html2canvas from 'html2canvas';
import { jsPDF } from 'jspdf';

const orderStore = useOrderStore();
const orders = ref([]);
const loading = ref(true);
const search = ref('');
const dialog = ref(false);
const selectedOrder = ref({});

const headers = [
	{ title: 'Order #', align: 'start', key: 'id' },
	{ title: 'Status', key: 'status' },
	{ title: 'Customer Contact', key: 'customer_contact' },
	{ title: 'Total Price', key: 'total_price' },
	{ title: 'Created At', key: 'created_at' },
	{ title: 'Actions', key: 'actions', sortable: false },
];

watch(() => orderStore.orders, (newOrders) => {
	orders.value = newOrders;
}, { deep: true });

onMounted(async () => {
	await orderStore.fetchAllOrders();
	await useNotificationStore().fetchNotifications();
	orders.value = orderStore.orders;
	loading.value = false;
});

const showDialog = (order) => {
	selectedOrder.value = order;
	dialog.value = true;
	console.log(order)
};

const confirmAndProcessPayment = async (order) => {
	if (confirm(`Confirm payment of ₱${order.total_price} for Order #${order.id}?`)) {
		await useOrderStore().processPaymentAndGenerateReceipt(order.id, order.total_price, 'Cash', 'ZA-WRAPPEX123');
	}
	dialog.value = false;
};

const confirmAndCancelOrder = async (orderId) => {
	if (confirm("Are you sure you want to cancel this order?")) {
		await useOrderStore().cancelOrder(orderId);
	}
	dialog.value = false;
};

const confirmAndPrepareOrder = async (orderId) => {
	if (confirm("Are you sure you want to prepare this order?")) {
		await useOrderStore().prepareOrder(orderId);
	}
	dialog.value = false;
};

const confirmAndSetReadyForPickup = async (orderId) => {
	if (confirm("Are you sure this order is ready for pickup?")) {
		await useOrderStore().setOrderReadyForPickup(orderId);
	}
	dialog.value = false;
};


const exportOrders = () => {
	window.location.href = `${useStore().appURL}/merchant.php?exportOrdersToXLS=true`;
};

const importOrders = async (event) => {
	const file = event.target.files[0];
	if (!file) return;

	const formData = new FormData();
	formData.append('orderFile', file);
	formData.append('importOrdersFromXLS', true);

	try {
		const response = await axios.post('/merchant.php', formData, {
			headers: {
				'Content-Type': 'multipart/form-data'
			}
		});
		console.log(response.data);
		alert('Orders imported successfully');
	} catch (error) {
		console.error('Error importing orders:', error);
		alert('Failed to import orders');
	}
};

const printOrderDetails = () => {
	const content = document.querySelector('.print-container');
	content.style.display = 'block'; // Temporarily display the container for capturing

	html2canvas(content, {
		onclone: (document) => {
			document.querySelector('.print-container').style.display = 'block';
		}
	}).then(canvas => {
		const imgData = canvas.toDataURL('image/png');
		const pdf = new jsPDF({
			orientation: 'p',
			unit: 'px',
			format: 'a4'
		});

		const pageWidth = pdf.internal.pageSize.getWidth();
		const pageHeight = pdf.internal.pageSize.getHeight();
		const imgWidth = canvas.width;
		const imgHeight = canvas.height;
		const ratio = Math.min(pageWidth / imgWidth, pageHeight / imgHeight);
		const newWidth = imgWidth * ratio;
		const newHeight = imgHeight * ratio;
		const xOffset = (pageWidth - newWidth) / 2;
		const yOffset = (pageHeight - newHeight) / 2;

		pdf.addImage(imgData, 'PNG', xOffset, yOffset, newWidth, newHeight);
		pdf.save('Order_Details.pdf');
		content.style.display = 'none'; // Hide the container again
	});
};


</script>
