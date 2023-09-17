<template>
  <section>
    <div class="flex" :class="{ '': error == null }">
      <label
        v-if="label != null"
        class="capitalize"
        :class="[{ 'my-auto': error == null }, 'w-' + (gap == null ? 40 : gap)]"
      >
        {{ t(label.toLowerCase()) }}:
      </label>

      <daterangepicker-form
        :gravity="gravity"
        :class="[cls]"
        class="w-full"
        :min="min"
        :max="max"
        :errors="errors"
        :name="name"
        :editing="editing"
        @on-change="emit('on-change', $event)"
      />
    </div>
  </section>
</template>

<script setup lang="ts">
import DaterangepickerForm from "../forms/datepicker/daterangepicker.form.vue";
import { ref, watch } from "vue";
import { useI18n } from "../../i18n";
import errorHandlerUtil from "../../data/util/error.handler.util";

const { t } = useI18n();
const error = ref<any>(null);

const props = defineProps<{
  gravity: string;
  min?: string;
  max?: any;
  name: string;
  cls?: string;
  editing: boolean;
  gap?: number;
  errors?: any;
  label?: string;
}>();

watch(
  () => props.errors,
  (newVal, _) => {
    error.value = errorHandlerUtil.parse(newVal, props.name);
  }
);

const emit = defineEmits<{
  (event: "on-change", params: any): void;
}>();
</script>

<style></style>
