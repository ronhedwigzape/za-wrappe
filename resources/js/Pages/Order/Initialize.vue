<template>
    <div>
        <div v-if="!menuStore.orderComplete">
            <SfButton @click="displayMenu" class="btn">View Menu</SfButton>
            <Link :href="route('order')">
                <SfButton @click="startOrder">Start Order</SfButton>
            </Link>
            <SfButton @click="displayHelp">Help</SfButton>
            <Link :href="route('welcome')">
                <SfButton @click="exit">Exit</SfButton>
            </Link>
        </div>

        <div v-if="menuVisible">
            <h2>Menu Items</h2>
            <div v-for="item in menuStore.menuItems" :key="item.product_id" class="menu-item">
                <div class="product-name">{{ item.name }}</div>
                <div class="product-price">{{ item.price }}</div>
            </div>
        </div>

        <div v-if="helpVisible">
            <h2>Help Information</h2>
            <p>{{ menuStore.helpInfo }}</p>
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { useMenuStore } from '@/Store/store-menu.js';
import { SfButton } from '@storefront-ui/vue';

const menuStore = useMenuStore();
const menuVisible = ref(false);
const helpVisible = ref(false);

const displayMenu = async () => {
    await menuStore.fetchMenuItems();
    menuVisible.value = true;
    helpVisible.value = false;
};

const startOrder = () => {
    menuStore.orderComplete = false;
    menuVisible.value = false;
    helpVisible.value = false;
};

const displayHelp = async () => {
    await menuStore.fetchHelpInfo();
    helpVisible.value = true;
    menuVisible.value = false;
};

const exit = () => {
    menuStore.$reset();
    menuVisible.value = false;
    helpVisible.value = false;
};
</script>
