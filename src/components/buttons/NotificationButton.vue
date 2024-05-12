<script setup>
import { watch } from 'vue';
import router from "@/router/index.js";
import { useNotificationStore } from "@/stores/store-notification.js";

const notificationStore = useNotificationStore();
const navigateToNotifications = () => {
	router.push('/merchant/notifications');
};

watch(() => notificationStore.unreadNotificationsCount, (newCount, oldCount) => {
	console.log(`Notification count changed from ${oldCount} to ${newCount}`);
});

</script>

<template>
	<v-btn
		icon="mdi-bell"
		size="x-large"
		@click="navigateToNotifications"
	>
		<v-badge
			v-if="useNotificationStore().unreadNotificationsCount > 0"
			color="error" :content="notificationStore.unreadNotificationsCount">
			<v-icon>mdi-bell-outline</v-icon>
		</v-badge>
	</v-btn>
</template>
