<template>
  <section>
    <div class="w-full">
      <div class=" " v-for="(body, index) in tableData" :key="index">
        <table-row
          @on-action="
            emit('on-action', {
              index: index,
              body: $event.body,
              item_body: $event.item_body,
              action: $event.action,
              files: $event.files,
              orginal: $event.orginal,
            })
          "
          @on-select="emit('on-select', { index: index, check: $event.check })"
          @on-item-click="emit('on-item-click', $event)"
          :item="item"
          :checkAll="checkAll"
          :clickable="clickable"
          :show_item_on="show_item_on"
          :unCheckAll="unCheckAll"
          :data="body"
          :headers="headers"
          :error="parseError(index)"
          :index="index"
        />
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { ref, watch } from "vue";
import TableRow from "./table.row.vue";

const props = defineProps<{
  tableData: any[];
  headers: any[];
  show_item_on: any;
  item: any;
  checkAll: boolean;
  unCheckAll: boolean;
  errors?: any[];
  clickable?: boolean;
}>();

const temp_tableData = ref<any>({});
const editing = ref<number>(-1);

const emit = defineEmits<{
  (event: "bulk-action", param: any): void;
  (event: "on-action", param: any): void;
  (event: "on-select", param: any): void;
  (event: "on-sort-change", param: any): void;
  (event: "on-item-click", param: any): void;
  (event: "on-page-change", param: any): void;
  (event: "on-limit-change", param: any): void;
}>();

watch(
  () => props.tableData,
  (_, __) => {
    refresh();
  }
);

watch(
  () => editing.value,
  (e, __) => {
    if (e > 0) {
      temp_tableData.value = JSON.parse(JSON.stringify(props.tableData[e]));
    }
  }
);

// watch(() => temp_tableData.value, (newVal, oldVal) =>  { console.log(newVal) });

function parseError(index: number) {
  var error = null;
  props.errors?.forEach((element) => {
    if (element.index == index) error = element;
  });
  return error;
}

// function value(index: number, body: any[], header: any) {
//   return editing.value != index
//     ? body[header.name]
//     : temp_tableData.value[header.name];
// }

// function update(key: string, value: any) {
//   console.log(key, value);
//   temp_tableData.value[key] = value;
//   console.log(temp_tableData.value);
// }

function refresh() {
  editing.value = -1;
  temp_tableData.value = {};
}

// function onActionClick(body: any, action: string, index: number) {
//   if (action == "edit") {
//     editing.value = index;
//     var x = JSON.parse(JSON.stringify(props.tableData[index]));
//     for (const [key, value] of Object.entries(x)) {
//       temp_tableData.value[key] = value;
//     }
//   } else if (action == "save") {
//     editing.value = -1;
//     emit("on-action", {
//       body: temp_tableData.value,
//       action: "edit",
//       index: index,
//     });
//   } else if (action == "cancel") {
//     console.log("cancel");
//     editing.value = -1;
//   } else if (action == "delete") {
//     emit("on-action", { body: body, action: action, index: index });
//   }
//   action = body;
// }
</script>

<style></style>
