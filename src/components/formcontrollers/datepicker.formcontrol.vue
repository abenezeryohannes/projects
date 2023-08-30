<template>
  <section>
          <div :class="[{' ': direction=='vertical'}, {'flex':  direction!='vertical'}, {'flex-none': error==null}]" >
          <label v-if="label!=null" class="capitalize" :class="[{'my-auto':error == null}, 'w-'+(gap==null?44:gap), label_cls]"> 
              {{t(label.toLowerCase())}} {{  direction!='vertical'?':':''}} </label>

            <datepicker-form :original="original" :class="[cls, value_cls]" class="w-full" :value="value" :errors="errors" :name="name" 
                    :editing="editing" @on-change="emit('on-change', $event)" />
                    
        </div> 
  </section>
</template>
 
 


<script setup lang="ts">

import DatepickerForm from '../forms/datepicker/datepicker.form.vue';
import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import errorHandlerUtil from '../../data/util/error.handler.util'; 

const { t } = useI18n();
const error = ref<any>(null);

const props = defineProps<{
  value: any,
  rows?: string,
  original?: any,
  name: string,
  cls?: string,
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
</script>

<style>

</style>