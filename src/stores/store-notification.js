import { defineStore } from 'pinia'
import $ from "jquery";
import {useStore} from "@/stores/index.js";

export const useNotificationStore = defineStore('notification', {
    state:() => {
        return {
            notifications: null,
            intervalId: null,
        }
    },
    getters: {
        unreadNotificationsCount() {
            if (Array.isArray(this.notifications)) {
                return this.notifications.filter(notification => notification.status === 'unread').length;
            }
            return 0;
        }
    },
    actions: {
        async fetchNotifications() {
            await $.ajax({
                url: `${useStore().appURL}/merchant.php`,
                type: 'GET',
                xhrFields: {
                    withCredentials: true
                },
                data: {
                    fetchNotificationsFromCustomers: true
                },
                success: (data) => {
                    this.notifications = JSON.parse(data);

                    // Clear the previous interval if it exists
                    if (this.intervalId) {
                        clearInterval(this.intervalId);
                    }

                    // Set a new interval to fetch notifications every 2 seconds
                    this.intervalId = setInterval(() => {
                        this.fetchNotifications();
                    }, 2200);
                },
                error: (error) => {
                    alert(`ERROR ${error.status}: ${error.statusText}`);
                },
            });
        },
        stopFetchingNotifications() {
            clearInterval(this.intervalId);
        },
    }
});
