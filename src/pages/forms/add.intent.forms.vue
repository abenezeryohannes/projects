<template>
  <section class="text-left font-semibold w-full mb-24 select-none">
    <div class="flex gap-x-4 mt-5">
      <singletext-form
        class="text-lg w-80 font-bold"
        name="name"
        @on-change="emit('on-name-change', $event)"
        :editing="editing"
        placeholder="Name"
        label="name"
        :value="temp_intent.intent"
        :errors="errors"
      />
    </div>

    <p class="font-bold text-lg mt-10 text-accent-light dark:text-accent-dark">
      English
    </p>

    <div
      class="grid gap-x-8"
      :class="[
        { 'grid-cols-2 gap-y-10 gap-x-10 mt-10': editing },
        { 'grid-cols-1  mt-3': !editing },
      ]"
    >
      <div class="">
        <p class="font-bold text-sm mb-3">Add Document</p>
        <tagInputForm
          class=""
          :rows="2"
          :editing="editing"
          :can_add="editing"
          :deletable="editing"
          cls-list="overflow-y-auto  max-h-96"
          :value="englishAddDocumentUtterance"
          @on-change="emit('on-en-doc-change', $event)"
          @on-add="onAddEnglishDoc"
          @on-delete="onDeleteEnglishDoc"
          :height="200"
        />
      </div>

      <div class="">
        <p class="font-bold text-sm mb-3">Write Answer</p>
        <tagInputForm
          class=""
          :rows="2"
          :editing="editing"
          :can_add="editing"
          :deletable="editing"
          :value="englishWriteAnswerUtterance"
          cls-list="overflow-y-auto  max-h-96"
          @on-change="emit('on-en-ans-change', $event)"
          @on-add="onAddEnglishAnswer"
          @on-delete="onDeleteEnglishAnswer"
          :height="200"
        />
      </div>
    </div>
    <p class="font-bold text-lg mt-10 text-accent-light dark:text-accent-dark">
      Arabic
    </p>
    <div
      class="grid gap-x-8"
      :class="[
        { 'grid-cols-2 gap-y-10 gap-x-10 mt-10': editing },
        { 'grid-cols-1  mt-3': !editing },
      ]"
    >
      <div class="">
        <p class="font-bold text-sm mb-3">Add Document</p>
        <tagInputForm
          class=""
          :rows="2"
          :editing="editing"
          :can_add="editing"
          :deletable="editing"
          :value="arabicAddDocumentUtterance"
          cls-list="overflow-y-auto  max-h-96"
          @on-change="emit('on-ar-ans-change', $event)"
          @on-add="onAddArabicDoc"
          @on-delete="onDeleteArabicDoc"
          :height="200"
        />
      </div>

      <div class="">
        <p class="font-bold text-sm mb-3">Write Answer</p>
        <tagInputForm
          class=""
          :rows="2"
          :editing="editing"
          :can_add="editing"
          cls-list="overflow-y-auto  max-h-96"
          :deletable="editing"
          :value="arabicWriteAnswerUtterance"
          @on-change="emit('on-ar-ans-change', $event)"
          @on-add="onAddArabicAnswer"
          @on-delete="onDeleteArabicAnswer"
          :height="200"
        />
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import SingletextForm from "../../components/forms/singletext.form.vue";
import tagInputForm from "../../components/forms/tag.input.form.vue";
// import FormControl from "../../components/formcontrollers/formcontrol.vue";
import { ref } from "vue";

const englishAddDocumentUtterance = ref<String[]>([]);
const englishWriteAnswerUtterance = ref<String[]>([]);

const arabicAddDocumentUtterance = ref<String[]>([]);
const arabicWriteAnswerUtterance = ref<String[]>([]);
//
defineProps<{
  editing: boolean;
  loading: boolean;
  errors: any;
  temp_intent: any;
}>();

const emit = defineEmits<{
  (event: "on-en-doc-change", params: any): void;
  (event: "on-en-ans-change", params: any): void;
  (event: "on-ar-doc-change", params: any): void;
  (event: "on-ar-ans-change", params: any): void;
  (event: "on-name-change", params: any): void;
  (event: "on-icon-change", params: any): void;
}>();

const onAddEnglishDoc = function (event: any) {
  englishAddDocumentUtterance.value.push(event);
  emit("on-en-doc-change", englishAddDocumentUtterance.value);
};

const onDeleteEnglishDoc = function (_: any) {
  englishAddDocumentUtterance.value.pop();
  emit("on-en-doc-change", englishAddDocumentUtterance.value);
};
///
const onAddEnglishAnswer = function (event: any) {
  englishWriteAnswerUtterance.value.push(event);
  emit("on-en-ans-change", englishWriteAnswerUtterance.value);
};

const onDeleteEnglishAnswer = function (_: any) {
  englishWriteAnswerUtterance.value.pop();
  emit("on-en-ans-change", englishWriteAnswerUtterance.value);
};
//
//
//
//
//
const onAddArabicDoc = function (event: any) {
  arabicAddDocumentUtterance.value.push(event);
  emit("on-ar-doc-change", arabicAddDocumentUtterance.value);
};

const onDeleteArabicDoc = function (_: any) {
  arabicAddDocumentUtterance.value.pop();
  emit("on-ar-doc-change", arabicAddDocumentUtterance.value);
};
//
//
//
const onAddArabicAnswer = function (event: any) {
  arabicWriteAnswerUtterance.value.push(event);
  emit("on-ar-ans-change", arabicWriteAnswerUtterance.value);
};

const onDeleteArabicAnswer = function (_: any) {
  arabicWriteAnswerUtterance.value.pop();
  emit("on-ar-ans-change", arabicWriteAnswerUtterance.value);
};
</script>
