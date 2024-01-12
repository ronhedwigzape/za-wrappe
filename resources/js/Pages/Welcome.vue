<template>
    <Head title="Welcome" />
    <n-layout class="h-screen">
        <n-layout-header class="bg-white shadow">
            <div class="container mx-auto flex justify-between items-center py-4 px-6">
                <div class="flex">
                    <AclcCollegeIrigaLogoLabeled class="h-12" />
                    <ApplicationMark class="h-9" />
                </div>

                <div class="space-x-4">
                    <Link :href="route('login')">
                        <n-button type="info" text class="text-blue-600">Login</n-button>
                    </Link>
                    <Link :href="route('register')">
                        <n-button type="info" class="bg-blue-600">Register</n-button>
                    </Link>
                </div>
            </div>
        </n-layout-header>
        <n-layout-content class="flex flex-col  px-6 py-12">
            <div class="container mx-auto px-4 items-center justify-center">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 items-center">
                    <div class="px-6">
                        <p class="text-2xl lg:text-3xl font-semibold mb-4 md:mb-0 py-5">
                            Streamline your school payments with secure, real-time transactions powered by PayMongo. <Icon><Leaf/></Icon>
                        </p>
                        <n-button type="info" size="large" to="/login" class="text-blue-600 px-8 py-3">
                            Get Started
                        </n-button>
                    </div>
                    <div class="flex justify-center items-center">
                        <Carousel class="w-3/4"/>
                    </div>
                </div>
                <n-divider class="py-10"/>
                <div class="flex flex-col items-center">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8 w-full max-w-4xl">
                        <n-card bordered class="bg-white bg-opacity-20">
                            <div class="flex flex-col items-center p-6">
                                <Icon class="text-4xl mb-4 text-blue-300"><Money16Regular /></Icon>
                                <h2 class="text-xl font-semibold mb-4">Seamless E-Wallet Payments</h2>
                                <p class="text-center">
                                    Conveniently use GCash, PayMaya, and other e-wallets for hassle-free payments.
                                </p>
                            </div>
                        </n-card>
                        <n-card bordered class="bg-white bg-opacity-20">
                            <div class="flex flex-col items-center p-6">
                                <Icon class="text-4xl mb-4 text-blue-300 h-20"><Document16Regular /></Icon>
                                <h2 class="text-xl font-semibold mb-4">Instant Payment Verification</h2>
                                <p class="text-center">
                                    Get real-time confirmation for every payment you make with PayMongo's reliable processing.
                                </p>
                            </div>
                        </n-card>
                        <n-card bordered class="bg-white bg-opacity-20">
                            <div class="flex flex-col items-center p-6">
                                <Icon class="text-4xl mb-4 text-blue-300"><Clock16Regular /></Icon>
                                <h2 class="text-xl font-semibold mb-4">Comprehensive Transaction Records</h2>
                                <p class="text-center">
                                    Access a full history of your payments and download receipts anytime.
                                </p>
                            </div>
                        </n-card>
                        <n-card bordered class="bg-white bg-opacity-20">
                            <div class="flex flex-col items-center p-6">
                                <Icon class="text-4xl mb-4 text-blue-300"><CreditCardPerson20Filled /></Icon>
                                <h2 class="text-xl font-semibold mb-4">Top-Notch Security</h2>
                                <p class="text-center">
                                    Trust in our commitment to your security with encrypted transactions and data protection.
                                </p>
                            </div>
                        </n-card>
                    </div>
                </div>
            </div>
        </n-layout-content>
        <n-layout-footer class="bg-transparent shadow">
            <div class="container mx-auto text-center py-4 px-6">
                <span>© {{ new Date().getFullYear() }} ACLC College of Iriga. All rights reserved.</span>
            </div>
        </n-layout-footer>
    </n-layout>
</template>

<script setup>
import { Head, Link } from '@inertiajs/vue3';
import { NLayout, NLayoutHeader, NLayoutContent, NLayoutFooter, NButton, NCard, NDivider } from 'naive-ui';
import { Icon } from '@vicons/utils';
import { Money16Regular, Document16Regular, CreditCardPerson20Filled, Clock16Regular } from '@vicons/fluent';
import { Leaf } from '@vicons/ionicons5';
import AclcCollegeIrigaLogoLabeled from "@/Components/AclcCollegeIrigaLogoLabeled.vue";
import Carousel from "@/Components/Carousel.vue";
import ApplicationMark from "@/Components/ApplicationMark.vue";
</script>

<style>
/* Additional global styles can be placed here */
</style>
