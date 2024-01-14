<template>
    <AppLayout title="Notifications">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                School Payment Notifications
            </h2>
        </template>
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <div class="container mx-auto p-4">
                        <h2 class="text-2xl font-bold mb-4">Latest Notifications</h2>
                        <div class="space-y-4">
                            <div v-for="notification in dummyNotifications" :key="notification.id" class="p-4 border border-gray-200 rounded-lg shadow-sm">
                                <div class="flex justify-between items-center mb-2">
                                    <span class="text-lg font-semibold">{{ notification.title }}</span>
                                    <span class="text-sm text-gray-500">{{ notification.date }}</span>
                                </div>
                                <div class="text-gray-700">
                                    {{ notification.message }}
                                </div>
                            </div>
                            <div v-if="dummyNotifications.length === 0" class="text-center text-gray-500">
                                No new notifications.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AppLayout>
</template>

<script setup>
import AppLayout from "@/Layouts/AppLayout.vue";

// Dummy notifications data tailored for a school payment system
const dummyNotifications = [
    {
        id: 1,
        title: 'Tuition Payment Successful',
        message: 'Your tuition payment for the upcoming semester has been received and confirmed.',
        date: 'April 10, 2023'
    },
    {
        id: 2,
        title: 'New Invoice Generated',
        message: 'A new invoice for school fees has been generated. Please review and complete the payment at your earliest convenience.',
        date: 'April 9, 2023'
    },
    {
        id: 3,
        title: 'Scholarship Awarded',
        message: 'Congratulations! You have been awarded a scholarship for the next academic year.',
        date: 'April 8, 2023'
    },
    {
        id: 4,
        title: 'Payment Reminder',
        message: 'This is a friendly reminder that your library fees are due by the end of this month.',
        date: 'April 7, 2023'
    },
    {
        id: 5,
        title: 'Payment Plan Update',
        message: 'Your payment plan has been updated successfully. Please check your email for the new schedule.',
        date: 'April 6, 2023'
    }
];
</script>
