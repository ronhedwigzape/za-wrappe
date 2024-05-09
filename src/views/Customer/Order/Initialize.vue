<template>
    <div class="">
        <ZaWrappeLogo :height="13"/>

        <div v-if="isLoading" class="carousel-shimmer-container">
            <div class="carousel-shimmer-slide" v-for="n in 5" :key="n">
                <div class="shimmer"></div>
            </div>
        </div>

        <Carousel3d v-if="!isLoading" :height="448" :autoplay="true" :autoplay-timeout="3500" :display="5">
            <Slide v-for="(slide, i) in orderStore.combinedFruitSodaTeaAndShawarma" :index="i" style="background-color: #f1eee5; border-radius: 5%">
                <v-img
                    class="tw-flex tw-flex-col tw-items-center tw-justify-center"
                    height="500"
                    :lazy-src="`../img/${slide.image_url}`"
                    :alt="`${slide.image_url}`"
                    :src="`../img/${slide.image_url}`"
                >
                    <template v-slot:placeholder>
                        <div class="d-flex align-center justify-center fill-height">
                            <v-progress-circular
                                color="grey-lighten-4"
                                indeterminate
                            ></v-progress-circular>
                        </div>
                    </template>
                </v-img>
            </Slide>
        </Carousel3d>
        <div class="tw-flex tw-flex-col tw-items-center tw-justify-center tw-space-y-6 tw-mt-12">
            <router-link to="/customer/order">
                <v-btn size="x-large" class="tw-font-semibold !tw-text-white !tw-bg-neutral-900 tw-w-48" @click="startOrder">Start Order</v-btn>
            </router-link>
            <router-link to="/customer">
                <v-btn size="large" class="tw-font-semibold !tw-text-white !tw-bg-neutral-900 tw-w-48" @click="exit">Exit</v-btn>
            </router-link>
        </div>
    </div>
</template>

<script setup>
import {onMounted, ref} from 'vue';
import { Carousel3d, Slide } from 'vue3-carousel-3d';
import {useOrderStore} from "@/stores/store-order.js";
import ZaWrappeLogo from "@/components/logo/ZaWrappeLogo.vue";
import {useStore} from "@/stores/index.js";

const orderStore = useOrderStore();
const menuVisible = ref(false);
const helpVisible = ref(false);
const isLoading = ref(true);

const startOrder = () => {
    menuVisible.value = false;
    helpVisible.value = false;
};

const exit = () => {
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

