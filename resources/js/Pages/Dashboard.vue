<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import Welcome from './Welcome.vue'
</script>

<template>
    <AppLayout title="Dashboard">
        <template #header>
            <Welcome />
        </template>
    </AppLayout>
</template>
