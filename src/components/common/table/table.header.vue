<template>
  <section>
    <div
      v-if="selecting"
      class="px-5 mb-3 shadow-lg py-1 flex bg-primaryDark-light dark:bg-primaryDark-dark rounded-md"
    >
      <p class="mr-6 my-auto text-white">
        {{ t("items_selected", { var: selected.length }) }}
      </p>
      <div class="h-10 pt-1">
        <dropdown-form
          :value="bulkAction == null ? null : bulkAction.name"
          :editing="true"
          :error="null"
          :height="8"
          @on-change="
            bulkAction = $event;
            emit('bulk-select-action', $event);
          "
          bg="bg-white dark:text-gray-700"
          :options="bulkActions"
          name="action"
          placeholder="bulk actions"
        />
      </div>

      <div class="font-bold flex ml-5">
        <p
          class="mr-3 my-auto cursor-pointer text-white"
          :class="[{ 'dark:text-gray-300 text-gray-400': bulkAction == null }]"
          @click="emit('bulk-action', bulkAction)"
        >
          {{ t("confirm") }}
        </p>
        <p
          class="my-auto cursor-pointer text-white"
          @click="emit('bulk-action', { name: 'cancel' })"
        >
          {{ t("cancel") }}
        </p>
      </div>
    </div>

    <div
      class="w-full grid grid-cols-16 gap-x-2 mb-2"
      :class="[
        {
          'dark:bg-background-darkish rounded-md text-gray-700 dark:text-white  shadow-lg mb-3 bg-background-light':
            headers_cls == null,
        },
        headers_cls,
      ]"
    >
      <div
        v-for="header in headers"
        :key="header.name"
        :class="['col-span-' + header.width]"
      >
        <div class="h-full w-full flex">
          <div
            v-if="header.name === '#bulk#'"
            class="w-full h-full flex items-center justify-center"
          >
            <checkbox-form
              :value="checkAll"
              @on-change="emit('on-select', $event)"
              :editing="true"
            />
          </div>

          <div
            v-else-if="header.name === '#actions#'"
            class="w-full h-full flex items-center justify-center"
          >
            <p class="font-bold capitalize">{{ t(header.label) }}</p>
          </div>

          <div
            v-else
            class="my-auto flex w-full h-full py-2 items-center"
            @click="sort(header)"
            :class="[{ 'cursor-pointer': header.sortable }, header.cls]"
          >
            <p class="font-bold capitalize">{{ t(header.label) }}</p>
            <div v-if="header.sortable" class="ml-1">
              <v-icon
                v-show="response == null || response.sort_by != header.name"
                icon="arrow-down"
                :padding="0"
                :size="4"
                cls="dark:text-gray-200"
                fill="gray-500"
              />

              <v-icon
                v-show="
                  response != null &&
                  response.sort == 'desc' &&
                  response.sort_by == header.name
                "
                icon="sort-asc"
                :padding="0"
                :size="4"
                cls="dark:text-gray-200"
                fill="gray-500"
              />

              <v-icon
                v-show="
                  response != null &&
                  response.sort == 'asc' &&
                  response.sort_by == header.name
                "
                icon="sort-desc"
                :padding="0"
                :size="4"
                cls="dark:text-gray-200"
                fill="gray-500"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import DropdownForm from "../../forms/dropdown.form.vue";
import checkboxForm from "../../forms/checkbox.form.vue";
import VIcon from "../../icons/v-icon.vue";
import { ref, watch } from "vue";
import { useI18n } from "../../../i18n";
import { WrapperDto } from "../../../domain/wrapper.dto";
const props = defineProps<{
  response?: WrapperDto<any>;
  headers: any;
  selecting: any;
  checkAll: any;
  headers_cls: any;
  selected: any;
  bulkActions: any[];
}>();

const bulkAction = ref<any>(null);

const { t } = useI18n();

const emit = defineEmits<{
  (event: "on-select", param: any): void;
  (event: "on-sort-change", param: any): void;
  (event: "bulk-select-action", param: any): void;
  (event: "bulk-action", param: any): void;
}>();

function sort(header: any) {
  console.log("sort response: ", props.response);
  if (header.sortable)
    emit("on-sort-change", {
      sort_by: header.sort_name == null ? header.name : header.sort_name,
      sort:
        props.response != null && props.response.sort == "desc"
          ? "asc"
          : "desc",
    });
}

watch(
  () => props.selecting,
  (newVal, _) => {
    console.log("selecging", newVal);
  }
);
</script>

<style></style>
