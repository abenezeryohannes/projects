<template>
  <section>
    <modal ref="modal" @on-change="onmodalResponse" />

    <div class="w-full">
      <div class="">
        <grid-header
          :unCheckAll="unCheckAll"
          :checkAll="checkAll"
          :bulkActions="bulkActions"
          @bulk-select-action="onBulkSelectAction($event)"
          :selected="selected"
          @bulk-action="onBulkAction"
          :headers="headers"
          :selecting="selecting"
          @on-select="onSelectAll"
        />
      </div>

      <div>
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
            :class="[
              {
                'grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-x-8 gap-y-3':
                  cols == null,
              },
              cols,
            ]"
            class="w-full"
          >
            <div
              class="rounded animate-pulse h-28 dark:bg-accentlight-dark bg-accentlight-light mt-2"
              v-for="i in 12"
              :key="i"
            />
          </div>
        </div>
        <!-- grid body -->
        <grid-body
          :item="item"
          :cols="cols"
          @on-item-click="emit('on-item-click', $event)"
          :clickable="clickable"
          :unCheckAll="unCheckAll"
          :errors="errors"
          @on-action="onAction"
          :headers="headers"
          :tableData="list"
          :checkAll="checkAll"
          @on-select="onSelect"
        />
      </div>

      <div class="pt-8">
        <pagination
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
import gridHeader from "./grid.header.vue";
import gridBody from "./grid.body.vue";
import Modal from "../alert.modal.vue";
import pagination from "../pagination.vue";
import { ref, watch } from "vue";
import { WrapperDto } from "../../../domain/wrapper.dto";
const props = defineProps<{
  headers?: any;
  bulkActions?: any;
  selected?: any[];
  selecting?: boolean;
  checkAll?: any;
  cols?: any[] | any;
  item: string;
  errors?: any[];
  unCheckAll?: boolean;
  clickable?: boolean;

  response?: WrapperDto<any>;
  list: any[];
  loading?: boolean;
  show_item_on?: any;
  scrollable?: boolean;
  left_break?: any;
  right_break?: any;
}>();

const selecting = ref<boolean>(false);
const selected = ref<any[]>([]);
// const search = ref<string | null>(null);
// const sort_by = ref<string | null>(null);
// const sort = ref<string | null>(null);
const checkAll = ref<boolean>(false);
const unCheckAll = ref<boolean>(false);
const modal = ref<any>(null);

const emit = defineEmits<{
  (event: "bulk-action", param: any): void;
  (event: "on-action", param: any): void;
  (event: "on-select", param: any): void;
  (event: "on-sort-change", param: any): void;
  (event: "on-item-click", param: any): void;
  (event: "on-page-change", param: any): void;
  (event: "on-limit-change", param: any): void;
}>();

// function parseError(index: any) {
//     var error = null;
//     props.errors?.forEach(element => {
//         if (element.index == index) error = element;
//     });
//     return error;
// }

function onBulkSelectAction(x: {
  name: string;
  url: string;
  title: string;
  description: string;
  onSelect: any;
}) {
  // console.log({name, url, title, description, onSelect})
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
          props.selected?.filter((x) => {
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
}) {
  if (x.action == "delete") {
    modal.value.open({
      id: "action",
      icon: "question",
      data: x,
      type: "warning",
      title: "are_you_sure",
      body: "want_to_delete_this_data",
      actions: ["yes", "no"],
    });
  } else emit("on-action", x);
}

function onSelect(x: { check: any; index: number }) {
  unCheckAll.value = false;

  console.log("seleted_item", x.index, props.list);

  console.log(selected.value.includes(props.list[x.index]));

  if (selected.value.includes(props.list[x.index]) && !x.check) {
    selected.value.splice(selected.value.indexOf(props.list[x.index]), 1);

    if (selected.value.length == 0) clearSelection();
  } else if (x.check) {
    selecting.value = true;

    selected.value.push(props.list[x.index]);
  }
}
function onSelectAll(check: boolean) {
  checkAll.value = check;
  unCheckAll.value = false;
  selected.value.splice(0, selected.value.length);
  if (check)
    props.list.forEach((listItem) => {
      selected.value[selected.value.length] = listItem;
    });
}
function clearSelection() {
  checkAll.value = false;
  unCheckAll.value = true;
  selected.value.splice(0, selected.value.length);
  selecting.value = false;
}

function onmodalResponse(x: { id: string; action: string; data: any }) {
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

watch(
  () => selected.value,
  (newVal, _) => {
    selecting.value = newVal.length > 0;
    // console.log('on-select-all', selected.value);
  }
);
watch(
  () => selecting.value,
  (newVal, _) => {
    emit("on-select", newVal);
  }
);
</script>

<style></style>
