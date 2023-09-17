<template>
  <section class="shadow rounded-lg dark:bg-card-dark pb-3">
    <div
      @click="emit('more')"
      class="flex justify-between items-center font-extrabold shadow-sm dark:bg-background-darkish mb-5 rounded-t-lg text-base py-5 px-5 pb-2"
    >
      <p>Most Recent Business</p>
      <p>{{ response?.count ?? "..." }}</p>
    </div>
    <div class="" v-if="list != null" v-for="item in list">
      <div class="flex my-3 px-3 justify-between">
        <div class="flex gap-x-5">
          <div
            class="bg-background-lightish dark:bg-background-darkish rounded-lg w-14 h-14"
          >
            <webImage
              class="w-full h-full"
              rounded="rounded-lg bg-transparent"
              scale="object-cover"
              :width="2999"
              link="public/landing.png"
              :padding="0"
            />
          </div>
          <div class="text-left">
            <p class="font-bold text-sm mb-2">{{ item.name }}</p>
            <div class="flex items-center gap-x-3">
              <p>{{ item.phoneNumber }}</p>
            </div>
          </div>
        </div>
        <!--  -->
        <!--  -->
        <!--  -->
        <div>
          <p
            v-if="item.badge != null"
            class="rounded-full text-white text-ty mt-2 px-2 py-0.5"
            :style="{ background: item?.badgeColor ?? 'red' }"
          >
            {{ item.badge }}
          </p>
        </div>

        <!-- <div class="">
          <p class="text-right text-xs mb-1 font-normal">
            {{ percent(item) }}
            %
          </p>
          <div
            class="flex w-20 h-1 mb-3 rounded-lg bg-card-light dark:bg-card-dark"
          >
            <div :class="`w-${10} bg-accent-light dark:bg-accent-dark`"></div>
          </div>
          <p class="text-right">{{ item.clicked }} Clicks</p>
        </div> -->
      </div>
    </div>
    <!-- <div class="px-5">
      <p class="text-right text-blue-500 pt-5 cursor-pointer">View More</p>
    </div> -->
  </section>
</template>

<script setup lang="ts">
import webImage from "../../components/common/web-image.vue";
import errorHandlerUtil from "../../data/util/error.handler.util";
import RequestHandler from "../../data/util/request.handler";
import { onMounted, ref, watch } from "vue";
import { useRouter } from "vue-router";
import { Company } from "../../domain/company/entity/company.entity";
import { WrapperDto } from "../../domain/wrapper.dto";
import { useToast } from "vue-toastification";

let loading = ref<boolean>(false);
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

let list = ref<Company[]>([]);
let search = ref<string | null>(null);
let sort_by = ref<string | null>(null);
let limit = ref<number | null>(4);
// let enabled = ref<boolean>(useRoute().query?.enabled == "true");
let sort = ref<string | null>(null);
let view = ref<string | null>(
  localStorage.getItem("view_type_recent_business")
);
const router = useRouter();

const props = defineProps<{
  start?: Date;
  end?: Date;
}>();

watch(
  () => props.start,
  (_, __) => {
    load();
  }
);

watch(
  () => props.end,
  (_, __) => {
    load();
  }
);

onMounted(() => {
  load();
});

// function changeRoleType() {
//   load();
// }

const emit = defineEmits<{
  (event: "more"): void;
}>();

async function load() {
  loading_table.value = true;
  // console.log('loading .... role_type', this.role_type, this.enabled);
  try {
    const res = (
      await new RequestHandler().get("analytics/clicked_businesses", {
        start: props.start,
        end: props.end,
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

<style></style>
