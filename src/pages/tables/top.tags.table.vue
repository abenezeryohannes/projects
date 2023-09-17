<template>
  <section>
    <div class="w-full text-xs overflow-x-auto px-1">
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
          item="tag"
          :headers="headers"
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
import { Tag } from "../../domain/company/entity/tag.entity";
import { WrapperDto } from "../../domain/wrapper.dto";
// import { useI18n } from "../../i18n";
// import { dd } from "../../util";
const props = defineProps<{
  list: Tag[];
  response?: WrapperDto<Tag>;
  view?: string | null;
  loading?: boolean;
  clickable?: boolean;
}>();
// const { t } = useI18n();

const bulkActions = ref<any>([
  {
    name: "Delete",
    url: "tags/delete_all",
    title: "Are you sure?",
    description: "Do you Want to delete this data?",
  },
]);
const headers = ref<any[]>([
  {
    label: "name",
    name: "name",
    width: "6",
    sortable: false,
    type: "text",
    editable: false,
    cls: "justify-start",
  },
  {
    label: "Type",
    name: "type",
    width: "6",
    sortable: false,
    type: "autocomplete",
    link: "tags/types",
    cls: "justify-start",
    option_name: "type",
    editable: false,
  },
  {
    label: "Search Count",
    name: "searchCount",
    width: "4",
    sortable: false,
    type: "text",
    cls: "justify-center text-center",
    editable: false,
  },
]);
const tableData = ref<any[]>([]);
const gridData = ref<any[]>([]);
const errors = ref<any[]>([]);
// const search = ref<string | null>(null);
// const sort_by = ref<string | null>(null);
// const sort = ref<string | null>(null);

watch(
  () => props.list,
  (newValue, _) => {
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
  // console.log('on-bulk-action', x.selected, x.action, 'on-bulk-action-end')
  let ids: any[] = [];
  (x.selected as any[]).forEach((element) => {
    ids.push(element.id);
  });
  try {
    let response = await new RequestHandler().post(x.action.url, {
      ids: JSON.stringify(ids),
    });
    if (response.data.success) emit("update-list");
    else errorHandlerUtil.handle(response, useToast(), useRouter());
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
        await new RequestHandler().post("tags/delete", {
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

        if (x.body.owner != null) x.body.userId = x.body.owner.id;
        if (x.body.approved) x.body.enabled = true;

        var response = await new RequestHandler().post(
          "tags/" + props.list![x.index].id + "/edit",
          x.body
        );
        if (response.message != null) {
          errors.value[x.index] = {
            index: x.index,
            errors: errorHandlerUtil.handle(response, useToast(), useRouter()),
            body: x.body,
          };
        } else {
          console.log("request successfull", response.data);
          emit("update-list");
        }
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

function mapTableData(listPar: Tag[]) {
  tableData.value = [];
  listPar.forEach((element) => {
    let index = tableData.value.length;
    tableData.value[index] = element;
  });
}

function mapGridData(listPar: Tag[]) {
  gridData.value = [];
  listPar.forEach((element) => {
    let index = gridData.value.length;
    gridData.value[index] = element;
  });
}

function map(newValue: any) {
  props.view == "table" ? mapTableData(newValue) : mapGridData(newValue);
}
</script>

<style></style>
