<template>
    <v-app-bar color="black">
        <router-link :to="`/${useAuthStore().getUser.userType}`">
            <v-app-bar-title class="!tw-text-sm pl-5" :text="useStore().app.title" />
        </router-link>
        <v-spacer/>
        <report-button/>
        <notification-button/>
        <menu-button/>
    </v-app-bar>
</template>


<script setup>
import {useStore} from "@/stores";
import MenuButton from "@/components/buttons/MenuButton.vue";
import NotificationButton from "@/components/buttons/NotificationButton.vue";
import {useAuthStore} from "@/stores/store-auth.js";
import ReportButton from "@/components/buttons/ReportButton.vue";

</script>

<style scoped>

</style>