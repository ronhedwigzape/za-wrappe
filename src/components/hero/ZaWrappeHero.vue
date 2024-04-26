<template>
    <div class="tw-backgroundColor tw-min-h-screen">
        <div class="tw-flex tw-flex-col tw-gap-6 tw-md:tw-flex-row">
            <div
                v-for="detail in displayDetails"
                :key="detail.title"
                @click="navigateTo(detail.route)"
                :class="[
                    `tw-relative tw-flex tw-flex-col tw-justify-between tw-rounded-md tw-md:tw-items-center tw-md:tw-basis-1/2 ${detail.backgroundColor}`,
                    { 'tw-flex-col-reverse': reverse },
                ]"
            >
                <div class="tw-image-container tw-flex tw-items-center tw-w-full">
                    <img :src="detail.image" :alt="detail.title" class="tw-full-width-image"/>
                </div>
                <div class="tw-flex tw-flex-col tw-items-center tw-p-4 tw-text-center tw-md:tw-p-10">
                    <p :class="`tw-mb-2 tw-font-bold tw-tracking-widest tw-uppercase tw-typography-headline-6 ${detail.textColor}`">{{ detail.subtitle }}</p>
                    <p :class="`tw-mb-4 tw-font-bold tw-typography-display-2 ${detail.textColor}`">{{ detail.title }}</p>
                    <p :class="`tw-mb-4 tw-typography-text-lg ${detail.textColor}`">{{ detail.description }}</p>
                    <v-btn class="tw-font-semibold !tw-bg-neutral-900 tw-rounded !tw-text-white">
                        {{ detail.callToAction }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { useRouter } from 'vue-router';
import {useStore} from "@/stores/index.js";

const router = useRouter();

const navigateTo = (path) => {
    console.log("Navigating to:", path);
    router.push(path).catch(err => console.error('Router error:', err));
};

const displayDetails = [
    {
        title: 'Za-Wrappe',
        subtitle: 'Happiness in Every Sip and Wrap',
        description: 'Explore our menu, customize your order, and enjoy an innovative dining experience.',
        callToAction: 'Get Started',
        image: `${useStore().assetsUrl}/img/shawarma.jpg`,
        route: '/customer/initialize',
        backgroundColor: 'backgroundColor',
        textColor: 'text-black',
        reverse: false,
    },
];
</script>

<style scoped>
.tw-backgroundColor {
    background-color: #f1eee5;
    background-size: cover;
}

.tw-image-container {
    width: 100%;
    overflow: hidden;
}

.tw-full-width-image {
    width: 100%;
    height: auto;
    object-fit: cover;
}

/* Media query for viewport widths of 765px and above */
@media (min-width: 765px) {
    .tw-image-container {
        height: 100vh;
        width: 100vw;
    }

    .tw-full-width-image {
        height: 100vh;
        min-width: 100%;
        object-fit: cover;
    }
}

</style>
