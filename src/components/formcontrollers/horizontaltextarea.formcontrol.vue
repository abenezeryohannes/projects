<template>
  <section v-show="value != null || editing">
      <div :class="[{' ': direction==='vertical'}, {'flex':  direction!=='vertical'}, {'flex-none': error==null}]" >
          <label v-if="label!=null" class="capitalize" :class="[{'my-auto':error == null}, 'w-'+(gap==null?44:gap), label_cls]">
            <span v-if="required" class="text-red-500 text-lg">*</span>
            {{ t(label.toLowerCase()) }} {{ direction !== 'vertical' ? ':' : '' }} </label>

          <texarea-form class="w-full" @on-change="emit('on-change', $event)" :placeholder="placeholder"
                :rows="rows" :cols="cols" :value="value" :error="error" :name="name" :class="[value_cls]" :editing="editing" />
                
      </div>
  </section>
</template>


<script setup lang="ts">

import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import errorHandlerUtil from '../../data/util/error.handler.util';
import TexareaForm from '../forms/textarea.form.vue';

const { t } = useI18n();
const error = ref<any>(null);

const props = defineProps<{
  value: any,
  name: string,
  editing: boolean,
  required: boolean,
  width: number,
  
  rows?: string,
  cols?: string,
  gap?: number,
  errors?: any,
  label?: string,
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