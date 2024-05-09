<script setup>
import {reactive, ref} from "vue";
import {useStore} from "@/stores";
import {useAuthStore} from "@/stores/store-auth";
import {useRouter} from "vue-router";
import $ from 'jquery';
import ZaWrappeLogo from "@/components/logo/ZaWrappeLogo.vue";

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
            router.replace({name: data.user.userType });
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
    <v-row class="tw-min-h-screen tw-flex tw-flex-col sm:tw-justify-center tw-items-center tw-pt-6 sm:tw-pt-0 tw-bg-gray-100">
        <ZaWrappeLogo :height="13"/>

        <v-card :elevation="3" class="tw-w-full sm:tw-max-w-md tw-mt-6 tw-px-6 tw-py-4 tw-bg-white tw-overflow-hidden sm:tw-rounded-lg">
            <v-card-text>
                <v-container>
                    <v-form @submit.prevent="handleSubmit">
                        <v-row>
                            <v-col cols="12" class="pb-2">
                                <v-text-field
                                    label="Username"
                                    variant="outlined"
                                    v-model.trim="username"
                                    prepend-inner-icon="mdi-account-circle"
                                    :rules="[rules.required]"
                                    :density="$vuetify.display.mdAndDown ? 'compact' : 'comfortable'"
                                ></v-text-field>
                            </v-col>
                            <v-col cols="12" class="py-2">
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
                        <v-row>
                            <v-col class="tw-flex tw-justify-end" cols="12">
                                <v-btn
                                    class="!tw-bg-gray-800 !tw-text-white"
                                    type="submit"
                                    :loading="loading"
                                    :disabled="loading || !username || username.length === 0 || !password || password.length === 0"
                                >
                                    Log in
                                </v-btn>
                            </v-col>
                        </v-row>
                    </v-form>
                </v-container>
            </v-card-text>
        </v-card>
    </v-row>
</template>

<style scoped>

</style>