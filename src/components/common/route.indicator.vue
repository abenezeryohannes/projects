<template>
  <section class="flex flex-row select-none">
    <div
      v-for="(route, index) in routes"
      :key="route"
      class="my-auto text-gray-400 dark:text-gray-300 text-xs"
    >
      <p v-if="index != 0" class="mx-2 inline font-bold">/</p>
      <p
        :class="[
          { 'cursor-default capitalize': index + 1 == routes.length },
          {
            'cursor-pointer hover:text-primary-light ':
              index + 1 < routes.length,
          },
        ]"
        class="inline font-semibold capitalize"
        @click="clicked(index, route)"
      >
        {{ route }}
      </p>
    </div>
  </section>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { useRoute, useRouter } from "vue-router";

const router = useRouter();

const routes = computed(() => {
  let path = useRoute()
    .fullPath.split("/")
    .filter(function (el) {
      return el != "" && isNaN(Number(el));
    });
  path.unshift("home");
  path = path.map((p) => {
    if (p.includes("?")) return p.split("?")[0];
    return p;
  });
  return path;
});

function clicked(_: number, route: string) {
  // console.log(route, index);
  router.push({ name: route.toLowerCase() });
}
</script>

<style></style>
