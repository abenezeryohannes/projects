<template>
  <section class="w-full pb-20">
    <div class="flex pl-3">
      <tagInputForm
        class=""
        :cls-list="clsList"
        :editing="editing"
        :can_add="editing"
        :deletable="editing"
        :value="utterances"
        @on-change="onChange"
        @on-add="onAdd"
        @on-delete="onDelete"
        :height="200"
      />
    </div>
  </section>
</template>

<script setup lang="ts">
import { ref } from "vue";
import tagInputForm from "../../components/forms/tag.input.form.vue";

const utterances = ref<string[]>([]);

defineProps<{
  editing: boolean;
  loading: boolean;
  errors: any;
  temp_utterance: any;
  clsList?: String | null;
}>();

const emit = defineEmits<{
  (event: "on-change", params: any): void;
  (event: "on-icon-change", params: any): void;
}>();

const onAdd = function (event: any) {
  utterances.value.push(event);
  emit("on-change", utterances.value);
};

const onChange = function (_: any) {
  emit("on-change", utterances.value);
};

const onDelete = function (_: any) {
  utterances.value.pop();
  emit("on-change", utterances.value);
};
</script>
