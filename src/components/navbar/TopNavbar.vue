<template>
    <v-app-bar color="black">
        <router-link :to="`/${useAuthStore().getUser.userType}`">
            <v-app-bar-title class="!tw-text-sm pl-3" :text="useStore().app.title" />
        </router-link>
        <v-spacer/>
        <notification-button/>
        <menu-button/>
    </v-app-bar>
</template>


<script setup>
import {useStore} from "@/stores";
import MenuButton from "@/components/buttons/MenuButton.vue";
import NotificationButton from "@/components/buttons/NotificationButton.vue";
import {useAuthStore} from "@/stores/store-auth.js";

</script>

<style scoped>

</style>