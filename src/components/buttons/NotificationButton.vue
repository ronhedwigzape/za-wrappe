<script setup>
import router from "@/router/index.js";

const navigateToNotifications = () => {
    router.push('/merchant/notifications');
};
</script>

<template>
    <v-btn
        icon="mdi-bell"
        @click="navigateToNotifications"
    >

    </v-btn>
</template>