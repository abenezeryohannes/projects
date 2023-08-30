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
    path: "/tags/tag-identifiers",
    name: "tag-identifiers",
    components: {
      default: () => import("./pages/tags.identifiers.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/tags/tag-identifiers/:id",
    name: "tag-identifiers-detail",
    components: {
      default: () => import("./pages/tags.identifiers.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/features",
    name: "features",
    components: {
      default: () => import("./pages/features.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
    // beforeEnter: (to, _, next) => {},
  },
  {
    path: "/groups",
    name: "groups",
    components: {
      default: () => import("./pages/courts.group.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
    // beforeEnter: (to, _, next) => {},
  },
  {
    path: "/addresses",
    name: "addresses",
    components: {
      default: () => import("./pages/addresses.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
    // beforeEnter: (to, _, next) => {},
  },
  {
    path: "/posts",
    name: "posts",
    components: {
      default: () => import("./pages/posts.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/types",
    name: "types",
    components: {
      default: () => import("./pages/post.types.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/ads",
    name: "ads",
    components: {
      default: () => import("./pages/ads.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/admins",
    name: "admins",
    components: {
      default: () => import("./pages/admins.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/owners",
    name: "owners",
    components: {
      default: () => import("./pages/owners.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/customers",
    name: "customers",
    components: {
      default: () => import("./pages/customers.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/tags/tag/:id",
    name: "court",
    components: {
      default: () => import("./pages/details/tag.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/orders/order/:id",
    name: "order",
    components: {
      default: () => import("./pages/details/order.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/customers/customer/:id",
    name: "customer",
    components: {
      default: () => import("./pages/details/customer.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/owners/owner/:id",
    name: "owner",
    components: {
      default: () => import("./pages/details/owner.page.vue"),
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
