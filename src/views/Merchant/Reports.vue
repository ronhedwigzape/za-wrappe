<template>
	<v-container>
		<v-row>
			<v-col cols="12" sm="6">
				<v-select
					v-model="selectedTimeFrame"
					:items="timeFrames"
					label="Select Report Time Frame"
					@change="fetchReport"
					outlined
					dense
				></v-select>
			</v-col>
		</v-row>
		<v-row>
			<v-col cols="12">
				<v-card>
					<v-card-title>
						Sales Report
						<v-btn size="small" prepend-icon="mdi-file-export" color="primary" @click="exportToExcel">Export to XLS</v-btn>
					</v-card-title>

					<v-card-text>
						<v-data-table :items="reportData" :headers="headers">
							<template v-slot:item.order_items="{ item }">
								<v-list dense>
									<v-list-item v-for="orderItem in item.order_items" :key="orderItem.order_item_id">
										<v-list-item-content>
											<v-list-item-title>{{ orderItem.product.name }} x{{ orderItem.quantity }}</v-list-item-title>
											<v-list-item-subtitle>₱{{ orderItem.subtotal }}</v-list-item-subtitle>
											<v-list-item-subtitle>Flavor: {{ orderItem.flavor ? orderItem.flavor.name : 'None' }}</v-list-item-subtitle>
											<v-list-item-subtitle v-if="orderItem.add_ons.length">Add-ons:</v-list-item-subtitle>
											<v-list-item-subtitle v-for="addOn in orderItem.add_ons" :key="addOn.id">
												- {{ addOn.name }} (₱{{ addOn.price }})
											</v-list-item-subtitle>
											<v-list-item-subtitle>Inventory Count: {{ orderItem.inventory.count }}</v-list-item-subtitle>
										</v-list-item-content>
									</v-list-item>
								</v-list>
							</template>
						</v-data-table>
					</v-card-text>
				</v-card>
			</v-col>
		</v-row>
	</v-container>
</template>
<script setup>
import { onMounted, ref } from 'vue';
import { useOrderStore } from '@/stores/store-order.js';
import * as XLSX from 'xlsx';

const orderStore = useOrderStore();
const selectedTimeFrame = ref('daily');
const timeFrames = ['daily', 'weekly', 'monthly'];
const reportData = ref([]);

const headers = [
	{ text: 'Order ID', value: 'order_id' },
	{ text: 'Customer Contact', value: 'customer_contact' },
	{ text: 'Total Price', value: 'total_price' },
	{ text: 'Order Items', value: 'order_items' },
	{ text: 'Created At', value: 'created_at' },
];

const fetchReport = async () => {
	try {
		await orderStore.fetchSalesReport(selectedTimeFrame.value);
		if (!orderStore.reports || !Array.isArray(orderStore.reports.sales_report)) {
			console.error('No reports or invalid format:', orderStore.reports);
			return;
		}
		reportData.value = orderStore.reports.sales_report.map(report => ({
			...report,
			created_at: new Date(report.created_at).toLocaleString(),
		}));
	} catch (error) {
		console.error('Failed to fetch or process reports:', error);
	}
};

const exportToExcel = () => {
	const data = reportData.value.map(order => {
		const orderDetails = {
			'Order ID': order.order_id,
			'Customer Contact': order.customer_contact,
			'Total Price': order.total_price,
			'Created At': order.created_at,
			'Status': order.status,
			'Verification Code': order.verification_code,
			'Payment Status': order.payment_status,
		};

		order.order_items.forEach((item, index) => {
			orderDetails[`Item ${index + 1} - Product Name`] = item.product.name;
			orderDetails[`Item ${index + 1} - Quantity`] = item.quantity;
			orderDetails[`Item ${index + 1} - Subtotal`] = item.subtotal;
			orderDetails[`Item ${index + 1} - Flavor`] = item.flavor ? item.flavor.name : 'None';
			orderDetails[`Item ${index + 1} - Add-ons`] = item.add_ons.map(addOn => `${addOn.name} (₱${addOn.price})`).join(', ');
			orderDetails[`Item ${index + 1} - Inventory Count`] = item.inventory.count;
		});

		return orderDetails;
	});

	const ws = XLSX.utils.json_to_sheet(data);
	const wb = XLSX.utils.book_new();
	XLSX.utils.book_append_sheet(wb, ws, "Sales Report");
	XLSX.writeFile(wb, `Sales_Report_${selectedTimeFrame.value}.xlsx`);
};

onMounted(fetchReport);
</script>

