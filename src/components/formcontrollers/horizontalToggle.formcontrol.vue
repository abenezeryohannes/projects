<template>
  <section>
    <div :class="[
      { ' ': direction == 'vertical' },
      { 'flex': direction != 'vertical' },
      { 'flex-none': error == null }
    ]">
      <label v-if="label != null" class="capitalize"
        :class="[{ 'my-auto': error == null }, 'w-' + (gap == null ? 44 : gap), label_cls]">
        {{ t(label.toLowerCase()) }} {{ direction != 'vertical' ? ':' : '' }} </label>

      <div class="w-full ">
        <toggle-form @on-change="emit('on-change', $event)" :editing="editing" :negative="negative" :positive="positive"
          :toggle="value" :width="width" :height="height" :class="[value_cls]" />
      </div>
    </div>
    <div v-if="def != null" class="w-full text-ty text-gray-500 ml-10 mt-3" :class="[{ ' opacity-30': !value }]">
      <p> {{ t(def) }}</p>
    </div>
  </section>
</template>

<script setup lang="ts">

import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import errorHandlerUtil from '../../data/util/error.handler.util';
import ToggleForm from '../forms/toggle.form.vue';

const { t } = useI18n();
const error = ref<any>(null);

const props = defineProps<{
  value: boolean,
  def?: string,
  name: string,
  editing: boolean,
  gap?: number,
  errors?: any,
  label?: string,
  negative?: string,
  positive?: string,
  width: number,
  height: number,
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
