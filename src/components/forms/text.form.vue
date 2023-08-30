<template>
  <section>
    <div>
      <div v-if="editing" :class="[cls]">

        <input :type="type == null || type === 'cash' ? 'text' : type" name="field" class="
                          appearance-none border-b-2 border-gray-200 bg-transparent dark:text-white dark:border-gray-500 
                          rounded w-full py-2  text-gray-700 leading-tight focus:outline-none 
                         focus:border-accent-light dark:focus:border-accent-dark
                          font-semibold block pl-1 pr-1  " 
                          @input="emit('on-change', ($event.target as HTMLInputElement).value)"
          autocomplete="off" :placeholder="placeholder" :value="value">


        <div v-if="error != null" class=" ">
          <p class="mt-2 col-start-2 text-red-600 text-xs"> {{ error }}</p>
        </div>
        <div v-if="errorserror != null" class=" ">
          <p class="mt-2 col-start-2 text-red-600 text-xs"> {{ errorserror }}</p>
        </div>
      </div>
      <p v-else class="" :name="name" :class="[cls]"> {{ (type != null && type === 'cash') ? fM(value==null?'':value) : value }}</p>
    </div>

  </section>
</template>

<script setup lang="ts">
 
import { watch, ref } from 'vue';
import { fM } from '../../util';
import errorHandlerUtil from '../../data/util/error.handler.util'

const props = defineProps<{
  value?: string, type?: string, error?: any, cls?: any, errors?: any[], name?: string, editing: boolean, placeholder?: string
}>();

const emit = defineEmits<{
  (event: 'on-change', param: string): void
}>();

const errorserror = ref<any>(null);

watch(() => props.errors, (val, oldVal) => errorserror.value = (props.name!=null)?errorHandlerUtil.parse(val, props.name):null);

</script>

<style>

</style>