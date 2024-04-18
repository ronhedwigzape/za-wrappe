<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import Welcome from './Customer/CustomerDashboard.vue'
import MerchantDashboard from "@/Pages/Merchant/MerchantDashboard.vue";
import AdminDashboard from "@/Pages/Admin/AdminDashboard.vue";
</script>

<template>
    <AppLayout v-if="$page.props.auth.user.role_id === 1 || $page.props.auth.user.role_id === 2" title="Dashboard">
        <template #header>

            <!--  Admin  -->
            <AdminDashboard v-if="$page.props.auth.user.role_id === 1"/>

            <!--  Merchant  -->
            <MerchantDashboard v-if="$page.props.auth.user.role_id === 2"/>

        </template>
    </AppLayout>

    <!--  Customer  -->
    <Welcome v-if="$page.props.auth.user.role_id === 3"/>
</template>
