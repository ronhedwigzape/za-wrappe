<template>
    <v-app>
        <v-main>
            <!-- loader -->
            <div v-if="loading" class="tw-flex tw-flex-col tw-justify-center tw-items-center" style="height: 100vh;">
                <za-wrappe-logo :height="13"/>
                <div class="loader tw-h-6">
                    <span class="hour"></span>
                    <span class="min"></span>
                    <span class="circle"></span>
                </div>
            </div>
            <router-view v-else />
        </v-main>
    </v-app>
</template>

<script setup>
import {onMounted, ref} from "vue";
import {useStore} from "@/stores";
import {useAuthStore} from "@/stores/store-auth";
import {useRouter} from "vue-router";
import $ from 'jquery';
import ZaWrappeLogo from "@/components/logo/ZaWrappeLogo.vue";

const store = useStore();
const authStore = useAuthStore();
const router = useRouter();

const loading = ref(true);

const getUser = async () => {
    $.ajax({
        url: `${store.appURL}/index.php`,
        type: 'GET',
        xhrFields: {
            withCredentials: true
        },
        data: {
            getUser: ''
        },
        success: (data) => {
            data = JSON.parse(data);
            if (data.user) {
                authStore.setUser(data.user);
                router.replace({
                    name: data.user.userType.toLowerCase()
                });
            }
            loading.value = false;
        },
        error: (error) => {
            alert(`ERROR ${error.status}: ${error.statusText}`);
            loading.value = false;

        },
    });
}

onMounted(() => {
    getUser();
});

</script>
<style scoped>
.loader {
    width: 65px;
    height: 65px;
    border: 8px solid rgba(49, 48, 47, 0.65);
    border-radius: 50px;
    position: relative;
}

.loader span {
    display: block;
    background: #000000;
}

.loader .hour ,
.loader .min {
    width: 6px;
    height: 22px;
    border-radius: 50px;
    position: absolute;
    top: 24.5px;
    left: 21px;
    animation: load9243 1.2s linear infinite;
    transform-origin: top center;
}

.loader .min {
    height: 17px;
    animation: load9243 4s linear infinite;
}

.loader .circle {
    width: 10px;
    height: 10px;
    border-radius: 50px;
    position: absolute;
    top: 19px;
    left: 19px;
}

@keyframes load9243 {
    0% {
        transform: rotate(0deg);
    }

    100% {
        transform: rotate(360deg);
    }
}
</style>
