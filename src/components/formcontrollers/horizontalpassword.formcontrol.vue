<template>
  <section class="">
       <div :class="[{' ': direction==='vertical'}, {'flex': direction==='horizontal'}, {'flex-none': error==null}]" >
          
          <label v-if="label!=null" class="capitalize" :class="[{'my-auto':error == null}, 'w-'+(gap==null?44:gap), label_cls]">
            <span v-if="required" class="text-red-500 text-lg">*</span>
            {{ t(label.toLowerCase()) }} {{ direction === 'horizontal' ? ':' : '' }} </label>

          <password-form class="w-full" 
           @on-change="emit('on-change', $event)" 
           :value="value" :error="error" :editing="editing" :name="name" :placeholder="placeholder"  :class="[value_cls]" />

      </div>
     
  </section>
</template>
 
<script setup lang="ts">

import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import errorHandlerUtil from '../../data/util/error.handler.util';
import passwordForm from "../forms/password.form.vue"

const { t } = useI18n();
const error = ref<any>(null);

const props = defineProps<{
  value: any,
  rows?: string,
  cols?: string,
  name: string,
  def?: string,
  editing: boolean,
  gap?: number,
  errors?: any,
  label?: string,
  required: boolean,
  width: number,
  placeholder?: any,
  direction?: string,
  label_cls?: any,
  value_cls?: any
}>(); 
  
watch(() => props.errors, (newVal, old) => {
  error.value = errorHandlerUtil.parse(newVal, props.name);
});

const emit = defineEmits<{
  (event: 'on-change', params: any): void
}>();

function errorChanged() {
  error.value = null;
  if (error.values != null) {
    error.values.errors.forEach(function (e: any) {
      if (Object.prototype.hasOwnProperty.call(e, props.name)) {
        if (error.value == null)
          error.value = e[props.name];
      }
    });
  }
}
</script>
<style>

</style>