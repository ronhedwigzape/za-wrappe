<template>
    <div class="backgroundColor min-h-screen">
        <div class="flex flex-col gap-6 md:flex-row">
            <div
                v-for="{ title, subtitle, description, callToAction, image, backgroundColor, reverse, textColor } in displayDetails"
                :key="title"
                :class="[
        `relative flex flex-col justify-between rounded-md md:items-center md:basis-1/2 ${backgroundColor}`,
        { 'flex-col-reverse': reverse },
      ]"
            >
                <div class="image-container flex items-center w-full">
                    <img :src="image" :alt="title" class="full-width-image"/>
                </div>
                <a
                    :class="`absolute w-full h-full z-1 focus-visible:outline focus-visible:rounded-lg`"
                    :aria-label="title"
                    :href="route('initialize')"
                />
                <div class="flex flex-col items-center p-4 text-center md:p-10">
                    <p :class="`mb-2 font-bold tracking-widest uppercase typography-headline-6 ${textColor}`">{{ subtitle }}</p>
                    <p :class="`mb-4 font-bold typography-display-2 ${textColor}`">{{ title }}</p>
                    <p :class="`mb-4 typography-text-lg ${textColor}`">{{ description }}</p>
                    <SfButton class="font-semibold !bg-neutral-900">
                        {{ callToAction }}
                    </SfButton>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import { SfButton } from '@storefront-ui/vue';

const displayDetails = [
    {
        title: 'Za-Wrappe',
        subtitle: 'Happiness in Every Sip and Wrap',
        description: 'Explore our menu, customize your order, and enjoy an innovative dining experience.',
        callToAction: 'Get Started',
        image: '/milktea.jpg',
        backgroundColor: 'backgroundColor',
        textColor: 'text-white',
        reverse: false,
    },
];
</script>

<style scoped>
.backgroundColor {
    background-color: #522100;
    background-size: cover;
}

.image-container {
    width: 100%;
    overflow: hidden;
}

.full-width-image {
    width: 100%;
    height: auto;
    object-fit: cover;
}

/* Media query for viewport widths of 765px and above */
@media (min-width: 765px) {
    .image-container {
        height: 100vh;
        width: 100vw;
    }

    .full-width-image {
        height: 100vh;
        min-width: 100%;
        object-fit: cover;
    }
}

</style>

