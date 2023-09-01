<template>
  <section>
    <modal ref="modal" @on-change="onModalResponse" />

    <div class="w-full">
      <div class="">
        <table-header
          :headers_cls="headers_cls"
          :response="response"
          :unCheckAll="unCheckAll"
          :checkAll="checkAll"
          :bulkActions="bulkActions"
          :selected="selected"
          @bulk-action="onBulkAction"
          @bulk-select-action="onBulkSelectAction($event)"
          :headers="headers"
          :selecting="selecting"
          @on-sort-change="emit('on-sort-change', $event)"
          @on-select="onSelectAll"
        />
      </div>

      <div class="rounded">
        <!-- Loader when no data and loading is true -->
        <div
          v-if="loading && (list == null || list.length == 0)"
          id="loading-screen"
          class="w-full h-full"
        >
          <!-- <span class="text-accent-light dark:text-accent-dark my-20 mx-auto block relative w-0 h-0">
                    <div class="custom_small_loader w-10 h-10"/>
                </span> -->

          <div
            class="rounded opacity-100 dark:bg-opacity-50 animate-pulse w-full h-8 dark:bg-accentlight-dark bg-accentlight-light mt-2"
            v-for="i in 6"
            :key="i"
          />
        </div>
        <!-- table body  -->
        <table-body
          v-else
          :clickable="clickable"
          :unCheckAll="unCheckAll"
          :errors="errors"
          :headers="headers"
          :tableData="list"
          :checkAll="checkAll"
          :item="item"
          :show_item_on="show_item_on"
          @on-action="onAction"
          @on-item-click="emit('on-item-click', $event)"
          @on-select="onSelect"
        />
      </div>

      <!-- pagination -->
      <div class="mt-5 pb-10 px-5 font-semibold text-xs">
        <pagination
          v-if="
            response != undefined &&
            response != null &&
            (response.count ?? 0) > (response.limit ?? 0)
          "
          :response="response"
          :limit_controller="true"
          @on-limit-change="emit('on-limit-change', $event)"
          @on-change="emit('on-page-change', $event)"
          :left_breaker="left_break != null ? left_break : 4"
          :right_breaker="right_break != null ? right_break : 4"
        />
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import tableHeader from "./table.header.vue";
import tableBody from "./table.body.vue";
import pagination from "../pagination.vue";
import Modal from "../alert.modal.vue";
import { ref, watch } from "vue";
import { WrapperDto } from "../../../domain/wrapper.dto";

const props = defineProps<{
  response?: WrapperDto<any>;
  list: any[];
  loading?: boolean;
  show_item_on?: any;
  item?: any;
  scrollable?: boolean;
  errors?: any;
  bulkActions: any[];
  headers: any;
  left_break?: any;
  right_break?: any;
  clickable?: boolean;
  headers_cls?: boolean;
}>();

const checkAll = ref<boolean>(false);
const unCheckAll = ref<boolean>(false);
const selecting = ref<boolean>(false);
const selected = ref<any[]>([]);
// const search = ref<string | null>(null);
// const sort_by = ref<string | null>(null);
// const sort = ref<string | null>(null);
const modal = ref<any>(null);

const emit = defineEmits<{
  (event: "bulk-select-action", param: any): void;
  (event: "bulk-action", param: any): void;
  (event: "on-action", param: any): void;
  (event: "on-select", param: any): void;
  (event: "on-sort-change", param: any): void;
  (event: "on-item-click", param: any): void;
  (event: "on-page-change", param: any): void;
  (event: "on-limit-change", param: any): void;
}>();

watch(
  () => selected.value,
  (newVal, __) => {
    selecting.value = newVal.length > 0;
    // console.log('on-select-all', selected.value);
  }
);

watch(
  () => props.list,
  (_, __) => {
    clearSelection();
  }
);

watch(
  () => selecting.value,
  (newVal, __) => {
    emit("on-select", newVal);
  }
);

function onBulkSelectAction(x: {
  name: string;
  url: string;
  title: string;
  description: string;
  onSelect: any;
}) {
  // console.log('check 123', x.name, x.url, x.title, x.description, onSelect );
  if (x.onSelect) onBulkAction(x);
}

function onBulkAction(x: {
  name: string;
  url: string;
  title: string;
  description: string;
  onSelect: any;
}) {
  if (x.name == "cancel") {
    clearSelection();
  } else if (x.name == null || (x.title == null && x.description == null)) {
    emit("bulk-action", {
      selected: JSON.parse(
        JSON.stringify(
          selected.value.filter((x) => {
            return x != null;
          })
        )
      ),
      action: x,
    });
  } else {
    // console.log(title, description);
    modal.value.open({
      id: "bulk_action",
      icon: "question",
      data: x,
      type: "default",
      title: x.title,
      body: x.description,
      actions: ["yes", "no"],
    });
  }
}

function onAction(x: {
  index: number;
  body: any;
  item_body: any;
  action: string;
  orginal: any;
  files: any[];
}) {
  if (x.action == "delete") {
    modal.value.open({
      id: "action",
      icon: "question",
      data: {
        body: x.body,
        item_body: x.item_body,
        action: x.action,
        index: x.index,
        files: x.files,
      },
      type: "warning",
      title: "Are you sure?",
      body: "Do you Want to delete this data?",
      actions: ["yes", "no"],
    });
  } else
    emit("on-action", {
      body: x.body,
      item_body: x.item_body,
      action: x.action,
      index: x.index,
      orginal: x.orginal,
      files: x.files,
    });
}

function onSelect(x: { check: any; index: number }) {
  unCheckAll.value = false;
  // console.log('selected_item', x.index, props.list)
  // console.log(selected.value.includes(props.list[x.index]))

  if (selected.value.includes(props.list[x.index]) && !x.check) {
    selected.value.splice(selected.value.indexOf(props.list[x.index]), 1);

    if (selected.value.length == 0) clearSelection();
  } else if (x.check)
    selected.value[selected.value.length] = props.list[x.index];

  selecting.value = selected.value.length > 0;
}

function onSelectAll(check: any) {
  checkAll.value = check;
  unCheckAll.value = false;
  selected.value.splice(0, selected.value.length);
  if (check)
    props.list.forEach((listItem) => {
      selected.value[selected.value.length] = listItem;
    });
  selecting.value = selected.value.length > 0;
}

function clearSelection() {
  checkAll.value = false;
  unCheckAll.value = true;
  selected.value.splice(0, selected.value.length);
  selecting.value = selected.value.length > 0;
}

function onModalResponse(x: { id: string; action: string; data: any }) {
  if (x.id == "bulk_action") {
    if (x.action == "yes") {
      emit("bulk-action", {
        selected: JSON.parse(
          JSON.stringify(
            selected.value.filter((x) => {
              return x != null;
            })
          )
        ),
        action: x.data,
      });
      clearSelection();
    }
  } else if (x.id == "action") {
    if (x.action == "yes") {
      if (x.data.action == "delete") emit("on-action", x.data);
    }
  }
}
</script>

<style></style>
