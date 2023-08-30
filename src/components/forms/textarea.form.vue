<template>
  <section>
    <div>
      <div v-if="editing">
        <textarea
          :type="type == null || type == 'cash' ? 'text' : type"
          name="field"
          class="appearance-none border border-opacity-10 border-gray-200 bg-transparent dark:text-white dark:border-gray-700 rounded w-full py-2 text-gray-700 leading-tight focus:outline-none underline focus:border-accent-light dark:focus:border-accent-dark font-semibold block pl-1 pr-1"
          @input="emit('on-change', ($event.target as HTMLInputElement).value)"
          autocomplete="off"
          :rows="rows"
          :cols="cols"
          :placeholder="placeholder"
          :value="value"
        />
        <div v-if="error != null" class="mb-3">
          <p class="text-red-600 ml-2">{{ error }}</p>
        </div>
        <div v-if="parsedError != null" class="mb-3">
          <p class="text-red-600 ml-2">{{ parsedError }}</p>
        </div>
      </div>
      <p v-else class="break-all" :name="name">
        {{ value != null && type == "cash" ? fM(value) : value }}
      </p>
    </div>
  </section>
</template>

<script setup lang="ts">
import { watch, ref } from "vue";
import { fM } from "../../util";
import errorHandlerUtil from "../../data/util/error.handler.util";

const props = defineProps<{
  value?: string;
  type?: string;
  rows?: string;
  cols?: string;
  error?: any;
  cls?: any;
  errors?: any[];
  name?: string;
  editing: boolean;
  placeholder?: string;
}>();

const emit = defineEmits<{
  (event: "on-change", param: string): void;
}>();

const parsedError = ref<any>(null);

watch(
  () => props.errors,
  (val, _) =>
    (parsedError.value =
      props.name != null ? errorHandlerUtil.parse(val, props.name) : null)
);
</script>

<style></style>
