<template>
  <section>
    <div
      :class="[
        {
          'hover:bg-accent-light dark:bg-accentlight-dark bg-background-light dark:hover:bg-accent-dark hover:text-white': true,
        },
      ]"
      @click="onClick"
      class="relative py-5 px-5 mx-1 my-1 flex rounded-2xl shadow-md"
    >
      <div
        v-if="hasCol('#actions#') && data != null"
        class="absolute top-2 right-0 z-10"
      >
        <checkbox-form
          :value="checked"
          @on-change="
            checked = $event;
            $emit('on-select', { check: checked, index: index });
          "
          :editing="true"
        />
      </div>
      <div
        class="relative col-span-10 font-semibold pr-10 pt-2 text-left capitalize"
      >
        <p class="mb-1 mt-1 mr-5">
          {{ data.utterance }}
        </p>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { ref, watch } from "vue";
import CheckboxForm from "../../../forms/checkbox.form.vue";
import { useRoute } from "vue-router";
const props = defineProps<{
  index: any;
  data: any;
  headers: any[];
  clickable?: boolean;
  checkAll?: boolean;
  unCheckAll: boolean;
  error?: any;
}>();

const emit = defineEmits<{
  (event: "bulk-action", param: any): void;
  (event: "on-action", param: any): void;
  (event: "on-select", param: any): void;
  (event: "on-sort-change", param: any): void;
  (event: "on-item-click", param: any): void;
  (event: "on-page-change", param: any): void;
  (event: "on-limit-change", param: any): void;
}>();

const route = useRoute();
const temp_data = ref<any>({});
const editing = ref<boolean>(false);
const checked = ref<boolean>(false);
watch(
  () => props.error,
  (newVal, __) => {
    temp_data.value = JSON.parse(JSON.stringify(newVal.body));
    // console.log('from row', e)
  }
);

watch(
  () => editing,
  (_, __) => {
    // console.log(newVal);
  }
);

watch(
  () => route.query,
  (_, __) => {
    console.log("new route", route.query.intent, props.data);
  }
);

watch(
  () => props.unCheckAll,
  (newVal, __) => {
    console.log("uncheckall", newVal);
    if (newVal == true) checked.value = false;
  }
);

watch(
  () => props.checkAll,
  (newVal, __) => {
    checked.value = newVal || false;
  }
);

watch(
  () => temp_data,
  (newVal, __) => {
    console.log(newVal);
  }
);

function onClick() {
  if (props.clickable)
    emit("on-item-click", { body: props.data, index: props.index });
}
function hasCol(string: string) {
  for (var i = 0; i < props.headers?.length; i++) {
    if (props.headers[i].name == string) return true;
  }
  return false;
}
</script>

<style></style>
