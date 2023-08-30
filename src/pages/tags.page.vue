<template>
  <section class="page">
    <div class="mb-5">
      <route-indicator />
    </div>

    <add-tag @on-change="load()" ref="addTagModel" />

    <div class="relative mb-16 lg:w-10/12">
      <search-table-form
        @on-change="
          search = $event;
          load();
        "
        @on-page-change="
          page = $event;
          load();
        "
        @on-view-change="view = $event"
        :value="search"
        :view_controller="true"
        :page="page"
        placeholder="Search..."
        :response="response"
      />

      <tags-table
        :view="view"
        :response="response"
        :list="list"
        :clickable="true"
        :loading="loading_table"
        @on-limit-change="
          limit = $event;
          load();
        "
        @on-sort-change="
          sort_by = $event.sort_by;
          sort = $event.sort;
          load();
        "
        @on-item-click="onItemClick"
        @on-page-change="
          page = $event;
          load();
        "
        @update-list="load()"
      />

      <div
        v-show="scroll < 100 || scroll == null"
        class="fixed transform ease-in-out z-20 duration-1000 right-10 bottom-10"
      >
        <action-fab
          :loading="loading"
          action="add"
          @on-action="addTagModel.open()"
        />
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import errorHandlerUtil from "../data/util/error.handler.util";
import RequestHandler from "../data/util/request.handler";
import SearchTableForm from "../components/forms/search.table.form.vue";
import actionFab from "../components/common/action.fab.vue";
import tagsTable from "./tables/tags.table.vue";
import RouteIndicator from "../components/common/route.indicator.vue";
import { useRouter } from "vue-router";
import { onBeforeUnmount, onMounted, ref, watch } from "vue";
import { useToast } from "vue-toastification";
import { Tag } from "../domain/company/entity/tag.entity";
import { WrapperDto } from "../domain/wrapper.dto";
import addTag from "../pages/modals/add.tag.vue";

let scroll = ref<number>(0);
let loading = ref<boolean>(false);
let loading_table = ref<boolean>(true);
let page = ref<number>(1);
let addTagModel = ref<any>();

let response = ref<WrapperDto<Tag>>(
  new WrapperDto({
    count: 0,
    page: 0,
    total_pages: 1,
    datas: [],
  } as WrapperDto<Tag>)
);

let list = ref<Tag[]>([]);
let search = ref<string | null>(null);
let sort_by = ref<string | null>(null);
let limit = ref<number | null>(null);
// let enabled = ref<boolean>(useRoute().query?.enabled == "true");
let sort = ref<string | null>(null);
let view = ref<string | null>(localStorage.getItem("view_type"));
const router = useRouter();

watch(
  () => view.value,
  (val, _) => {
    if (val != null) localStorage.setItem("view_type", val!);
  }
);

onMounted(() => {
  window.addEventListener("scroll", handleScroll);
  load();
});

onBeforeUnmount(() => {
  window.removeEventListener("scroll", handleScroll);
});

function handleScroll() {
  scroll.value = window.scrollY; // || window.screenTop
}

function onItemClick(event: any) {
  console.log("-----clicked----", event);
  router.push({ name: "court", params: { id: list.value[event.index].id } });
}
// function changeRoleType() {
//   load();
// }

async function load() {
  loading_table.value = true;
  // console.log('loading .... role_type', this.role_type, this.enabled);
  try {
    const res = (
      await new RequestHandler().get("tags", {
        search: search.value,
        sort: sort.value,
        sort_by: sort_by.value,
        page: page.value,
        limit: limit.value,
      })
    ).data as WrapperDto<Tag>;
    console.log("res", res);
    response.value = res;
    if ((res.datas?.length ?? 0) > 0)
      list.value = (res as WrapperDto<Tag>).datas ?? [];
  } catch (e) {
    errorHandlerUtil.handle(e, useToast(), useRouter());
  } finally {
    loading_table.value = false;
  }
}
</script>

<style></style>
