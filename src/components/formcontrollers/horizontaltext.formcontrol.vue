<template>
  <section>
      <div :class="[{' ': direction==='vertical'}, {'flex':  direction!=='vertical'}, {'flex-none': error==null}]" >
          <label v-if="label!=null" class="capitalize" :class="[{'my-auto':error == null}, 'w-'+(gap==null?44:gap), label_cls]">
            <span v-if="required" class="text-red-500 text-lg">*</span>
            {{ t(label.toLowerCase()) }} {{ direction !== 'vertical' ? ':' : '' }} </label>

            <text-form class="w-full" @on-change="emit('on-change', $event)" :placeholder="placeholder"
                :value="value" :error="error" :name="name" :editing="editing" :class="[value_cls]" />
                
      </div>
        <div v-if="def!=null&&editing" class="flex mt-3 gap-x-2">
              <v-icon icon="info" cls="dark:text-gray-400" fill="gray-300" :size=4 />
              <p class="my-auto text-gray-400 dark:text-gray-400 text-ty">( {{ t(def) }} )</p>
        </div>
  </section>
</template>

<script setup lang="ts">

import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import errorHandlerUtil from '../../data/util/error.handler.util';
import TextForm from '../forms/text.form.vue';
import VIcon from '../icons/v-icon.vue';

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