<script setup>
import router from "@/router/index.js";

const navigateToReports = () => {
    router.push('/merchant/reports');
};
</script>

<template>
    <v-btn
        icon="mdi-chart-bar"
        size="x-large"
        @click="navigateToReports"
    >
    </v-btn>
</template>