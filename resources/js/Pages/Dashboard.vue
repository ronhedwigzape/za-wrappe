<script setup>
import { computed } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';
import DashboardCard from '@/Components/DashboardCard.vue';

const props = defineProps({
    auth: {
        type: Object,
        required: true
    }
});

const userType = props.auth.user.user_type;
const userName = props.auth.user.name;

const userRole = computed(() => {
    const roles = {
        'officer': 'Officer',
        'student': 'Student',
        'staff': 'Staff',
        'admin': 'Administrator'
    };
    return roles[userType] || 'User';
});
</script>

<template>
    <AppLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                {{ userRole }}'s Dashboard
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <DashboardCard :student_name="userName" />
                </div>
            </div>
        </div>
    </AppLayout>
</template>

