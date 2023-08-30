<template>
  <section class=" ">
    <div>
      <div v-if="editing" class="">
        <div class="flex gap-x-5 pt-5">
          <input class=" block w-full  my-auto    rounded-lg cursor-pointer " type="range" :name="name" :value="value"
            @change="emit('on-change', ($event.target as HTMLInputElement).value)" :min="((min != null) ? min : -9999999999)"
            :step="(step == null) ? 1 : step" :max="((max != null) ? max : 9999999999)">
          <p class=" "> {{ value + "%" }} </p>
        </div>

        <div v-if="error != null" class=" mb-3">
          <p class="text-red-600 ml-2"> {{ error }}</p>
        </div>
        <div v-if="parsedError != null" class=" mb-3">
          <p class="text-red-600 ml-2"> {{ parsedError }}</p>
        </div>
      </div>
      <p v-else class="" :name="name"> {{ (type != null && type == 'cash') ? fM(value) : value }}</p>
    </div>

  </section>
</template>

<script setup lang="ts">

import { ref, watch } from 'vue';
import errorHandlerUtil from '../../data/util/error.handler.util'
import { fM } from '../../util';
const props = defineProps<{
  value: any,
  type: string,
  min: number,
  max: number,
  error: any,
  step?: any,
  errors?: any[],
  name: string,
  editing: boolean,
}>();

const emit = defineEmits<{
  (event: 'on-change', param: string): void
}>();

const parsedError = ref<any>(null);

watch(() =>
  props.errors, (err, xx) => {
    if (Array.isArray(err)) {
      parsedError.value = errorHandlerUtil.parse(err, props.name);
    } else {
      parsedError.value = null;
    }
  }
);

</script>

<style>

</style>