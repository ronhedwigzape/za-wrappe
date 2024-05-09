import { defineStore } from 'pinia'
import $ from "jquery";
import {useStore} from "@/stores/index.js";

export const useNotificationStore = defineStore('notification', {

    state:() => {
        return {
            notifications: null,
        }
    },
    getters: {

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
                },
                error: (error) => {
                    alert(`ERROR ${error.status}: ${error.statusText}`);
                },
            });
        },
    }

});