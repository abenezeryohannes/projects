<template>
  <section>
      <div class="flex" :class="{'': error==null}">
          <label  class="capitalize w-44 my-auto"> {{t(label.toLowerCase())}}: </label>
 
          <multioptionlist-form
          class="w-full"
           @on-change="emit('on-change', $event)"
           :editing="editing" :label="label" :error="error" :showAllList="false" :values="values" 
            :options="options" />
                
      </div>
  </section>
</template>
 
<script setup lang="ts">

import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import errorHandlerUtil from '../../data/util/error.handler.util'; 
import MultioptionlistForm from '../forms/multioptionlist.form.vue';

const { t } = useI18n();
const error = ref<any>(null);
const showOptions = ref<boolean>(false);

const props = defineProps<{
  values: any, 
  showAllList?: boolean, 
  name: string, 
  options?: any,  
  editing: boolean, 
  errors?: any,
  label: string, 
}>();

watch(() => props.errors, (newVal, old) => {
  error.value = errorHandlerUtil.parse(newVal, props.name);
  errorChanged();
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