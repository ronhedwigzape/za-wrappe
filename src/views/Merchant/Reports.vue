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
                        <v-data-table :items="reportData">
                            <template v-slot:[`item.trend`]="{ item }">
                                <v-sparkline
                                    :model-value="item.revenueTrend"
                                    :gradient="['#e91e63', '#3f51b5']"
                                    :label-size="7"
                                    :padding="8"
                                    :line-width="2"
                                    :width="100"
                                    :height="25"
                                    auto-draw
                                ></v-sparkline>
                            </template>
                            <template v-slot:header="{ props }">
                                <thead>
                                <tr>
                                    <th class="text-left">Date</th>
                                    <th class="text-left">Order Count</th>
                                    <th class="text-left">Total Revenue</th>
                                    <th class="text-left">Trend</th>
                                </tr>
                                </thead>
                            </template>
                            <template v-slot:item="{ item }">
                                <tr>
                                    <td>{{ item.date }}</td>
                                    <td>{{ item.order_count }}</td>
                                    <td>{{ item.total_revenue }}</td>
                                    <td>
                                        <v-sparkline
                                            :model-value="item.revenueTrend"
                                            :gradient="['#e91e63', '#3f51b5']"
                                            :label-size="7"
                                            :padding="8"
                                            :line-width="2"
                                            :width="100"
                                            :height="25"
                                            auto-draw
                                        ></v-sparkline>
                                    </td>
                                </tr>
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

const fetchReport = async () => {
	try {
		await orderStore.fetchSalesReport(selectedTimeFrame.value);
		if (!orderStore.reports || !Array.isArray(orderStore.reports.sales_report)) {
			console.error('No reports or invalid format:', orderStore.reports);
			return;
		}
		reportData.value = orderStore.reports.sales_report.map(report => ({
			...report,
			revenueTrend: generateRandomTrendData()
		}));
	} catch (error) {
		console.error('Failed to fetch or process reports:', error);
	}
};

const generateRandomTrendData = () => {
	return Array.from({ length: 5 }, () => Math.floor(Math.random() * 400) + 100);
};

const exportToExcel = () => {
	const ws = XLSX.utils.json_to_sheet(reportData.value.map(({ revenueTrend, ...item }) => item));
	const wb = XLSX.utils.book_new();
	XLSX.utils.book_append_sheet(wb, ws, "Sales Report");
	XLSX.writeFile(wb, `Sales_Report_${selectedTimeFrame.value}.xlsx`);
};

onMounted(fetchReport);
</script>
