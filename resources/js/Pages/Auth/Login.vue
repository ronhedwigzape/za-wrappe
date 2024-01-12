<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import AuthenticationCard from '@/Components/AuthenticationCard.vue';
import AuthenticationCardLogo from '@/Components/AuthenticationCardLogo.vue';
import { NFormItem, NInput, NButton, NCheckbox } from 'naive-ui';

defineProps({
    canResetPassword: Boolean,
    status: String,
});

const form = useForm({
    email: '',
    password: '',
    remember: false,
});

const submit = () => {
    form.transform(data => ({
        ...data,
        remember: form.remember ? 'on' : '',
    })).post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};
</script>

<template>
    <Head title="Log in" />

    <AuthenticationCard>
        <template #logo>
            <AuthenticationCardLogo />
        </template>

        <div v-if="status" class="mb-4 font-medium text-sm text-green-600 dark:text-green-400">
            {{ status }}
        </div>

        <form @submit.prevent="submit">
            <NFormItem label="Email" path="email">
                <NInput
                    id="email"
                    v-model:value="form.email"
                    type="email"
                    required
                    autofocus
                    autocomplete="username"
                    @keyup.enter="submit"
                />
                <template #feedback>
                    <div v-if="form.errors.email" class="mt-2 text-sm text-red-600">{{ form.errors.email }}</div>
                </template>
            </NFormItem>

            <NFormItem label="Password" path="password" class="mt-4">
                <NInput
                    id="password"
                    v-model:value="form.password"
                    type="password"
                    required
                    autocomplete="current-password"
                    @keyup.enter="submit"
                />
                <template #feedback>
                    <div v-if="form.errors.password" class="mt-2 text-sm text-red-600">{{ form.errors.password }}</div>
                </template>
            </NFormItem>


            <NFormItem class="block mt-4">
                <NCheckbox v-model:checked="form.remember" name="remember" />
                <span class="ms-2 text-sm text-gray-600">Remember me</span>
            </NFormItem>

            <div class="flex items-center justify-end mt-4">
                <Link :href="route('password.request')" class="underline text-sm text-gray-600 dark:text-gray-400 hover:text-gray-700 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 dark:focus:ring-offset-gray-800">
                    Forgot your password?
                </Link>

                <NButton ghost type="success" class="ms-4"  :loading="form.processing" :disabled="form.processing" @click.prevent="submit">
                    Log in
                </NButton>
            </div>
        </form>
        <template #navigation>
            <Link :href="route('register')" class="ms-4 font-semibold text-sm text-gray-500 hover:text-gray-800 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Don't have an account yet? Register here.</Link>
        </template>
    </AuthenticationCard>
</template>
