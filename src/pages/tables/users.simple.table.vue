<template>
  <section>
    <div class="w-full text-xs px-2">
      <div v-if="view == 'table'">
        <my-table
          @on-select="onSelect"
          @on-action="onAction"
          @on-page-change="emit('on-page-change', $event)"
          @bulk-action="onBulkAction"
          @on-limit-change="emit('on-limit-change', $event)"
          @on-sort-change="emit('on-sort-change', $event)"
          @on-item-click="emit('on-item-click', $event)"
          :clickable="clickable"
          :loading="loading"
          :response="response"
          :list="tableData"
          :errors="errors"
          :bulkActions="bulkActions"
          :headers="headers"
        />
      </div>

      <div v-else>
        <grid
          @on-select="onSelect"
          @on-action="onAction"
          @on-page-change="emit('on-page-change', $event)"
          @bulk-action="onBulkAction"
          @on-limit-change="emit('on-limit-change', $event)"
          @on-item-click="emit('on-item-click', $event)"
          cols="grid grid-cols-1 gap-x-8 gap-y-1 overflow-y-auto h-full"
          item="simple-user"
          :clickable="clickable"
          :loading="loading"
          :response="response"
          :list="gridData"
          :errors="errors"
          :bulkActions="bulkActions"
        />
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import Grid from "../../components/common/grid/grid.vue";
import { ref, watch } from "vue";
import { useRouter } from "vue-router";
import { useToast } from "vue-toastification";
import myTable from "../../components/common/table/table.vue";
import errorHandlerUtil from "../../data/util/error.handler.util";
import RequestHandler from "../../data/util/request.handler";
import { User } from "../../domain/user/entity/user.entity";

const props = defineProps<{
  list: any[];
  response?: any;
  view?: string | null;
  loading?: boolean;
  clickable?: boolean;
}>();

const bulkActions = ref<any>([
  // {
  // name: 'Delete All', url: "users/deleteAll", title: 'Are you sure?',
  // description: 'This will delete all the selected admins.'
  // }
]);
const headers = ref<any[]>([
  // { name: "#bulk#", width: "1", sortable: false },
  {
    label: "avatar",
    name: "avatar",
    width: "4",
    sortable: true,
    type: "image",
    cls: "justify-start pl-5  items-center",
    editable: true,
  },
  {
    label: "Full Name",
    name: "fullName",
    width: "8",
    sortable: true,
    type: "text",
    editable: true,
    cls: "justify-start  items-center",
  },
  {
    label: "Phone Number",
    name: "phoneNumber",
    width: "4",
    sortable: true,
    type: "text",
    editable: true,
    cls: "justify-start  items-center",
  },
  // {
  //   label: "action",
  //   name: "#actions#",
  //   width: "2",
  //   sortable: false,
  //   actions: ["edit", "delete"],
  // },
]);
const tableData = ref<any[]>([]);
const gridData = ref<any[]>([]);
const errors = ref<any[]>([]);
// const search = ref<string | null>(null);
// const sort_by = ref<string | null>(null);
// const sort = ref<string | null>(null);

watch(
  () => props.list,
  (newValue, __) => {
    map(newValue);
    errors.value = [];
  }
);
watch(
  () => props.view,
  (_, __) => {
    map(props.list);
    errors.value = [];
  }
);
const emit = defineEmits<{
  (event: "update-list"): void;
  (event: "on-sort-change", param: any): void;
  (event: "on-page-change", param: any): void;
  (event: "on-item-click", param: any): void;
  (event: "on-limit-change", param: any): void;
}>();
async function onBulkAction(x: { selected: any; action: any }) {
  console.log("on-bulk-action", x.selected, x.action, "on-bulk-action-end");
  let ids: any[] = [];
  (x.selected as any[]).forEach((element) => {
    ids.push(element.id);
  });
  try {
    let response = await new RequestHandler().postForm(
      x.action.url,
      { ids: JSON.stringify(ids) },
      []
    );
    console.log(response);
    emit("update-list");
  } catch (e: any) {
    console.log(e.toString());
    errorHandlerUtil.handle(e, useToast(), useRouter());
  }
}
async function onAction(x: { index: number; body: any; action: string }) {
  console.log("on-action", x.index, x.body, x.action, "on-action-end");
  if (props.list == null) return;

  switch (x.action.toLowerCase()) {
    case "delete":
      try {
        await new RequestHandler().post("users/delete", {
          id: props.list![x.index].id,
        });
        emit("update-list");
      } catch (e) {
        errorHandlerUtil.handle(e, useToast(), useRouter());
      }
      break;
    case "edit":
      try {
        console.log("request", x.body);
        var response = await new RequestHandler().post("users/edit", x.body);
        console.log("request successfull", response.data);
        emit("update-list");
      } catch (e) {
        errorHandlerUtil.handle(e, useToast(), useRouter());
        errors.value[x.index] = {
          index: x.index,
          errors: errorHandlerUtil.handle(e, useToast(), useRouter()),
          body: x.body,
        };
      }
      break;
    case "cancel":
      errors.value.splice(x.index, 1);
      break;
  }
}
function onSelect(selected: any) {
  console.log("on-select", selected, "on-select-end");
}

function mapTableData(listPar: User[]) {
  tableData.value = [];
  listPar.forEach((element) => {
    let index = tableData.value.length;
    tableData.value[index] = element;
    // tableData.value[index].banner = constants.MEDIA_LINK + element.banner;
  });
}

function mapGridData(listPar: User[]) {
  gridData.value = [];
  listPar.forEach((element) => {
    let index = gridData.value.length;
    gridData.value[index] = element;
    // gridData.value[index].banner = constants.MEDIA_LINK + element.banner;
  });
}

function map(newValue: any) {
  props.view == "table" ? mapTableData(newValue) : mapGridData(newValue);
}
</script>

<style></style>
