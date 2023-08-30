<template>
  <section>
    <div :class="[{ ' ': direction === 'vertical' }, { 'flex': direction !== 'vertical' }, { 'flex-none': error == null }]">
      <label v-if="label != null" class="capitalize"
        :class="[{ 'my-auto': error == null }, 'w-' + (gap == null ? 44 : gap), label_cls]">
        <span v-if="required" class="text-red-500 text-lg">*</span>
        {{ t(label.toLowerCase()) }} {{ direction !== 'vertical' ? ':' : '' }} </label>

      <select-form @on-add="emit('on-add')" class="my-auto w-full" :describe="describe" :class="[value_cls]"
        :description_option_name="description_option_name" @on-change="emit('on-change', $event)" :link=link
        :option_name="option_name" :value="value" :error="error" :height="height == null ? 8 : height" :name="name"
        :can_add="can_add" :editing="editing" :options="options" :placeholder="placeholder" />
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
const showOptions = ref<boolean>(false);

const props = defineProps<{
  value: any,
  link?: string,
  deletable?: boolean,
  name: string,

  options?: any,
  description_option_name?: string,
  describe?: string,
  option_name?: string,
  can_add?: boolean,
  height?: string,

  editing: boolean,
  gap?: number,
  errors?: any,
  label?: string,
  required: boolean,
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
  (event: 'on-add'): void
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

 
