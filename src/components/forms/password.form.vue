<template>
  <section class="">
                <div v-if="editing" class="my-auto">
                    <div class="relative"> 
                            <input :type="showPassword ? 'text' : 'password'" :name="name" class="my-2 focus:outline-none 
                    block w-full px-2 text-md py-2 shadow-lg rounded-lg dark:bg-background-darkish" 
                    @input="emit('on-change', ($event.target as HTMLInputElement).value)"
                    :placeholder="placeholder" :value="value">
                            <div @click="showPassword = !showPassword" class="absolute cursor-pointer inset-y-0 right-0 pr-3 mt-1 flex items-center text-sm leading-5">
                                <v-icon v-show="showPassword"  icon="eye-open" fill="grey-500" :size="4"/>
                                <v-icon v-show="!showPassword"  icon="eye-closed" fill="grey-500" :size="4"/>
                            </div>
                    </div>
                      <div v-if="error!=null" class="mb-3">
                        <p  class="mt-2 col-start-2 text-red-600 text-xs"> {{error}}</p>
                      </div>
                </div>
                <p v-else class="my-auto" :name="name"> {{value}}</p>
  </section>
</template>

<script setup lang="ts">
 
import { watch, ref } from 'vue';
// import { fM } from '../../util';
import errorHandlerUtil from '../../data/util/error.handler.util'

const props = defineProps<{
  value?: string, type?: string, error?: any, cls?: any, errors?: any[], name?: string, editing: boolean, placeholder?: string
}>();

const emit = defineEmits<{
  (event: 'on-change', param: string): void
}>();

const showPassword= ref<any>('password');
const errorserror = ref<any>(null);

watch(() => props.errors, (val, _) => errorserror.value = (props.name!=null)?errorHandlerUtil.parse(val, props.name):null);

</script>

<style>

</style>

<style>

</style>