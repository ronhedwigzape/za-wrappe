import { createRouter, createWebHistory } from 'vue-router';
import { useAuthStore } from '@/stores/store-auth';

const routes = [
  {
    path: '/',
    name: 'welcome',
    component: () => import('../views/Welcome.vue'),
  },
  {
    path: '/Admin',
    name: 'admin',
    component: () => import('@/views/Admin/Dashboard.vue'),
  },
  {
    path: '/Customer',
    name: 'customer',
    component: () => import('@/views/Customer/Dashboard.vue'),
  },
  {
    path: '/Merchant',
    name: 'merchant',
    component: () => import('@/views/Merchant/Dashboard.vue'),
  },
];

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
});

router.beforeEach((to, from, next) => {
  const user = useAuthStore().getUser;

  if (!user) {
    if (to.name !== 'welcome') {
      next({ name: 'welcome' });
    } else {
      next();
    }
  } else {
    if (user.userType !== to.name) {
      next({ name: user.userType });
    } else {
      next();
    }
  }
});

export default router;
