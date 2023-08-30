<template>
  <section>
    <div
      v-if="loading"
      id="loading-screen"
      class="w-full h-full fixed block top-0 left-0 bg-white dark:bg-background-dark opacity-50 z-50"
    >
      <span class="text-green-500 top-1/3 my-0 mx-auto block relative w-0 h-0">
        <div class="custom_loader w-20 h-20" />
      </span>
    </div>
    <div class="flex items-center flex-row">
      <div
        v-if="!editing"
        class="group dark:text-background-white dark:bg-background-darkish bg-white shadow-lg cursor-pointer rounded-full w-14 h-14 p-3"
        :class="[
          {
            'hover:bg-success-light dark:hover:bg-success-dark':
              action == 'save',
          },
          {
            'hover:bg-error-light dark:hover:bg-error-dark': action == 'delete',
          },
          {
            'hover:bg-accent-light dark:hover:bg-accent-dark': action == 'add',
          },
        ]"
        @click="clicked"
      >
        <v-icon
          v-show="!editing && action == 'save'"
          :icon="'save'"
          :size="14 - 2 * 3"
          fill="text-gray-600"
          cls="group-hover:text-white"
        />

        <v-icon
          v-show="editing"
          icon="save"
          :size="14 - 2 * 3"
          fill="text-success-light"
          cls="group-hover:text-white"
        />
        <v-icon
          v-show="!editing && action == 'delete'"
          icon="delete"
          :size="14 - 2 * 3"
          fill="text-success-light"
          cls="group-hover:text-white"
        />
        <v-icon
          v-show="!editing && action == 'add'"
          icon="add"
          :size="14 - 2 * 3"
          fill="text-success-light"
          cls="group-hover:text-white"
        />
      </div>
      <div v-else></div>
    </div>
  </section>
</template>

<script setup lang="ts">
import VIcon from "../icons/v-icon.vue";
defineProps<{
  loading?: boolean;
  action?: string;
  editing?: boolean;
}>();
const emit = defineEmits<{
  (event: "on-action"): void;
}>();

function clicked() {
  emit("on-action");
}
</script>

<style></style>
