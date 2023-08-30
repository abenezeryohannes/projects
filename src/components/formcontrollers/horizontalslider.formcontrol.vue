<template>
  <section>
      <div class="flex" :class="{'': error==null}">
          <label class=" my-auto capitalize" :class="[{'my-auto':error == null}, 'w-'+(gap==null?44:gap)]"> {{t(label.toLowerCase())}}: </label>

            <slider-form
                :min="min" :max="max" :type="type"
                class="w-full my-auto" @on-change="emit('on-change', $event)"
                :value="value" :error="error" :name="name" :editing="editing" />

      </div>
  </section>
</template>

<script setup lang="ts">

import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import errorHandlerUtil from '../../data/util/error.handler.util';
import SliderForm from '../forms/slider.form.vue';


const { t } = useI18n();
const error = ref<any>(null);

const props = defineProps<{
  value: any,
  min: number,
  max: number,
  type: string,
  name: string,
  step?: string,
  editing: boolean,
  gap?: number,
  errors?: any,
  label: string,
  required: boolean,
  placeholder?: any,
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