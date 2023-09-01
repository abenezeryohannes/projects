<template>
  <div
    id="app"
    class="bg-background-lightish select-none dark:bg-background-dark h-screen w-screen"
  >
    <navbar v-if="user != null">
      <router-view> </router-view>

      <template v-slot:sidebar>
        <router-view name="sidebar"> </router-view>
      </template>
    </navbar>
    <login-page v-else></login-page>
  </div>
</template>

<script setup lang="ts">
import Navbar from "./layouts/navbar.vue";
import LoginPage from "./pages/auth/signin.page.vue";
import ThemeManager from "./data/util/theme.manager.util";
import { computed, onMounted } from "vue";
import { useStore } from "./store";
import { useRouter } from "vue-router";
const store = useStore();
const user = computed(() => store.getters.user);

onMounted(() => {
  ThemeManager.loadTheme(user.value);
  // const router =
  useRouter();
});
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
}
</style>
