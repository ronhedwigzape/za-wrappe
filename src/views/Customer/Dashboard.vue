<template>
    <v-main>
        <Hero v-if="!initialized && !order && !success"/>
        <router-view/>
    </v-main>
</template>

<script setup>
import {ref, watch} from 'vue';
import Hero from "@/components/hero/ZaWrappeHero.vue";
import {useRouter} from "vue-router";

const initialized = ref(false);
const order = ref(false);
const success = ref(false);
const router = useRouter();

watch(() => router.currentRoute.value.name, (newRoute) => {
    initialized.value = newRoute === 'initialize';
    order.value = newRoute === 'order'
    success.value = newRoute === 'order-success'
});
</script>
