<template>
  <modal class="w-5/12" ref="Modal" :show="show" @on-show="show = $event">
    <template v-slot:header>
      <p class="text-xl font-bold text-left capitalize">
        {{ t("Most Searched Tags") }}
      </p>
    </template>

    <section class="">
      <div class="relative pt-3 md:px-5 px-3 mb-16">
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
          @on-item-click=""
          @on-page-change="
            page = $event;
            load();
          "
          @update-list="load()"
        />
      </div>
    </section>
  </modal>
</template>

<script setup lang="ts">
import modal from "../../components/common/modal.vue";
import errorHandlerUtil from "../../data/util/error.handler.util";
import { useRouter } from "vue-router";
import { useToast } from "vue-toastification";
import RequestHandler from "../../data/util/request.handler";
import { useI18n } from "../../i18n";
import { onBeforeUnmount, onMounted, ref, watch } from "vue";
import { Company } from "../../domain/company/entity/company.entity";
import { WrapperDto } from "../../domain/wrapper.dto";
import TagsTable from "../tables/top.tags.table.vue";
import searchTableForm from "../../components/forms/search.table.form.vue";
const { t } = useI18n();

// const route = useRoute();
const editing = ref<boolean>(false);
const Modal = ref<any>(null);
const show = ref<boolean>(false);

let list = ref<Company[]>([]);
let search = ref<string | null>(null);
let limit = ref<number | null>(12);

let sort_by = ref<string | null>("searchCount");
let sort = ref<string | null>("DESC");

let view = ref<string | null>(localStorage.getItem("view_type_top_tags"));

let scroll = ref<number>(0);
let loading_table = ref<boolean>(true);
let page = ref<number>(1);
let response = ref<WrapperDto<Company>>(
  new WrapperDto({
    count: 0,
    page: 0,
    total_pages: 1,
    datas: [],
  } as WrapperDto<Company>)
);

function open() {
  editing.value = true;
  Modal.value?.open();
  load();
}

watch(
  () => view.value,
  (val, _) => {
    if (val != null) localStorage.setItem("view_type_top_tags", val!);
  }
);

defineExpose({
  open,
});

onMounted(() => {
  window.addEventListener("scroll", handleScroll);
});

onBeforeUnmount(() => {
  window.removeEventListener("scroll", handleScroll);
});

function handleScroll() {
  scroll.value = window.scrollY; // || window.screenTop
}

async function load() {
  console.log("loading is greatere");
  loading_table.value = true;
  try {
    const res = (
      await new RequestHandler().get("tags", {
        search: search.value,
        sort: sort.value,
        sort_by: sort_by.value,
        page: page.value,
        limit: limit.value,
      })
    ).data as WrapperDto<Company>;
    console.log("res", res);
    response.value = res;
    if ((res.datas?.length ?? 0) > 0)
      list.value = (res as WrapperDto<Company>).datas ?? [];
  } catch (e) {
    errorHandlerUtil.handle(e, useToast(), useRouter());
  } finally {
    loading_table.value = false;
  }
}
</script>
