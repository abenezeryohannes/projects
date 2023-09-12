<template>
  <section>
    <div class="w-full text-xs overflow-x-auto px-2">
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
          item="chat-trainer-data"
          :headers="headers"
          cols="grid grid-cols-1 gap-x-8 gap-y-1 overflow-y-auto h-full"
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
import { WrapperDto } from "../../domain/wrapper.dto";
import { Company } from "../../domain/company/entity/company.entity";
// import { useI18n } from "../../i18n";
// import { dd } from "../../util";
const props = defineProps<{
  list: Company[];
  response?: WrapperDto<Company>;
  view?: string | null;
  loading?: boolean;
  clickable?: boolean;
}>();
// const { t } = useI18n();

const bulkActions = ref<any>([
  {
    name: "Delete",
    url: "chat-trainers/utterances/delete_all",
    title: "Are you sure?",
    description: "Do you Want to delete this data?",
  },
]);
const headers = ref<any[]>([
  { name: "#bulk#", width: "1", sortable: false },
  //   {
  //     label: "banner",
  //     name: "banner",
  //     width: "4",
  //     sortable: true,
  //     type: "image",
  //     cls: "justify-center",
  //     editable: true,
  //   },
  {
    label: "utterances",
    name: "utterance",
    width: "13",
    sortable: true,
    type: "text",
    editable: true,
    cls: "justify-start",
  },
  // {
  //   label: "Arabic Name",
  //   name: "arabicName",
  //   width: "2",
  //   sortable: true,
  //   type: "text",
  //   editable: true,
  //   cls: "justify-start",
  // },
  // {
  //   label: "Phone",
  //   name: "phoneNumber",
  //   width: "2",
  //   sortable: false,
  //   type: "text",
  //   cls: "justify-start",
  //   editable: true,
  // },

  // {
  //   label: "Deliver Time",
  //   name: "deliveryTime",
  //   width: "2",
  //   sortable: false,
  //   type: "text",
  //   cls: "justify-start",
  //   editable: true,
  // },
  // {
  //   label: "Fee",
  //   name: "deliveryFee",
  //   width: "1",
  //   sortable: true,
  //   type: "text",
  //   cls: "justify-start",
  //   editable: true,
  // },

  // {
  //   label: "Badge",
  //   name: "badge",
  //   width: "1",
  //   sortable: false,
  //   type: "text",
  //   cls: "justify-start",
  //   editable: true,
  // },
  // {
  //   label: "Color",
  //   name: "badgeColor",
  //   width: "1",
  //   sortable: false,
  //   type: "color",
  //   cls: "justify-start",
  //   editable: true,
  // },
  // {
  //   label: "Active",
  //   name: "isActive",
  //   width: "1",
  //   sortable: true,
  //   type: "toggle",
  //   option: { positive: "active", negative: "in-active" },
  //   editable: true,
  //   cls: "justify-center",
  // },
  {
    label: "action",
    name: "#actions#",
    width: "21",
    sortable: false,
    actions: ["edit", "delete"],
  },
]);
const tableData = ref<Company[]>([]);
const gridData = ref<Company[]>([]);
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

async function onAction(x: {
  index: number;
  body: any;
  action: string;
  files: any[];
}) {
  console.log("on-action", x.index, x.body, x.action, "on-action-end");
  if (props.list == null) return;

  switch (x.action.toLowerCase()) {
    case "delete":
      try {
        await new RequestHandler().post("chat-trainers/utterances/delete", {
          id: props.list![x.index].id,
        });
        emit("update-list");
      } catch (e) {
        errorHandlerUtil.handle(e, useToast(), useRouter());
      }
      break;
    case "edit":
      try {
        // console.log("request", x.body);
        // console.log("files", x.files[0]);

        var response = await new RequestHandler().post(
          "chat-trainers/utterances/" + props.list![x.index].id + "/edit",
          x.body
        );
        console.log("response", response);
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

function mapTableData(listPar: Company[]) {
  tableData.value = [];
  listPar.forEach((element) => {
    let index = tableData.value.length;
    tableData.value[index] = element;
    // tableData.value[index].banner = constants.MEDIA_LINK + element.banner;
  });
}

function mapGridData(listPar: Company[]) {
  gridData.value = [];
  listPar.forEach((element) => {
    let index = gridData.value.length;
    gridData.value[index] = element;
    // gridData.value[index].banner = constants.MEDIA_LINK + element.banner;
  });
}

function map(newValue: Company[]) {
  props.view == "table" ? mapTableData(newValue) : mapGridData(newValue);
}
</script>

<style></style>
