<template>
    <v-app-bar
        color="black"
    >
        <v-app-bar-title :text="store.app.title"/>
        <v-spacer/>
        <menu-button/>
    </v-app-bar>
</template>

<script setup>
import {onMounted, reactive, ref} from "vue";
import {useTheme} from "vuetify";
import SignOut from "@/components/dialogs/SignOutDialog.vue";
import {useAuthStore} from "@/stores/store-auth";
import {useStore} from "@/stores";
import $ from "jquery";
import MenuButton from "@/components/buttons/MenuButton.vue";

// data
const dialog = ref(false);
const theme = useTheme();
const merchants = reactive([]);
const authStore = useAuthStore();
const store = useStore();

// methods
const getMerchantNameById = (senderId) => {
    const merchant = merchants.find((r) => r.id === senderId);
    return merchant ? merchant.name : '';
};

const getMerchantAvatarById = (senderId) => {
    const merchant = merchants.find((r) => r.id === senderId);
    return merchant ? merchant.avatar : '';
};

const notificationTimestamp = (updatedAt) => {
    const timestamp = new Date(updatedAt).toLocaleString("en-US", { timeZone: "Asia/Manila" });
    const now = new Date().toLocaleString("en-US", { timeZone: "Asia/Manila" });
    const timeDifference = new Date(now) - new Date(timestamp);

    if (timeDifference < 1000) {
        return 'Just now';
    }

    // calculate the time differences in seconds, minutes, hours, days, weeks, and months
    const seconds = Math.floor(timeDifference / 1000);
    const minutes = Math.floor(seconds / 60);
    const hours = Math.floor(minutes / 60);
    const days = Math.floor(hours / 24);
    const weeks = Math.floor(days / 7);
    const months = Math.floor(days / 30);

    if (seconds < 60) {
        return `${seconds} second${seconds !== 1 ? 's' : ''} ago`;
    } else if (minutes < 60) {
        return `${minutes} minute${minutes !== 1 ? 's' : ''} ago`;
    } else if (hours < 24) {
        return `${hours} hour${hours !== 1 ? 's' : ''} ago`;
    } else if (days < 7) {
        return `${days} day${days !== 1 ? 's' : ''} ago`;
    } else if (weeks < 4) {
        return `${weeks} week${weeks !== 1 ? 's' : ''} ago`;
    } else {
        return `${months} month${months !== 1 ? 's' : ''} ago`;
    }
};

</script>

<style scoped>

</style>