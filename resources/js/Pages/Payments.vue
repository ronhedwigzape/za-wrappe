<template>
    <AppLayout title="Payments">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Your Payments
            </h2>
        </template>
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <div class="container mx-auto p-4">
                        <div v-if="userType === 'officer' || userType === 'staff'" class="mb-4">
                            <button
                                class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded"
                                @click="showCreateLinkDialog = true"
                            >
                                Create Link
                            </button>
                        </div>
                        <h2 class="text-2xl font-bold mb-4">All Payment Links</h2>
                        <div v-if="isLoading" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            <div v-for="n in 6" :key="n" class="animate-pulse p-6 border border-gray-200 rounded-lg">
                                <n-skeleton height="20px" width="100%" />
                                <n-skeleton height="20px" width="80%" class="mt-4" />
                                <n-skeleton height="20px" width="60%" class="mt-4" />
                                <n-skeleton height="20px" width="40%" class="mt-4" />
                                <n-skeleton height="40px" width="100%" class="mt-6" />
                            </div>
                        </div>
                        <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            <div v-for="link in allLinks" :key="link.id" class="bg-gray-50 p-6 border border-gray-200 rounded-lg shadow-sm hover:shadow-md transition-shadow duration-150 ease-in-out">
                                <div class="flex justify-between items-center mb-4">
                                    <span class="text-lg font-semibold">{{ link.attributes.reference_number }}</span>
                                    <span :class="link.attributes.status === 'paid' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'" class="px-3 py-1 rounded-full text-sm font-medium">
                                        {{ link.attributes.status.toUpperCase() }}
                                  </span>
                                </div>
                                <div class="mb-2">
                                    <strong>Amount:</strong> ₱{{ (link.attributes.amount / 100).toFixed(2) }}
                                </div>
                                <div class="mb-2">
                                    <strong>Created at:</strong> {{ new Date(link.attributes.created_at * 1000).toLocaleString() }}
                                </div>
                                <div class="mb-2">
                                    <strong>Description:</strong> {{ link.attributes.description }}
                                </div>
                                <div class="mb-4">
                                    <strong>Remarks:</strong> {{ link.attributes.remarks || 'No remarks' }}
                                </div>

                                <a v-if="link.attributes.status === 'paid'" @click="showPaymentDetails(link)" class="inline-block bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded transition-colors duration-150 ease-in-out cursor-pointer">
                                    View Payment
                                </a>
                                <a v-else :href="link.attributes.checkout_url" class="inline-block bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded transition-colors duration-150 ease-in-out" target="_blank">Checkout Payment</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Tailwind CSS Dialog for Creating Links -->
        <div v-if="showCreateLinkDialog" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full" @click.self="showCreateLinkDialog = false">
            <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
                <div class="mt-3 text-center">
                    <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-green-100">
                        <!-- Icon -->
                        <svg class="h-6 w-6 text-green-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                    </div>
                    <h3 class="text-lg leading-6 font-medium text-gray-900">Create Payment Link</h3>
                    <!-- Form for creating a link -->
                    <form class="mt-2" @submit.prevent="createLink">
                        <input type="number" v-model="linkAmount" placeholder="Amount" class="mt-2 px-4 py-2 border rounded-md w-full" required />
                        <textarea v-model="linkDescription" placeholder="Description" class="mt-2 px-4 py-2 border rounded-md w-full" required></textarea>
                        <textarea v-model="linkRemarks" placeholder="Remarks (optional)" class="mt-2 px-4 py-2 border rounded-md w-full"></textarea>
                        <div class="items-center px-4 py-3">
                            <button id="ok-btn" class="px-4 py-2 bg-green-500 text-white text-base font-medium rounded-md w-full shadow-sm hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-300">
                                Create
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Payment Details Dialog -->
        <div v-if="showPaymentDialog" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full" @click.self="showPaymentDialog = false">
            <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
                <div class="mt-3 text-center">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">Payment Details</h3>
                    <div class="mt-2 px-7 py-3 text-left">
                        <p><strong>Reference Number:</strong> {{ selectedPayment.attributes.reference_number }}</p>
                        <p><strong>Amount:</strong> ₱{{ (selectedPayment.attributes.amount / 100).toFixed(2) }}</p>
                        <p><strong>Description:</strong> {{ selectedPayment.attributes.description }}</p>
                        <p><strong>Status:</strong> {{ selectedPayment.attributes.status }}</p>
                        <p v-if="selectedPayment.attributes.payments && selectedPayment.attributes.payments.length > 0">
                            <strong>Paid At:</strong> {{ new Date(selectedPayment.attributes.payments[0].data.attributes.paid_at * 1000).toLocaleString() }}
                        </p>
                        <p v-if="selectedPayment.attributes.payments && selectedPayment.attributes.payments.length > 0">
                            <strong>Payment Mode:</strong> {{ selectedPayment.attributes.payments[0].data.attributes.source.type }}
                        </p>
                        <!-- Add more details as needed -->
                    </div>
                    <span class="inline-flex w-full rounded-md shadow-sm">
                        <button @click="showPaymentDialog = false" class="inline-flex justify-center w-full px-4 py-2 text-white bg-blue-600 hover:bg-blue-700 rounded-md focus:outline-none">
                          Close
                        </button>
                  </span>
                </div>
            </div>
        </div>
    </AppLayout>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue';
import { useStore } from '@/Store/store';
import AppLayout from "@/Layouts/AppLayout.vue";
import { NSkeleton } from 'naive-ui';

const props = defineProps({
    auth: {
        type: Object,
        required: true
    }
});

const userType = props.auth.user.user_type;
const store = useStore();
const isLoading = ref(true); // Initial loading state
const showCreateLinkDialog = ref(false); // State for showing the create link dialog
const linkAmount = ref(''); // Model for link amount input
const linkDescription = ref(''); // Model for link description input
const linkRemarks = ref(''); // Model for link remarks input
const showPaymentDialog = ref(false);
const selectedPayment = ref({ attributes: {} });

onMounted(async () => {
    try {
        await store.listAllLinks(); // Call the action to fetch links
    } catch (error) {
        console.error('Failed to fetch links:', error);
    } finally {
        isLoading.value = false; // Set loading state to false once data is fetched
    }
});

// Use computed to create a reactive computed property for allLinks
const allLinks = computed(() => store.getAllLinks);

// Method to create a link
// Method to create a link
const createLink = async () => {
    const linkData = {
        data: {
            attributes: {
                amount: linkAmount.value * 100, // Assuming the amount should be in cents
                description: linkDescription.value,
                remarks: linkRemarks.value || null, // Use null if remarks are optional and not provided
            }
        }
    };
    // Call the store action to create a link
    try {
        await store.createLink(linkData);
        // Reset form and close dialog
        linkAmount.value = '';
        linkDescription.value = '';
        linkRemarks.value = '';
        showCreateLinkDialog.value = false;
        // Show success alert message
        alert('Payment link is successfully made.');
    } catch (error) {
        // Handle error case, e.g., show an error message
        console.error('Failed to create link:', error);
        alert('Failed to create payment link.');
    }
};


// Method to show payment details
const showPaymentDetails = (payment) => {
    selectedPayment.value = payment;
    showPaymentDialog.value = true;
};
</script>
