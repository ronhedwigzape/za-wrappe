<template>
    <v-card>
        <v-card-title class="text-h5 !tw-font-bold">Notifications</v-card-title>
        <v-card-text>
            <v-list>
                <v-list-item
                    v-for="notification in sortedNotifications"
                    :key="notification.id"
                    three-line
                >
                    <v-list-item>
                        <v-list-item-title>{{ notification.message }}</v-list-item-title>
                        <v-list-item-subtitle>
                            <v-icon small>mdi-clock</v-icon>
                            {{ formatDate(notification.created_at) }}
                        </v-list-item-subtitle>
                    </v-list-item>
                    <v-list-item-action>
                        <v-chip
                            :color="getStatusColor(notification.status)"
                            small
                        >
                            {{ notification.status }}
                        </v-chip>
                    </v-list-item-action>
                </v-list-item>
            </v-list>
        </v-card-text>
    </v-card>
</template>

<script setup>
import { onMounted, computed } from "vue";
import { useNotificationStore } from "@/stores/store-notification.js";

onMounted(() => {
    useNotificationStore().fetchNotifications();
});

const sortedNotifications = computed(() => {
    const notifications = useNotificationStore().notifications;
    if (Array.isArray(notifications)) {
        return [...notifications].sort((a, b) => {
            return new Date(b.created_at) - new Date(a.created_at);
        });
    }
    return [];
});

const formatDate = (dateString) => {
    const options = { year: "numeric", month: "long", day: "numeric" };
    return new Date(dateString).toLocaleDateString(undefined, options);
};

const getStatusColor = (status) => {
    return status === "delivered" ? "green" : "orange";
};
</script>
