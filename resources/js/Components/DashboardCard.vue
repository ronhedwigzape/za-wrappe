<script setup>
import AclcLogoBlackFilled from "@/Components/AclcLogoBlackFilled.vue";
import { Icon } from '@vicons/utils';
import { Money16Regular, Document16Regular, CreditCardPerson20Filled, Clock16Regular } from '@vicons/fluent';
import  { User } from '@vicons/fa';
import AclcCollegeIrigaLogoLabeled from "@/Components/AclcCollegeIrigaLogoLabeled.vue";

const props = defineProps({
    student_name: String
});
</script>

<template>
    <div>
        <div class="p-6 lg:p-8 bg-white border-b border-gray-200 flex items-center">
            <AclcLogoBlackFilled class="block h-6 w-auto mr-4" />
            <h1 class="text-xl font-medium ">
                Welcome, {{ student_name }}!
            </h1>
        </div>

        <div class="bg-gray-200 bg-opacity-25 grid grid-cols-1 md:grid-cols-2 gap-6 lg:gap-8 p-6 lg:p-8">
            <!-- Personal Information -->
            <div>
                <div class="flex items-center">
                    <Icon><User /></Icon>
                    <h2 class="ms-3 text-lg font-semibold text-gray-900">Personal Information</h2>
                </div>
                <p class="mt-4 text-gray-500 text-sm leading-relaxed">
                    <!-- Display student's personal information here -->
                </p>
            </div>

            <!-- Tuition and Fees -->
            <div>
                <div class="flex items-center">
                    <Icon><Money16Regular /></Icon>
                    <h2 class="ms-3 text-lg font-semibold text-gray-900">Tuition and Fees</h2>
                </div>
                <p class="mt-4 text-gray-500 text-sm leading-relaxed">
                    <!-- Display tuition and fees details here -->
                </p>
            </div>

            <!-- Payment History -->
            <div>
                <div class="flex items-center">
                    <Icon><Document16Regular /></Icon>
                    <h2 class="ms-3 text-lg font-semibold text-gray-900">Payment History</h2>
                </div>
                <p class="mt-4 text-gray-500 text-sm leading-relaxed">
                    <!-- Display payment history here -->
                </p>
            </div>

            <!-- Outstanding Balances -->
            <div>
                <div class="flex items-center">
                    <Icon><Clock16Regular /></Icon>
                    <h2 class="ms-3 text-lg font-semibold text-gray-900">Outstanding Balances</h2>
                </div>
                <p class="mt-4 text-gray-500 text-sm leading-relaxed">
                    <!-- Display outstanding balances here -->
                </p>
            </div>

            <!-- Payment Methods -->
            <div>
                <div class="flex items-center">
                    <Icon><CreditCardPerson20Filled /></Icon>
                    <h2 class="ms-3 text-lg font-semibold text-gray-900">Payment Methods</h2>
                </div>
                <p class="mt-4 text-gray-500 text-sm leading-relaxed">
                    <!-- Display payment methods here -->
                </p>
            </div>
        </div>
    </div>
</template>
