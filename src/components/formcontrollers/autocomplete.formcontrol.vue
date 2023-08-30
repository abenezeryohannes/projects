<template>
  <section>
      <div :class="[{' ': direction=='vertical'}, {'flex':  direction!='vertical'}, {'flex-none': error==null}]" >
          <label v-if="label!=null" class="capitalize" :class="[{'my-auto':error == null}, 'w-'+(gap==null?44:gap), label_cls]">
              {{t(label.toLowerCase())}} {{  direction!='vertical'?':':''}} </label>

            <autocomplete-form :can_add="can_add" :editing="editing"
                class="w-full" :errors="errors" :height="height" @on-add="emit('on-add')"
                :name="name" @on-change="emit('on-change', $event)" :class="[value_cls]"
                :value="value" :link="link" :option_name="option_name" />
       </div>
    </section>
</template>



<script setup lang="ts">

import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import errorHandlerUtil from '../../data/util/error.handler.util';
import autocompleteForm from '../forms/autocomplete.form.vue';

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
  height: number,
  saveOnAdd?: boolean,

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
  errorChanged();
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
<style>

</style>