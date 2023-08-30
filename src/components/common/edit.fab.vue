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
    <div class="flex flex-row">
      <div
        class="group hover:bg-accent-light dark:hover:bg-accent-light dark:text-background-white dark:bg-background-darkish bg-white shadow-lg cursor-pointer rounded-full w-14 h-14 p-3"
        @click="clicked"
      >
        <v-icon
          v-show="!editing"
          :icon="'edit'"
          :size="14 - 2 * 3"
          fill="text-gray-600"
          cls="group-hover:text-white "
        />
        <v-icon
          v-show="editing"
          icon="save"
          :size="14 - 2 * 3"
          fill="text-success-light"
          cls="group-hover:text-white"
        />
      </div>
      <div
        v-show="editing"
        class="group ml-5 dark:text-background-white dark:bg-background-darkish hover:bg-cancel-light dark:hover:bg-cancel-light bg-white shadow-lg cursor-pointer rounded-full w-14 h-14 p-3"
        @click="cancel"
      >
        <v-icon
          icon="cancel"
          :size="14 - 2 * 3"
          fill="text-cancel-light"
          cls="group-hover:text-white"
        />
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import VIcon from "../icons/v-icon.vue";

const props = defineProps<{
  loading: any;
  errors: any[];
  editing: any;
}>();

const emit = defineEmits<{
  (event: "save"): void;
  (event: "edit"): void;
  (event: "cancel"): void;
}>();

const save = function () {
  emit("save");
};

const edit = function () {
  emit("edit");
};
const clicked = function () {
  if (props.editing) save();
  else edit();
};
const cancel = function () {
  emit("cancel");
};
</script>

<style></style>
