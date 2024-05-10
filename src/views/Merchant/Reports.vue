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

const orderStore = useOrderStore();
const selectedTimeFrame = ref('daily');
const timeFrames = ['daily', 'weekly', 'monthly'];
const reportData = ref([]);

const fetchReport = async () => {
    try {
        await orderStore.fetchSalesReport(selectedTimeFrame.value);
        if (!orderStore.reports || !Array.isArray(orderStore.reports)) {
            console.error('No reports or invalid format:', orderStore.reports);
            return; // exit if no reports or if reports are not in expected format
        }
        reportData.value = orderStore.reports;
        reportData.value.forEach(report => {
            if (report) { // check if report is not null or undefined
                report.revenueTrend = generateRandomTrendData();
            }
        });
    } catch (error) {
        console.error('Failed to fetch or process reports:', error);
    }
};

const generateRandomTrendData = () => {
    return Array.from({ length: 5 }, () => Math.floor(Math.random() * 400) + 100);
};

onMounted(fetchReport);
</script>
