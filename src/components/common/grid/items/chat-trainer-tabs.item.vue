<template>
  <section>
    <div
      :class="[
        { 'cursor-pointer': clickable },
        {
          'bg-accent-light dark:bg-accent-dark text-white ':
            route.query.intent == data?.intent,
        },
        {
          'hover:bg-accent-light dark:bg-accentlight-dark bg-background-light dark:hover:bg-accent-dark hover:text-white':
            route.query.intent != data?.intent,
        },
      ]"
      @click="onClick"
      class="relative py-5 px-5 ml-1 mr-1 flex rounded-2xl shadow-md"
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
        <p v-else class="mb-1 mt-1 truncate mr-10">
          {{ data.intent }}
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
    emit("on-item-click", { body: props.data, index: props.index - 1 });
}
function hasCol(string: string) {
  for (var i = 0; i < props.headers?.length; i++) {
    if (props.headers[i].name == string) return true;
  }
  return false;
}

// function getActions() {
//   for (var i = 0; i < props.headers.length; i++) {
//     if (props.headers[i].name == "#actions#") return props.headers[i].actions;
//   }
//   return ["edit"];
// }

// function parseError(key: any) {
//   return props.error != null
//     ? errorHandlerUtil.parse(props.error.errors, key)
//     : null;
// }

// function value(data: any, header: any) {
//   var x = null;
//   if (props.error != null && props.error.body != null) {
//     x = props.error.body[header.name];
//   } else if (editing.value) {
//     x = temp_data.value[header.name];
//   } else x = data[header.name];
//   return x;
// }

// function update(key: string, value: any) {
//   // console.log(key, value);
//   temp_data.value[key] = value;
//   //  console.log(temp_data.value);
// }

// function refresh() {
//   editing.value = false;
//   temp_data.value = {};
// }

// function onActionClick(data: any, action: string) {
//   if (action == "edit") {
//     editing.value = true;
//     if (props.error != null && props.error.body != null) {
//       temp_data.value = JSON.parse(JSON.stringify(props.error));
//     } else temp_data.value = JSON.parse(JSON.stringify(data));
//     // for (const [key, value] of Object.entries(x)) { this.$set(temp_data.value, key, value); }
//   } else if (action == "save") {
//     editing.value = false;
//     emit("on-action", { body: temp_data.value, action: "edit", orginal: data });
//   } else if (action == "cancel") {
//     editing.value = false;
//     emit("on-action", {
//       body: temp_data.value,
//       action: "cancel",
//       orginal: data,
//     });
//   } else if (action == "delete") {
//     emit("on-action", {
//       body: temp_data.value,
//       action: "delete",
//       orginal: data,
//     });
//   }
// }
</script>

<style></style>
