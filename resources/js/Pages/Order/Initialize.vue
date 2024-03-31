<template>
    <div class="flex flex-col items-center justify-center">
        <img src="/za_wrappe_logo.png" alt="za-wrappe-logo" class="h-40">
    </div>

    <div v-if="isLoading" class="carousel-shimmer-container">
        <div class="carousel-shimmer-slide" v-for="n in 5" :key="n">
            <div class="shimmer"></div>
        </div>
    </div>

    <Carousel3d v-if="!isLoading" :height="448" :autoplay="true" :autoplay-timeout="3500" :display="5">
        <Slide v-for="(slide, i) in orderStore.combinedFruitSodaTeaAndShawarma" :index="i" style="background-color: #f1eee5; border-radius: 5%">
           <img class="flex flex-col items-center justify-center" :src="`/${slide.image_url}`" :alt="`${slide.image_url}`"/>
        </Slide>
    </Carousel3d>
    <div v-if="!menuStore.orderComplete" class="flex flex-col items-center justify-center space-y-6 mt-5">
        <Link :href="route('order')">
            <SfButton size="lg" class="h-20 font-semibold !bg-neutral-900 w-48" @click="startOrder">Start Order</SfButton>
        </Link>
        <Link :href="route('welcome')">
            <SfButton size="lg" class="h-20 font-semibold !bg-neutral-900 w-48" @click="exit">Exit</SfButton>
        </Link>
    </div>
</template>

<script setup>
import { SfButton } from '@storefront-ui/vue';
import {onMounted, ref} from 'vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { useMenuStore } from '@/Store/store-menu.js';
import { Carousel3d, Slide } from 'vue3-carousel-3d';
import {useOrderStore} from "@/Store/store-order.js";

const menuStore = useMenuStore();
const orderStore = useOrderStore();
const menuVisible = ref(false);
const helpVisible = ref(false);
const isLoading = ref(true);

const startOrder = () => {
    menuStore.orderComplete = false;
    menuVisible.value = false;
    helpVisible.value = false;
};

const exit = () => {
    menuStore.$reset();
    orderStore.$reset();
    menuVisible.value = false;
    helpVisible.value = false;
};

const fetchAndCombineFruitSodaTeaAndShawarmaAndCategories = async () => {
    isLoading.value = true;
    await orderStore.fetchCategories();
    await orderStore.fetchAndCombineFruitSodaTeaAndShawarma();
    isLoading.value = false;
}

onMounted(() => {

    fetchAndCombineFruitSodaTeaAndShawarmaAndCategories();
})
</script>

<style scoped>
@keyframes shimmer {
    0% {
        background-position: -1000px 0;
    }
    100% {
        background-position: 1000px 0;
    }
}

.shimmer {
    animation: shimmer 7s infinite linear;
    background: linear-gradient(to right, #f0f0f0 8%, #fdfdfd 18%, #f0f0f0 33%);
    background-size: 200% 100%;
    height: 100%;
    width: 100%;
    position: relative;
}

.carousel-shimmer-container {
    display: flex;
    overflow: hidden;
    width: 100%;
    height: 400px;
}

.carousel-shimmer-slide {
    flex: none;
    width: 20%;
    height: 100%;
    margin-right: 10px;
}
</style>

