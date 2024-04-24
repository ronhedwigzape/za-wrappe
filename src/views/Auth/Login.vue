<script setup>

import {reactive, ref} from "vue";
import {useStore} from "@/stores";
import {useAuthStore} from "@/stores/store-auth";
import {useRouter} from "vue-router";
import $ from 'jquery';

// data
const dialog = ref(false);
const isPasswordShown = ref(false);
const loading = ref(false);
const username = ref('');
const password = ref('');

// store
const store = useStore();
const authStore = useAuthStore();

// router
const router = useRouter();

const rules = reactive({
    required: value => !!value || 'Login credential is required.',
});

const handleSubmit = async () => {
    loading.value = true;
    await $.ajax({
        url: `${store.appURL}/index.php`,
        type: 'POST',
        xhrFields: {
            withCredentials: true
        },
        data: {
            username: username.value,
            password: password.value,
        },
        success: (data) => {
            if (loading.value) {
                setTimeout(() => {
                    loading.value = false;
                }, 1000);
            }
            data = JSON.parse(data);
            authStore.setUser(data.user);
            router.replace({name: data.user.userType});
        },
        error: (error) => {
            if (loading.value) {
                setTimeout(() => {
                    loading.value = false;
                    alert(`ERROR ${error.status}: ${error.statusText}`);
                }, 500);
            }
        },
    });
}

</script>

<template>
    <v-row class="d-flex justify-center align-center">
        <v-card class="pa-1" width="500">
            <v-card-title>
                <v-btn
                    variant="text"
                    class="mt-2 float-end rounded"
                    @click="dialog = false"
                >
                    <v-icon>mdi-close</v-icon>
                </v-btn>
                <v-col class="d-flex justify-center flex-column align-center">
                    <p class="text-lg-h2 text-md-h3 text-h4 pally">Welcome Back!</p>
                    <p class="text-subtitle-1 supreme text-grey-lighten-1">Sign in to continue</p>
                </v-col>
            </v-card-title>
            <v-card-text>
                <v-container>
                    <v-form
                        @submit.prevent="handleSubmit"
                    >
                        <v-row>
                            <v-col cols="12" class="pb-0">
                                <v-text-field
                                    label="Username"
                                    variant="outlined"
                                    v-model.trim="username"
                                    prepend-inner-icon="mdi-account-circle"
                                    :rules="[rules.required]"
                                    :density="$vuetify.display.mdAndDown ? 'compact' : 'comfortable'"
                                ></v-text-field>
                            </v-col>
                            <v-col cols="12" class="py-0">
                                <v-text-field
                                    label="Password"
                                    variant="outlined"
                                    v-model.trim="password"
                                    prepend-inner-icon="mdi-lock"
                                    :append-inner-icon="isPasswordShown ? 'mdi-eye' : 'mdi-eye-off'"
                                    :type="isPasswordShown ? 'text' : 'password'"
                                    :rules="[rules.required]"
                                    @click:append-inner="isPasswordShown = !isPasswordShown"
                                    :density="$vuetify.display.mdAndDown ? 'compact' : 'comfortable'"
                                ></v-text-field>
                            </v-col>
                        </v-row>
                        <v-btn
                            color="orange-accent-2 mt-4"
                            variant="tonal"
                            type="submit"
                            :loading="loading"
                            :disabled="loading || !username || username.length === 0 || !password || password.length === 0"
                            block
                        >
                            Sign in
                        </v-btn>
                    </v-form>
                </v-container>
            </v-card-text>
        </v-card>
    </v-row>
</template>

<style scoped>

</style>