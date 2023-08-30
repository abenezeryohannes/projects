<template>
  <section>
            <div class="block my-auto ">
                <div v-if="editing">
                  <input type="text"  name="field" class="
                      appearance-none border-b-2 border-gray-200 bg-transparent dark:text-white dark:border-gray-500 
                      rounded w-full  py-2  text-gray-700 leading-tight focus:outline-none 
                      focus:border-accent-light dark:focus:border-accent-dark
                      font-semibold block pl-1 pr-1
                      " 
                    @input="emit('on-change', ($event.target as HTMLInputElement).value)" 
                    autocomplete="off"
                    :placeholder="placeholder" :value="value">
                     <div v-if="error!=null" class="">
                        <p  class=" text-red-600 text-xs ml-2"> {{error}}</p>
                      </div>
                </div>
                <p v-else class="my-auto" name="field"> {{(type == 'money'&&value!=null)? fM(value): value}}</p>
            </div>
           
 
  </section>
</template>

<script setup lang="ts">
 
import { watch, ref } from 'vue';
import { fM } from '../../util';
import errorHandlerUtil from '../../data/util/error.handler.util'

const props = defineProps<{
  value?: string, type?: string, cls?: any, errors?: any[], name?: string, editing: boolean, placeholder?: string
}>();

const emit = defineEmits<{
  (event: 'on-change', param: string): void
}>();



const error = ref<any>(null);

watch(() => props.errors, (val, oldVal) => error.value = (props.name!=null) ? errorHandlerUtil.parse(val, props.name):null);

</script>

<style>

</style>