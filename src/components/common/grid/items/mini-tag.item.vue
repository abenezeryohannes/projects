<template>
  <section>
    <div
      :class="[
        { 'cursor-pointer': clickable },
        {
          'bg-accent-light dark:bg-accent-dark text-white ':
            route.params.id == data?.id,
        },
        {
          'hover:bg-accent-light dark:bg-accentlight-dark bg-background-light dark:hover:bg-accent-dark hover:text-white':
            route.params.id != data?.id,
        },
      ]"
      @click="onClick"
      class="relative py-5 px-5 flex mx-2 mb-1 rounded-2xl shadow"
    >
      <!-- <div
          class="static col-span-6 bg-background-lightish dark:bg-background-darkish"
        >
          <web-image
            class="w-full h-44"
            rounded="rounded-lg"
            :width="2999"
            :link="data.banner"
            :padding="0"
          />
        </div> -->
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
      <div class="relative col-span-10 font-semibold pr-3 text-left capitalize">
        <div class="flex gap-x-1" v-if="data == null">
          <v-icon
            cls="dark:text-gray-200 p-0 mr-2"
            :size="7"
            fill="text-gray-600"
            icon="add"
          />
          <p class="mb-1 mt-1 truncate mr-10">Add New</p>
        </div>
        <div class="flex justify-evenly" v-else>
          <p class="mb-1 mt-1 font-medium truncate mr-10">
            {{ data.name }}
          </p>
          <p class="mb-1 mt-1 truncate mr-10">
            {{ data.training }}
          </p>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
// import webImage from "../../../common/web-image.vue";
import { ref, watch } from "vue";
// import errorHandlerUtil from "../../../../data/util/error.handler.util";
import CheckboxForm from "../../../forms/checkbox.form.vue";
// import { fM } from "../../../../util";
import vIcon from "../../../icons/v-icon.vue";
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
