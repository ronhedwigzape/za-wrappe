<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import AuthenticationCard from '@/Components/AuthenticationCard.vue';
import AuthenticationCardLogo from '@/Components/AuthenticationCardLogo.vue';
import { NFormItem, NInput, NButton, NCheckbox, NRadio, NRadioGroup } from 'naive-ui';

defineProps({
    canResetPassword: Boolean,
    status: String,
});

const form = useForm({
    name: '',
    email: '',
    user_type: '',
    password: '',
    password_confirmation: '',
    terms: false,
});

const userTypes = ['student', 'officer', 'staff'];

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>
    <Head title="Register" />

    <AuthenticationCard>
        <template #logo>
            <AuthenticationCardLogo />
        </template>

        <form @submit.prevent="submit">
            <NFormItem label="User Type">
                <NRadioGroup v-model:value="form.user_type" name="user_type">
                    <NRadio v-for="type in userTypes" :key="type" :value="type" :label="type" />
                </NRadioGroup>
                <template #feedback>
                    <div v-if="form.errors.user_type" class="mt-2 text-sm text-red-600">{{ form.errors.user_type }}</div>
                </template>
            </NFormItem>

            <NFormItem label="Name">
                <NInput
                    id="name"
                    v-model:value="form.name"
                    type="text"
                    required
                    autofocus
                    autocomplete="name"
                    @keyup.enter="submit"
                />
                <template #feedback>
                    <div v-if="form.errors.name" class="mt-2 text-sm text-red-600">{{ form.errors.name }}</div>
                </template>
            </NFormItem>

            <NFormItem label="Email">
                <NInput
                    id="email"
                    v-model:value="form.email"
                    type="email"
                    required
                    autocomplete="username"
                    @keyup.enter="submit"
                />
                <template #feedback>
                    <div v-if="form.errors.email" class="mt-2 text-sm text-red-600">{{ form.errors.email }}</div>
                </template>
            </NFormItem>

            <NFormItem label="Password" class="mt-4">
                <NInput
                    id="password"
                    v-model:value="form.password"
                    type="password"
                    required
                    autocomplete="new-password"
                    @keyup.enter="submit"
                />
                <template #feedback>
                    <div v-if="form.errors.password" class="mt-2 text-sm text-red-600">{{ form.errors.password }}</div>
                </template>
            </NFormItem>

            <NFormItem label="Confirm Password" class="mt-4">
                <NInput
                    id="password_confirmation"
                    v-model:value="form.password_confirmation"
                    type="password"
                    required
                    autocomplete="new-password"
                    @keyup.enter="submit"
                />
                <template #feedback>
                    <div v-if="form.errors.password_confirmation" class="mt-2 text-sm text-red-600">{{ form.errors.password_confirmation }}</div>
                </template>
            </NFormItem>

            <div v-if="$page.props.jetstream.hasTermsAndPrivacyPolicyFeature" class="mt-4">
                <InputLabel for="terms">
                    <div class="flex items-center">
                        <NCheckbox id="terms" v-model:checked="form.terms" name="terms" required />

                        <div class="ms-2">
                            I agree to the <a target="_blank" :href="route('terms.show')" class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Terms of Service</a> and <a target="_blank" :href="route('policy.show')" class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Privacy Policy</a>
                        </div>
                    </div>
                    <template #feedback>
                        <div v-if="form.errors.terms" class="mt-2 text-sm text-red-600">{{ form.errors.terms }}</div>
                    </template>
                </InputLabel>
            </div>

            <div class="flex items-center justify-end mt-4">
                <Link :href="route('login')" class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                    Already registered?
                </Link>

                <NButton ghost type="success" class="ms-4" :loading="form.processing" :disabled="form.processing" @click="submit">
                    Register
                </NButton>
            </div>
        </form>
    </AuthenticationCard>
</template>
