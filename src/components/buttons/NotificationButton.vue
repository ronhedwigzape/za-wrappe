<script setup>
import router from "@/router/index.js";
import {useNotificationStore} from "@/stores/store-notification.js";

const navigateToNotifications = () => {
    router.push('/merchant/notifications');
};
</script>

<template>
    <v-btn
        icon="mdi-bell"
        size="x-large"
        @click="navigateToNotifications"
    >
        <v-badge color="error" :content="useNotificationStore().unreadNotificationsCount">
            <v-icon>mdi-bell-outline</v-icon>
        </v-badge>
    </v-btn>
</template>