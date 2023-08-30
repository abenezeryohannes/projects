<template>
  <section>
    <div
      v-if="response != null && response.total_pages > 1"
      class="flex"
      :class="[
        { 'justify-end': !limit_controller },
        { 'justify-between': limit_controller },
      ]"
    >
      <div v-if="limit_controller" class="flex">
        <div class="w-16">
          <dropdown-form
            @on-change="emit('on-limit-change', $event.name)"
            :value="response.limit + ''"
            :placeholder="response.limit + ''"
            :height="8"
            :editing="true"
            :options="[
              { name: '25' },
              { name: '50' },
              { name: '100' },
              { name: '200' },
              { name: '400' },
              { name: '500' },
            ]"
          />
        </div>
        <p class="ml-2 mr-3 mt-1.5">per page.</p>

        <p class="mt-1.5">
          {{ from() }} - {{ to() }} of {{ response.count }} records.
        </p>
      </div>

      <div class="flex flex-row justify-end text-xs font-bold">
        <div
          @click="back"
          class="rounded-full shadow dark:bg-background-darkish bg-white flex h-7 w-7 mr-2 cursor-pointer"
          :class="[
            'text-gray-700 dark:text-white',
            'hover:text-primary-light',
            'dark:hover:text-primary-dark',
          ]"
        >
          <v-icon
            class="mx-auto my-auto"
            icon="arrow-left"
            :size="4"
            :padding="0"
            fill="gray-700"
            cls="dark:text-white"
          />
        </div>

        <div v-if="left_start < left_end" class="flex flex-row">
          <div class="mr-2" v-for="i in left_end - left_start" :key="i">
            <div
              @click="emit('on-change', i + left_start - 1)"
              class="flex rounded-full h-7 w-7 shadow cursor-pointer"
              :class="[
                {
                  'bg-white dark:bg-background-darkish':
                    response.page != i + left_start - 1,
                },
                {
                  'bg-primary-light text-white dark:bg-primary-dark':
                    response.page == i + left_start - 1,
                },
                'hover:bg-primary-light',
                'hover:text-white',
                'dark:hover:bg-primary-dark',
              ]"
            >
              <p class="my-auto mx-auto">{{ i + left_start - 1 }}</p>
            </div>
          </div>
        </div>

        <div
          v-if="
            middle_start < middle_end ||
            (left_end < right_start && right_start < right_end)
          "
        >
          <div
            class="flex rounded-full h-7 w-7 shadow mr-2"
            :class="[
              'bg-white dark:bg-background-darkish',
              'hover:bg-primary-light',
              'hover:text-white',
              'dark:hover:bg-primary-dark',
            ]"
          >
            <p class="my-auto mx-auto text-md">...</p>
          </div>
        </div>

        <div v-if="middle_start < middle_end" class="flex flex-row">
          <div class="mr-2" v-for="i in middle_end - middle_start" :key="i">
            <div
              @click="emit('on-change', i + middle_start - 1)"
              class="flex rounded-full h-7 w-7 shadow cursor-pointer"
              :class="[
                {
                  'bg-white dark:bg-background-darkish':
                    response.page != i + middle_start - 1,
                },
                {
                  'bg-primary-light text-white dark:bg-primary-dark':
                    response.page == i + middle_start - 1,
                },
                'hover:bg-primary-light',
                'hover:text-white',
                'dark:hover:bg-primary-dark',
              ]"
            >
              <p class="my-auto mx-auto">{{ i + middle_start - 1 }}</p>
            </div>
          </div>
        </div>

        <div v-if="middle_start < middle_end">
          <div
            class="flex rounded-full h-7 w-7 shadow mr-2"
            :class="[
              'bg-white dark:bg-background-darkish',
              'hover:bg-primary-light',
              'hover:text-white',
              'dark:hover:bg-primary-dark',
            ]"
          >
            <p class="my-auto mx-auto text-md">...</p>
          </div>
        </div>

        <div v-if="right_start < right_end" class="flex flex-row">
          <div class="mr-2" v-for="i in right_end - right_start" :key="i">
            <div
              @click="emit('on-change', i + right_start - 1)"
              class="rounded-full flex h-7 w-7 shadow cursor-pointer"
              :class="[
                {
                  'bg-white dark:bg-background-darkish':
                    response.page != i + right_start - 1,
                },
                {
                  'bg-primary-light text-white dark:bg-primary-dark':
                    response.page == i + right_start - 1,
                },
                'hover:bg-primary-light',
                'hover:text-white',
                'dark:hover:bg-primary-dark',
                {
                  'bg-primary-light text-white dark:bg-primary-dark':
                    response.page == i + right_start - 1,
                },
              ]"
            >
              <p class="mx-auto my-auto">{{ i + right_start - 1 }}</p>
            </div>
          </div>
        </div>

        <div
          @click="next"
          class="rounded-full shadow dark:bg-background-darkish bg-white flex h-7 w-7 mr-2 cursor-pointer"
          :class="[
            'text-gray-700 dark:text-white',
            'hover:text-primary-light',
            'dark:hover:text-primary-dark',
          ]"
        >
          <v-icon
            class="mx-auto my-auto"
            icon="arrow-right"
            :size="4"
            :padding="0"
            fill="gray-700"
            cls="dark:text-white"
          />
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { ref, watch } from "vue";
import DropdownForm from "../forms/dropdown.form.vue";
import VIcon from "../icons/v-icon.vue";

