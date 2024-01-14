<template>
    <n-space :size="24" align="center">
        <n-badge :value="value" :max="15">
            <Icon class="text-2xl"><Bell/></Icon>
        </n-badge>
    </n-space>
</template>

<script setup>
import {  NBadge, NSpace, NAvatar } from "naive-ui";
import { Bell } from "@vicons/tabler";
import { Icon } from '@vicons/utils';
import { ref } from "vue";

const value = ref(5)
</script>
