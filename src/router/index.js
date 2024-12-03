import { createRouter, createWebHistory } from 'vue-router'
import pilotes from '../views/pilotes.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: pilotes
    },
    {
      path: '/grandesPremios',
      name: 'grandesPremios',
      component: () => import('../views/grandesPremios.vue')
    },
  ]
})

export default router
