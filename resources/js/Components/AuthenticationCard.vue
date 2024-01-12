<template>
    <div class="min-h-screen flex flex-col sm:justify-center items-center pt-6 sm:pt-0 bg-gray-100">
        <div>
            <slot name="logo" />
        </div>

        <NCard class="w-full sm:max-w-md mt-6 px-6 py-4 overflow-hidden sm:rounded-lg">
            <slot />
        </NCard>

        <div class="mt-5">
            <slot name="navigation" />
        </div>
    </div>
</template>

<script setup>
import { NCard } from 'naive-ui';
</script>
