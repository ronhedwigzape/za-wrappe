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
    <!--   Sample Messenger Chat Box UI-->
    <div class="fixed bottom-8 right-8 flex flex-col items-end">
        <transition name="slide-fade">
            <div v-if="showChat" class="w-72 p-4 bg-white rounded-lg shadow-xl flex flex-col mb-4">
                <div class="flex justify-between items-center border-b pb-3 mb-3">
                    <span class="text-lg font-semibold">Support Chat</span>
                    <button @click="showChat = false" class="focus:outline-none">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" class="h-6 w-6">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>
                <div class="flex-1 overflow-y-auto mb-4 space-y-2">
                    <!-- Dummy chat messages -->
                    <div class="text-sm text-gray-600">Welcome to ACLC Iriga Payments Support!</div>
                    <div class="text-sm text-gray-600">How can we assist you today?</div>
                    <!-- User's message -->
                    <div class="text-sm text-blue-600 self-end">I have a question about admissions.</div>
                    <!-- Support's reply -->
                    <div class="text-sm text-gray-600">Sure, we're here to help! What would you like to know?</div>
                </div>
                <div>
                    <input type="text" placeholder="Type your message..." class="w-full p-2 border rounded-lg focus:outline-none" />
                </div>
            </div>
        </transition>
        <button
            class="bg-blue-500 hover:bg-blue-600 text-white p-2 rounded-full focus:outline-none transition shadow-lg flex items-center justify-center"
            style="width: 50px; height: 50px;"
            @click="showChat = !showChat"
        >
            <Icon class="text-3xl">
                <FacebookMessenger/>
            </Icon>
        </button>
    </div>
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
import {FacebookMessenger} from "@vicons/fa";
import {ref} from "vue";

const showChat = ref(false);
</script>

<style>
/* Add custom transition for the chatbox */
.slide-fade-enter-active, .slide-fade-leave-active {
    transition: all .3s ease;
}
.slide-fade-enter-from, .slide-fade-leave-to {
    transform: translateY(10px);
    opacity: 0;
}
</style>
