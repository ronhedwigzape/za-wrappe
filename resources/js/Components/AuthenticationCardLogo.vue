<script setup>
import { Link } from '@inertiajs/vue3';
</script>

<template>
    <Link :href="'/'">
        <div class="flex flex-col items-center justify-center">
            <img class="rounded-lg" src="/aclc.jpg" alt="" style="height: 70px; width: 70px;">
            <h3 class="mt-2 font-extrabold">Hashi Payments</h3>
        </div>
    </Link>
</template>
