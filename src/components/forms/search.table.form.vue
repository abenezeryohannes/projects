<template>
  <section>
    <div class="pb-5 grid grid-cols-12 gap-x-3 justify-self-auto">
      <search-form
        class="col-span-9"
        @on-change="emit('on-change', $event)"
        :value="null"
        :placeholder="placeholder"
      />

      <div class="col-span-3 flex flex-row justify-between">
        <div class="flex">
          <p
            v-show="view_counter != false"
            class="invisible lg:visible my-auto text-xs font-semibold"
          >
            {{ from() + "" + to() + " of " + response.count }}
          </p>

          <div @click="back" class="cursor-pointer my-auto">
            <v-icon
              icon="arrow-left"
              :size="6"
              :padding="0"
              fill="gray-700"
              cls="dark:text-white"
            />
          </div>

          <div @click="next" class="cursor-pointer my-auto">
            <v-icon
              icon="arrow-right"
              :size="6"
              :padding="0"
              fill="gray-700"
              cls="dark:text-white"
            />
          </div>
        </div>

        <div class="flex" v-if="view_controller">
          <div
            class="cursor-pointer my-auto"
            @click="emit('on-view-change', 'grid')"
          >
            <v-icon
              class="my-auto"
              icon="grid"
              :size="5"
              :padding="0"
              fill="gray-700"
              cls="dark:text-white"
            />
          </div>

          <div
            class="cursor-pointer my-auto"
            @click="emit('on-view-change', 'table')"
          >
            <v-icon
              class="ml-2 my-auto"
              icon="list"
              :size="5"
              :padding="0"
              fill="gray-700"
              cls="dark:text-white"
            />
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import SearchForm from "../forms/search.form.vue";
import VIcon from "../icons/v-icon.vue";

const props = defineProps<{
  value?: any;
  view_controller?: any;
  view_counter?: boolean;
  view?: string;
  response?: any;
  placeholder?: string;
}>();

const emit = defineEmits<{
  (event: "on-change", props: any): void;
  (event: "on-page-change", props: any): void;
  (event: "on-view-change", props: any): void;
}>();

function from() {
  const x: number = (props.response.page - 1) * props.response.limit;
  return x > 0 ? x : 1;
}

function to() {
  const x = props.response.page * props.response.limit;
  return x < props.response.count ? x : props.response.count;
}

function next() {
  if (props.response.page < props.response.total_pages)
    emit("on-page-change", props.response.page + 1);
}

function back() {
  if (props.response.page > 1) emit("on-page-change", props.response.page - 1);
}
</script>

<style></style>
