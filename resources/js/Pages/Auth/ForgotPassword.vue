<script setup>
import { Head, useForm } from '@inertiajs/vue3';
import AuthenticationCard from '@/Components/AuthenticationCard.vue';
import AuthenticationCardLogo from '@/Components/AuthenticationCardLogo.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import {NFormItem, NInput, NButton} from "naive-ui";

defineProps({
    status: String,
});

const form = useForm({
    email: '',
});

const submit = () => {
    form.post(route('password.email'));
};
</script>

<template>
    <Head title="Forgot Password" />

    <AuthenticationCard>
        <template #logo>
            <AuthenticationCardLogo />
        </template>

        <div class="mb-4 text-sm text-gray-600">
            Forgot your password? No problem. Just let us know your email address and we will email you a password reset link that will allow you to choose a new one.
        </div>

        <div v-if="status" class="mb-4 font-medium text-sm text-green-600">
            {{ status }}
        </div>

        <form @submit.prevent="submit">
            <NFormItem label="Email" path="email">
                <NInput
                    id="email"
                    v-model:value="form.email"
                    required
                    autofocus
                    autocomplete="username"
                    @keyup.enter="submit"
                />
                <template>
                    <div v-if="form.errors.email" class="mt-2 text-sm text-red-600">{{ form.errors.email }}</div>
                </template>
            </NFormItem>

            <div class="flex items-center justify-end mt-4">
                <NButton ghost type="info" :class="{ 'opacity-25': form.processing }" :disabled="form.processing" :loading="form.processing" @click.prevent="submit">
                    Email Password Reset Link
                </NButton>
            </div>
        </form>
    </AuthenticationCard>
</template>
