<template>
    <AppLayout title="Financial Reports">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Financial Reports
            </h2>
        </template>
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg p-4">
                    <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                        Transaction History
                    </h3>
                    <div class="flex space-x-2 mb-3">
                        <button
                            class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded"
                            @click="exportReport"
                        >
                            Export Reports
                        </button>
                        <button
                            class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded"
                            @click="downloadReport"
                        >
                            Download Reports
                        </button>
                    </div>
                    <div class="flex flex-col">
                        <div class="overflow-x-auto">
                            <div class="align-middle inline-block min-w-full">
                                <div class="shadow overflow-hidden border-b border-gray-200 sm:rounded-lg">
                                    <table class="min-w-full divide-y divide-gray-200">
                                        <thead class="bg-gray-50">
                                        <tr>
                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Date
                                            </th>
                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Description
                                            </th>
                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Amount
                                            </th>
                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Status
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody class="bg-white divide-y divide-gray-200">
                                        <tr v-for="transaction in transactions" :key="transaction.id">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                {{ transaction.date }}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                {{ transaction.description }}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                {{ transaction.amount | currency }}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm">
                          <span :class="statusClasses(transaction.status)">
                            {{ transaction.status }}
                          </span>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Dummy Preview Dialog -->
        <div v-if="showPreview" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full" @click.self="showPreview = false">
            <div class="relative top-20 mx-auto p-5 border w-1/2 shadow-lg rounded-md bg-white">
                <div class="mt-3 text-center">
                    <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">Report Preview</h3>
                    <div class="text-left">
                        <!-- Dummy content for preview -->
                        <p>This is a preview of the financial report. It includes all transactions and their details.</p>
                        <ul class="list-disc pl-5 mt-4">
                            <li>Total Transactions: {{ transactions.length }}</li>
                            <li>Total Amount: {{ totalAmount | currency }}</li>
                            <!-- Add more summary data as needed -->
                        </ul>
                    </div>
                    <div class="mt-4">
                        <button @click="showPreview = false" class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded">
                            Close Preview
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </AppLayout>
</template>

<script setup>
import AppLayout from "@/Layouts/AppLayout.vue";
import {computed, ref} from 'vue';

// Expanded dummy data for financial transactions
const transactions = ref([
    { id: 1, date: '2023-04-01', description: 'Payment Received', amount: 1500.00, status: 'Completed' },
    { id: 2, date: '2023-04-02', description: 'Refund Issued', amount: -200.00, status: 'Completed' },
    { id: 3, date: '2023-04-03', description: 'Payment Received', amount: 2500.00, status: 'Pending' },
    { id: 4, date: '2023-04-04', description: 'Service Fee', amount: -50.00, status: 'Completed' },
    { id: 5, date: '2023-04-05', description: 'Payment Received', amount: 750.00, status: 'Completed' },
    { id: 6, date: '2023-04-06', description: 'Payment Failed', amount: 1250.00, status: 'Failed' },
    { id: 7, date: '2023-04-07', description: 'Payment Received', amount: 3200.00, status: 'Completed' },
    { id: 8, date: '2023-04-08', description: 'Payment Canceled', amount: 0.00, status: 'Canceled' },
    // ... more transactions
]);

// Helper function to format currency
const currency = (value) => {
    return `$${value.toFixed(2)}`;
};

// Function to determine status label classes
const statusClasses = (status) => {
    return {
        'px-3 py-1 rounded-full text-sm font-medium': true,
        'bg-green-100 text-green-800': status === 'Completed',
        'bg-yellow-100 text-yellow-800': status === 'Pending',
        'bg-red-100 text-red-800': status === 'Failed',
        'bg-gray-100 text-gray-800': status === 'Canceled',
    };
};

const showPreview = ref(false); // State for showing the report preview dialog

// Method to handle export report action
const exportReport = () => {
    // For the dummy action, we'll just show a preview dialog
    showPreview.value = true;
    // In a real application, you would trigger the report generation and download here
};

// Computed property to calculate the total amount
const totalAmount = computed(() => {
    return transactions.value.reduce((sum, transaction) => sum + transaction.amount, 0);
});

// Method to handle download report action
const downloadReport = () => {
    // Create a CSV string from the transactions data
    const csvContent = [
        ['Date', 'Description', 'Amount', 'Status'], // CSV header
        ...transactions.value.map(t => [t.date, t.description, t.amount, t.status]) // CSV rows
    ]
        .map(e => e.join(','))
        .join('\n');

    // Create a Blob from the CSV string
    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });

    // Create a link and trigger the download
    const link = document.createElement('a');
    const url = URL.createObjectURL(blob);
    link.setAttribute('href', url);
    link.setAttribute('download', 'financial-report.csv');
    link.style.visibility = 'hidden';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
};
</script>

<style>
/* Add any additional styles if needed */
</style>
