<template>
  <section class="page">
    <div class="mb-5">
      <route-indicator />
    </div>
    <div class="relative p-3 pt-3 px-3">
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

      <chat-document-table
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
    </div>
  </section>
</template>

<script setup lang="ts">
import errorHandlerUtil from "../data/util/error.handler.util";
import RequestHandler from "../data/util/request.handler";
import SearchTableForm from "../components/forms/search.table.form.vue";
import chatDocumentTable from "./tables/chat.document.table.vue";
import RouteIndicator from "../components/common/route.indicator.vue";
import { useRouter } from "vue-router";
import { onBeforeUnmount, onMounted, ref, watch } from "vue";
import { useToast } from "vue-toastification";
import { WrapperDto } from "../domain/wrapper.dto";
import { ChatDocument } from "../domain/chat/entity/chat.document.entity";

let scroll = ref<number>(0);
let loading_table = ref<boolean>(true);
let page = ref<number>(1);

let response = ref<WrapperDto<ChatDocument>>(
  new WrapperDto({
    count: 0,
    page: 0,
    total_pages: 1,
    datas: [],
  } as WrapperDto<ChatDocument>)
);

let list = ref<ChatDocument[]>([]);
let search = ref<string | null>(null);
let sort_by = ref<string | null>(null);
let limit = ref<number | null>(null);
// let enabled = ref<boolean>(useRoute().query?.enabled == "true");
let sort = ref<string | null>(null);
let view = ref<string | null>(localStorage.getItem("view_type_chatdocument"));
// const router = useRouter();

watch(
  () => view.value,
  (val, _) => {
    if (val != null) localStorage.setItem("view_type_chatdocument", val!);
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

function onItemClick(_: any) {
  //   console.log("-----clicked----", event);
  //   router.push({ name: "chatdocument", params: { id: list.value[event.index].id } });
}
// function changeRoleType() {
//   load();
// }

async function load() {
  loading_table.value = true;
  // console.log('loading .... role_type', this.role_type, this.enabled);
  try {
    const res = (
      await new RequestHandler().get("chatdocuments", {
        search: search.value,
        sort: sort.value,
        sort_by: sort_by.value,
        page: page.value,
        limit: limit.value,
      })
    ).data as WrapperDto<ChatDocument>;
    console.log("res", res);
    response.value = res;
    if ((res.datas?.length ?? 0) > 0)
      list.value = (res as WrapperDto<ChatDocument>).datas ?? [];
  } catch (e) {
    errorHandlerUtil.handle(e, useToast(), useRouter());
  } finally {
    loading_table.value = false;
  }
}
</script>

<style></style>
