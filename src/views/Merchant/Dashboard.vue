<template>
    <TopNavbar/>
    <v-main>
        <div v-if="$route.path === '/merchant'">
            hi, this is dashboard for merchants
        </div>
        <router-view v-else/>
    </v-main>
</template>
<script setup>

import TopNavbar from "@/components/navbar/TopNavbar.vue";
</script>
<style scoped>


</style>