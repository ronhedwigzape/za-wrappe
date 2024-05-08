import { createRouter, createWebHistory } from 'vue-router';
import { useAuthStore } from '@/stores/store-auth';

const routes = [
  {
    path: '/',
    name: 'welcome',
    component: () => import('../views/Welcome.vue'),
  },
  {
    path: '/admin',
    name: 'admin',
    component: () => import('@/views/Admin/Dashboard.vue'),
    children: [
      {
        path: 'products',
        name: 'products',
        component: () => import('@/views/Admin/Products.vue'),
      },
      {
        path: 'inventory',
        name: 'inventory',
        component: () => import('@/views/Admin/Inventory.vue'),
      },
      {
        path: 'users',
        name: 'users',
        component: () => import('@/views/Admin/Users.vue'),
      }
    ]
  },
  {
    path: '/customer',
    name: 'customer',
    component: () => import('@/views/Customer/Dashboard.vue'),
    children: [
      {
        path: 'initialize',
        name: 'initialize',
        component: () => import('@/views/Customer/Order/Initialize.vue'),
      },
      {
        path: 'order',
        name: 'order',
        component: () => import('@/views/Customer/Order/Create.vue'),
      },
      {
        path: 'order-success',
        name: 'order-success',
        component: () => import('@/views/Customer/Order/Success.vue'),
      }
    ]
  },
  {
    path: '/merchant',
    name: 'merchant',
    component: () => import('@/views/Merchant/Dashboard.vue'), // realtime order monitoring
    children: [
      {
        path: 'reports',
        name: 'reports',
        component: () => import('@/views/Merchant/Reports.vue'),
      },
      {
        path: 'notifications',
        name: 'notifications',
        component: () => import('@/views/Merchant/Notifications.vue'),
      },
    ]
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
    if (to.matched.some(record => record.name === user.userType || record.name.startsWith(user.userType + '-'))) {
      next();
      console.log("User type:", user.userType, "Navigating to:", to.name);
    } else {
      console.log("User type:", user.userType, "Navigating to:", to.name);
      next({ name: user.userType });
    }
  }
});

export default router;
