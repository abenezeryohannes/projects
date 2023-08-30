<template>
  <section>
    <div class="flex " :class="{ 'mb-5': error == null }">

      <label v-if="label != null" :for="name" class="capitalize w-44 my-auto"> {{ t(label.toLowerCase()) }}: </label>

      <memo-form class="w-full" :memos="memos" :item_padding='item_padding' :item_width='item_width'
        :item_height='item_height' @on-change="emit('on-change', $event)" :editing="editing" />

    </div>
  </section>
</template>

<script setup lang="ts">
import memoForm from '../forms/memo.form.vue';
import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import errorHandlerUtil from '../../data/util/error.handler.util';

const { t } = useI18n();
const error = ref<any>(null);

const props = defineProps<{
  memos: any[],
  item_padding?: number,
  item_width: number,
  name: string,
  item_height?: number,
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