<template>
    <v-btn stacked>
        <v-icon>mdi-menu</v-icon>
        <v-menu
            v-model="menuOpen"
            activator="parent"
            :close-on-content-click="false"
        >
            <v-list v-if="useAuthStore().isAuthenticated" width="300" height="190">
                <v-list-item>
                    <span class="tw-flex tw-items-center tw-justify-center">
                        <za-wrappe-logo :height="5" />
                        <v-chip
                            class="me-3"
                            pill
                        >
                            <v-avatar start>
                                <v-img :src="useAuthStore().getUser.avatar"></v-img>
                            </v-avatar>
                            {{ useAuthStore().getUser.name }}
                        </v-chip>
                    </span>
                </v-list-item>
                <v-list-item class="py-2 d-flex justify-center">
                    <SignOut/>
                </v-list-item>
            </v-list>
        </v-menu>
    </v-btn>
</template>
<script setup>
import SignOut from "@/components/dialogs/SignOutDialog.vue";
import {useAuthStore} from "@/stores/store-auth.js";
import ZaWrappeLogo from "@/components/logo/ZaWrappeLogo.vue";
import {ref} from "vue";
import router from "@/router/index.js";

const menuOpen = ref(false);

const navigateToReports = () => {
    menuOpen.value = false; // Close the menu
    router.push('/merchant/reports');
};
</script>
