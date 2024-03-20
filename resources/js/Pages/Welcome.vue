<template>
    <div class="backgroundColor min-h-screen">
        <div class="relative min-h-[600px] ">
            <!-- Background image for za-wrappe -->
            <img
                src="https://storage.googleapis.com/sfui_docs_artifacts_bucket_public/production/hero-bg-mobile.png"
                class="absolute w-full h-full z-[-1] md:object-cover"
                alt="Za-Wrappe background"
            />
            <div class="md:flex md:flex-row-reverse md:justify-center max-w[1536px] mx-auto md:min-h-[600px]">
                <!-- Section for optional promotional or feature image -->
                <div class="flex flex-col md:basis-2/4 md:items-stretch md:overflow-hidden">
                    <!-- Update this image URL to show a feature or promo of Za-Wrappe -->
                    <img
                        src="/lychee.jpg"
                        alt="Za-Wrappe feature"
                        class="h-full object-cover object-left"
                    />
                </div>
                <div class="p-4 md:p-10 md:max-w-[768px] md:flex md:flex-col md:justify-center md:items-start md:basis-2/4">
                    <p class="typography-text-xs md:typography-text-sm font-bold tracking-widest text-neutral-500 uppercase">
                        Welcome to Za-Wrappe
                    </p>
                    <p class="typography-text-base md:typography-text-lg">
                        Explore our menu, customize your order, and enjoy an innovative dining experience.
                    </p>
                    <div class="flex flex-col md:flex-row gap-4 mt-6">
                        <Link :href="route('initialize')">
                            <SfButton size="lg" variant="secondary"> Get Started </SfButton>
                        </Link>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import { SfButton } from '@storefront-ui/vue';
</script>

<style scoped>
.backgroundColor {
    background-color: #f9f25c;
    background-size: cover;
}
</style>


