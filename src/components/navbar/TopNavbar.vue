<template>
    <v-app-bar
        color="black"
    >
        <v-app-bar-title :text="useStore().app.title"/>
        <v-spacer/>
        <menu-button/>
    </v-app-bar>
</template>

<script setup>
import {useStore} from "@/stores";
import MenuButton from "@/components/buttons/MenuButton.vue";

</script>

<style scoped>

</style>