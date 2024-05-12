<template>
	<v-card>
		<v-card-title class="text-h5 !tw-font-bold">Notifications</v-card-title>
		<v-card-text>
			<v-list>
				<v-card
					v-for="notification in sortedNotifications"
					:key="notification.id"
					class="mb-2"
					@click="showDialog(notification)"
				>
					<v-card-title>
						{{ notification.message }}
						<v-spacer></v-spacer>
						<v-icon>mdi-chevron-right</v-icon>
					</v-card-title>
					<v-card-subtitle>
						<v-icon small>mdi-clock</v-icon>
						{{ formatDate(notification.created_at) }}
					</v-card-subtitle>
					<v-chip
						:color="getStatusColor(notification.status)"
						small
					>
						{{ notification.status }}
					</v-chip>
				</v-card>
			</v-list>
		</v-card-text>
	</v-card>

	<!-- Notification Details Dialog -->
	<v-dialog v-model="dialog" persistent max-width="600px">
		<v-card>
			<v-card-title class="!tw-text-2xl">{{ selectedNotification.message }}</v-card-title>
			<v-card-text>
				<small class="!tw-mb-4">{{ selectedNotification.message }}</small>
				<div><strong>Date:</strong> {{ formatDate(selectedNotification.created_at) }}</div>
				<div v-html="selectedNotification.details"></div>
			</v-card-text>
			<v-card-actions>
				<v-spacer></v-spacer>
				<v-btn color="red darken-1" text @click="dialog = false">Close</v-btn>
			</v-card-actions>
		</v-card>
	</v-dialog>
</template>
<script setup>
import { ref, onMounted, computed } from "vue";
import { useNotificationStore } from "@/stores/store-notification.js";

const store = useNotificationStore();
onMounted(() => {
	store.fetchNotifications();
});

const notifications = ref(store.notifications);
const dialog = ref(false);
const selectedNotification = ref({});

const sortedNotifications = computed(() => {
	return notifications.value.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));
});

const formatDate = (dateString) => {
	const options = { year: "numeric", month: "long", day: "numeric" };
	return new Date(dateString).toLocaleDateString(undefined, options);
};

const getStatusColor = (status) => {
	return status === "delivered" ? "green" : "orange";
};

const showDialog = (notification) => {
	selectedNotification.value = notification;
	dialog.value = true;
};
</script>
