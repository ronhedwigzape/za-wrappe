import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'
import vuetify from "@/vuetify/vuetify.js";
import Carousel3d from 'vue3-carousel-3d';
import "vue3-carousel-3d/dist/index.css"

import App from './App.vue'
import router from './router'

createApp(App)
    .use(createPinia())
    .use(vuetify)
    .use(Carousel3d)
    .use(router)
    .mount('#app')
