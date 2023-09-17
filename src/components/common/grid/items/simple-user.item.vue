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
      class="relative py-5 mb-1 px-5 ml-3 mr-2 flex rounded-2xl shadow-md"
    >
      <div
        class="static col-span-6 bg-background-lightish dark:bg-background-darkish"
      >
        <web-image
          class="w-full"
          rounded="rounded-lg bg-transparent"
          scale="object-cover"
          :width="2999"
          :link="data.avatar"
          :padding="0"
        />
      </div>
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
        <p class="truncate mr-10 px-3 my-1">
          {{ data.fullName }}
        </p>
        <p class="truncate mr-10 px-3 my-1">
          {{ data.phoneNumber }}
        </p>

        <!-- <div class="absolute bottom-2 right-2 flex">
              <div
                class="font-light capitalize"
                :class="[
                  // { 'bg-warning-light dark:bg-warning-dark rounded-2xl shadow-xl px-2 py-1 ': data.status.includes('issue') },
                  {
                    'text-warning-light justify-centerpx-2 py-1 ':
                      data.status.includes('waiting'),
                  },
                  {
                    'text-error-light justify-centerpx-2 py-1 ':
                      data.status.includes('in-active'),
                  },
                  // { 'bg-gray-700 rounded-2xl shadow-xl px-2 py-1 ': data.enabled  },
                  // { 'bg-gray-700 rounded-2xl shadow-xl px-2 py-1 ': data.status.includes('ended') },
                  {
                    'text-success-light justify-centerpx-3 py-1 ':
                      data.status == 'active',
                  },
                ]"
              >
                <p class="">{{ data.status }}</p>
              </div>
            </div> -->
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import webImage from "../../../common/web-image.vue";
import { ref, watch } from "vue";
// import errorHandlerUtil from "../../../../data/util/error.handler.util";
import CheckboxForm from "../../../forms/checkbox.form.vue";
// import { fM } from "../../../../util";
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
