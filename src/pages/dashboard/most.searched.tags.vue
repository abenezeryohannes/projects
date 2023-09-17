<template>
  <section class="shadow rounded-lg dark:bg-card-dark pb-2">
    <!-- <div
      class="flex justify-between items-center font-extrabold shadow-sm dark:bg-background-darkish rounded-t-lg text-base py-5 px-5 pb-6 mb-1"
    >
      <p>Most Searched Tags</p>
      <p v-if="list.values.length > 0">{{ total() }}</p>
    </div> -->
    <div
      @click="emit('more')"
      class="grid grid-cols-3 text-left gap-x-5 dark:bg-background-darkish shadow mb-3 font-bold text-base gap-y-0"
    >
      <p class="py-3 pl-5">Tag</p>
      <p class="py-3 text-center">Type</p>
      <p class="py-3 text-center pr-5">Popularity</p>
    </div>
    <div class="" v-if="list != null" v-for="item in list.slice(0, 6)">
      <div
        class="grid grid-cols-3 gap-x-5 text-left capitalize text-sm font-bold gap-y-8"
      >
        <div class="py-3 pl-5">
          {{ item.name }}
        </div>
        <div class="py-3 text-center">
          {{ item.type }}
        </div>
        <div class="py-3 pr-5 text-center">
          {{ item.searchCount + "  ( " + percent(item) + "% )" }}
        </div>
      </div>
    </div>
    <!-- <div class="px-5">
      <p class="text-right text-blue-500 pt-5 cursor-pointer">View More</p>
    </div> -->
  </section>
</template>
<script setup lang="ts">
import { Carousel, initTE } from "tw-elements";
import errorHandlerUtil from "../../data/util/error.handler.util";
import RequestHandler from "../../data/util/request.handler";
import SearchTableForm from "../../components/forms/search.table.form.vue";
import actionFab from "../../components/common/action.fab.vue";
import companiesTable from "../tables/businesses.table.vue";
import RouteIndicator from "../../components/common/route.indicator.vue";
import { useRouter } from "vue-router";
import { onBeforeUnmount, onMounted, ref, watch } from "vue";
import { useToast } from "vue-toastification";
import { WrapperDto } from "../../domain/wrapper.dto";
import { constants } from "../../constants";
import { Tag } from "../../domain/company/entity/tag.entity";

let scroll = ref<number>(0);
let loading = ref<boolean>(false);
let loading_table = ref<boolean>(true);
let page = ref<number>(1);
let addTagModel = ref<any>();
const media_link = constants.MEDIA_LINK;

let response = ref<WrapperDto<Tag>>(
  new WrapperDto({
    count: 0,
    page: 0,
    total_pages: 1,
    datas: [],
  } as WrapperDto<Tag>)
);

let list = ref<Tag[]>([]);
let index = ref<number>(0);
let search = ref<string | null>(null);
let limit = ref<number | null>(8);
// let enabled = ref<boolean>(useRoute().query?.enabled == "true");
let view = ref<string | null>(localStorage.getItem("view_type_most_tag"));
const router = useRouter();

watch(
  () => view.value,
  (val, _) => {
    if (val != null) localStorage.setItem("view_type_most_tag", val!);
  }
);

onMounted(() => {
  load();
});

onBeforeUnmount(() => {
  window.removeEventListener("scroll", handleScroll);
});

function handleScroll() {
  scroll.value = window.scrollY; // || window.screenTop
}

function percent(item: Tag): any {
  return (
    (Number(item?.searchCount ?? 0) * 100) /
    Math.max(Number(total() ?? 1), 1)
  ).toPrecision(2);
}

function total(): number {
  if (list.value == null) return 0;
  let sum: number = 0;
  list.value.forEach((item) => {
    sum += item.searchCount ?? 0;
  });
  return sum;
}

const emit = defineEmits<{
  (event: "more"): void;
}>();

async function load() {
  loading_table.value = true;
  console.log("loading ....");
  try {
    const res = (
      await new RequestHandler().get("analytics/most_searched_tags", {
        page: page.value,
        limit: limit.value,
      })
    ).data as WrapperDto<Tag>;
    console.log("most searched tags res", res);
    response.value = res;
    if ((res.datas?.length ?? 0) > 0) {
      list.value = (res as WrapperDto<Tag>).datas ?? [];

      initTE({ Carousel });
    }
  } catch (e) {
    errorHandlerUtil.handle(e, useToast(), useRouter());
  } finally {
    loading_table.value = false;
  }
}
</script>

<style></style>
