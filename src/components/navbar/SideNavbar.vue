<script setup>

import {useAuthStore} from "@/stores/store-auth";

const authStore = useAuthStore();
</script>

<template>
    <v-navigation-drawer
        v-if="authStore.isAuthenticated"
        image=""
        permanent
        width="60"
    >
        <v-list nav v-if="authStore.getUser.userType === 'Admin'">
            <v-list-item  prepend-icon="mdi-book-account" title="Bookings" value="inbox">
                <v-tooltip
                    activator="parent"
                    location="right"
                > Bookings
                </v-tooltip>
            </v-list-item>
        </v-list>

        <v-list nav v-else-if="authStore.getUser.userType === 'Merchant'">
            <v-list-item  prepend-icon="mdi-book-account" title="Bookings" value="inbox">
                <v-tooltip
                    activator="parent"
                    location="right"
                > Bookings
                </v-tooltip>
            </v-list-item>
            <v-list-item  prepend-icon="mdi-qrcode-scan" title="QR Scan" value="qr">
                <v-tooltip
                    activator="parent"
                    location="right"
                > QR Scan
                </v-tooltip>
            </v-list-item>
        </v-list>

        <v-list nav v-else>
            <v-list-item  prepend-icon="mdi-book-account" title="My Bookings" value="mybookings"></v-list-item>
        </v-list>
    </v-navigation-drawer>
</template>

<style scoped>

</style>