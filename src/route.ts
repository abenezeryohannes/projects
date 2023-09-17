import { RouteRecordRaw, createRouter, createWebHistory } from "vue-router";
import "vue-router";
//user module
const routes: Array<RouteRecordRaw> = [
  {
    path: "/",
    name: "home",
    components: {
      default: () => import("./pages/dashboard.page.vue"),
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
    path: "/tag-identifiers",
    name: "tag-identifiers",
    components: {
      default: () => import("./pages/tags.identifiers.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/tag-identifiers",
    name: "tag-identifiers-detail",
    components: {
      default: () => import("./pages/tags.identifiers.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/tag-identifiers/:id",
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
  {
    path: "/chat-trainer",
    name: "chat-trainer",
    components: {
      default: () => import("./pages/chat.trainer.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/suggestions",
    name: "suggestions",
    components: {
      default: () => import("./pages/suggestions.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/chat_documents",
    name: "chat_documents",
    components: {
      default: () => import("./pages/chat.documents.page.vue"),
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
    path: "/users",
    name: "users",
    components: {
      default: () => import("./pages/users.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/chats",
    name: "chats",
    components: {
      default: () => import("./pages/chats.page.vue"),
      sidebar: () => import("./layouts/home.sidebar.vue"),
    },
  },
  {
    path: "/notifications",
    name: "notifications",
    components: {
      default: () => import("./pages/notifications.page.vue"),
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