const props = withDefaults(
  defineProps<{
    response: any;
    limit_controller?: boolean;
    left_breaker?: number;
    right_breaker?: number;
    min_left_count?: number;
    min_right_count?: number;
  }>(),
  {
    response: () => {
      return { total_pages: 0, page: 0 };
    },
    limit_controller: false,
    left_breaker: 4,
    right_breaker: 4,
    min_left_count: 1,
    min_right_count: 1,
  }
);

let right_start = ref<number>(0);
let left_start = ref<number>(0);
let right_end = ref<number>(0);
let left_end = ref<number>(0);
let middle_start = ref<number>(0);
let middle_end = ref<number>(0);

const emit = defineEmits<{
  (event: "on-change", param: any): void;
  (event: "on-limit-change", param: any): void;
}>();

function update(res: any) {
  console.log(res);
  if (res.page <= props.left_breaker) {
    left_start.value = 1;
    left_end.value =
      props.left_breaker > res.total_pages
        ? res.total_pages + 1
        : props.left_breaker + 1;

    if (res.page == props.left_breaker) left_end.value += 1;

    middle_start.value = 0;
    middle_end.value = 0;

    right_start.value =
      props.left_breaker >= res.total_pages
        ? props.left_breaker + 1
        : res.total_pages - (props.min_right_count - 1);
    right_end.value = res.total_pages + 1;
  } else if (res.page >= res.total_pages - props.right_breaker + 1) {
    left_start.value = 1;
    left_end.value =
      res.total_pages > props.right_breaker ? props.min_left_count + 1 : 1;

    middle_start.value = 0;
    middle_end.value = 0;

    right_start.value = res.total_pages - props.right_breaker + 1;
    if (res.page == res.total_pages - props.right_breaker + 1)
      right_start.value = right_start.value - 1;
    right_end.value = res.total_pages + 1;
  } else {
    left_start.value = 1;
    left_end.value = 2;

    middle_start.value = res.page - props.left_breaker / 2;
    middle_end.value = res.page + props.right_breaker / 2;

    right_start.value = res.total_pages;
    right_end.value = res.total_pages + 1;
  }
}

function back() {
  if (props.response.page > 0) emit("on-change", props.response.page - 1);
}

function next() {
  if (props.response.page < props.response.total_pages)
    emit("on-change", props.response.page + 1);
}

function from() {
  const x = (props.response.page - 1) * props.response.limit;
  return x > 0 ? x : 1;
}

function to() {
  const x = props.response.page * props.response.limit;
  return x < props.response.count ? x : props.response.count;
}

watch(
  () => props.response,
  (res, _) => {
    console.log("response changed");
    update(res);
  }
);
</script>

<style></style>
