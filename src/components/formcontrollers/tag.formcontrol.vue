<template>
<section class=" ">
  <div :class="[{' ': direction==='vertical'}, {'flex':  direction!=='vertical'}, {'flex-none': error==null}]" >
    <label v-if="label!=null" class="capitalize" :class="[{'my-auto':error == null}, 'w-'+(gap==null?44:gap), label_cls]">
      <span v-if="required" class="text-red-500 text-lg">*</span>
      {{ t(label.toLowerCase()) }} {{ direction !== 'vertical' ? ':' : '' }}
    </label>

    <tag-input-form class="w-full" :value="value" :editing="editing" :errors="errors" :placeholder="placeholder"
          :link="link" :drop_on_focus="drop_on_focus" :options="options" :property="property" :deletable="deletable"
          @on-add="emit('on-add', $event)" @on-delete="emit('on-delete', $event)" :custom_value="custom_value"
          @on-select="emit('on-select', $event)" :max="max" :min="min" :can_add="can_add"/>

    </div>
    <div v-if="def!=null&&editing" class="flex mt-3 gap-x-2">
      <v-icon icon="info" cls="dark:text-gray-400" fill="gray-300" :size=4 />
      <p class="my-auto text-gray-400 dark:text-gray-400 text-ty">( {{  t(def) }} )</p>
  </div>
</section>
</template>

<script setup lang="ts">

import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import errorHandlerUtil from '../../data/util/error.handler.util';
import TagInputForm from "../forms/tag.input.form.vue";
import VIcon from "../icons/v-icon.vue";

const { t } = useI18n();
const error = ref<any>(null);

const props = defineProps<{
  value: any,
  link?: string,
  deletable?: boolean,
  name: string,
   
  options?: any,
  custom_value?: string,
  property?: string,
  drop_on_focus?: boolean,
  option_name?: string,
  can_add?: boolean,
  text_alignments?: string,
  min?: number,
  max?: number,

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
  (event: 'on-delete', params: any): void
  (event: 'on-add', params: any): void
  (event: 'on-select', params: any): void
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

<style scoped>

</style>