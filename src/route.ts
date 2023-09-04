import { RouteRecordRaw, createRouter, createWebHistory } from "vue-router";
import "vue-router";
//user module
const routes: Array<RouteRecordRaw> = [
  {
    path: "/",
    name: "home",
    components: {
      default: () => import("./pages/tags.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/auth",
    name: "auth",
    component: () => import("./pages/auth/signin.page.vue"),
  },
  {
    path: "/orders",
    name: "orders",
    components: {
      default: () => import("./pages/orders.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
    // beforeEnter: (to, _, next) => {},
  },
  {
    path: "/tags",
    name: "tags",
    components: {
      default: () => import("./pages/tags.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
    // beforeEnter: (to, _, next) => {},
  },
  {
    path: "/businesses",
    name: "businesses",
    components: {
      default: () => import("./pages/businesses.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
    // beforeEnter: (to, _, next) => {},
  },
  {
    path: "/tags/tag-identifiers",
    name: "tag-identifiers",
    components: {
      default: () => import("./pages/tags.identifiers.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/tags/tag-identifiers",
    name: "tag-identifiers-detail",
    components: {
      default: () => import("./pages/tags.identifiers.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/tags/tag-identifiers/:id",
    name: "tag-identifiers-detail-id",
    components: {
      default: () => import("./pages/tags.identifiers.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/business/business-tag-trainer",
    name: "business-tag-trainer",
    components: {
      default: () => import("./pages/businesses.tag.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/business/business-tag-trainer/:id",
    name: "business-tag-trainer-id",
    components: {
      default: () => import("./pages/businesses.tag.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
// This can be directly added to any of your `.ts` files like `router.ts`
// It can also be added to a `.d.ts` file, in which case you will need to add an export
// to ensure it is treated as a module

declare module "vue-router" {
  interface RouteMeta {
    // is optional
    // isAdmin?: boolean;
    // must be declared by every route
    // requiresAuth: boolean;
  }
}
