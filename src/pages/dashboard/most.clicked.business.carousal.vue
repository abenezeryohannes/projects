<template>
  <div
    id="carouselExampleCaptions"
    class="relative w-4/12"
    data-te-carousel-init
    data-te-ride="carousel"
  >
    <!--Carousel indicators-->
    <div
      class="absolute bottom-0 left-0 right-0 z-[2] mx-[15%] mb-4 flex list-none justify-center p-0"
      data-te-carousel-indicators
    >
      <button
        v-if="list.length > 0"
        type="button"
        data-te-target="#carouselExampleCaptions"
        data-te-slide-to="0"
        data-te-carousel-active
        class="mx-[3px] box-content h-[3px] w-[30px] flex-initial cursor-pointer border-0 border-y-[10px] border-solid border-transparent bg-white bg-clip-padding p-0 -indent-[999px] opacity-50 transition-opacity duration-[600ms] ease-[cubic-bezier(0.25,0.1,0.25,1.0)] motion-reduce:transition-none"
        aria-current="true"
        aria-label="Slide 1"
      ></button>
      <button
        v-if="list.length > 1"
        type="button"
        data-te-target="#carouselExampleCaptions"
        data-te-slide-to="1"
        class="mx-[3px] box-content h-[3px] w-[30px] flex-initial cursor-pointer border-0 border-y-[10px] border-solid border-transparent bg-white bg-clip-padding p-0 -indent-[999px] opacity-50 transition-opacity duration-[600ms] ease-[cubic-bezier(0.25,0.1,0.25,1.0)] motion-reduce:transition-none"
        aria-label="Slide 2"
      ></button>
      <button
        v-if="list.length > 2"
        type="button"
        data-te-target="#carouselExampleCaptions"
        data-te-slide-to="2"
        class="mx-[3px] box-content h-[3px] w-[30px] flex-initial cursor-pointer border-0 border-y-[10px] border-solid border-transparent bg-white bg-clip-padding p-0 -indent-[999px] opacity-50 transition-opacity duration-[600ms] ease-[cubic-bezier(0.25,0.1,0.25,1.0)] motion-reduce:transition-none"
        aria-label="Slide 3"
      ></button>
    </div>

    <!--Carousel items-->
    <div
      @click="emit('more')"
      class="relative rounded-lg w-full h-96 overflow-hidden after:clear-both after:block after:content-['']"
    >
      <!--First item-->
      <div
        v-if="list.length > 0"
        class="relative h-96 float-left -mr-[100%] w-full transition-transform duration-[600ms] ease-in-out motion-reduce:transition-none"
        data-te-carousel-active
        data-te-carousel-item
        style="backface-visibility: hidden"
      >
        <img
          :src="media_link + list[0].banner"
          class="block w-full h-96 object-center"
          alt="..."
        />
        <div
          class="absolute text-left inset-x-[15%] bottom-5 hidden py-5 text-white md:block"
        >
          <h5 class="text-xl">{{ list[0].name }}</h5>
          <p>{{ list[0].arabicName }}</p>
        </div>
      </div>
      <!--Second item-->
      <div
        v-if="list.length > 1"
        class="relative h-96 float-left -mr-[100%] hidden w-full transition-transform duration-[600ms] ease-in-out motion-reduce:transition-none"
        data-te-carousel-item
        style="backface-visibility: hidden"
      >
        <img
          :src="media_link + list[1].banner"
          class="block w-full h-96"
          alt="..."
        />
        <div
          class="absolute text-left inset-x-[15%] bottom-5 hidden py-5 text-white md:block"
        >
          <h5 class="text-xl">{{ list[1].name }}</h5>
          <p>{{ list[1].arabicName }}</p>
        </div>
      </div>
      <!--Third item-->
      <div
        v-if="list.length > 2"
        class="relative h-96 float-left -mr-[100%] hidden w-full transition-transform duration-[600ms] ease-in-out motion-reduce:transition-none"
        data-te-carousel-item
        style="backface-visibility: hidden"
      >
        <img
          :src="media_link + list[2].banner"
          class="block w-full h-96"
          alt="..."
        />
        <div
          class="absolute text-left inset-x-[15%] bottom-5 hidden py-5 text-white md:block"
        >
          <h5 class="text-xl">{{ list[2].name }}</h5>
          <p>{{ list[2].arabicName }}</p>
        </div>
      </div>
    </div>

    <!--Carousel controls - prev item-->
    <button
      class="absolute bottom-0 left-0 top-0 z-[1] flex w-[15%] items-center justify-center border-0 bg-none p-0 text-center text-white opacity-50 transition-opacity duration-150 ease-[cubic-bezier(0.25,0.1,0.25,1.0)] hover:text-white hover:no-underline hover:opacity-90 hover:outline-none focus:text-white focus:no-underline focus:opacity-90 focus:outline-none motion-reduce:transition-none"
      type="button"
      data-te-target="#carouselExampleCaptions"
      data-te-slide="prev"
    >
      <span class="inline-block h-8 w-8">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          class="h-6 w-6"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M15.75 19.5L8.25 12l7.5-7.5"
          />
        </svg>
      </span>
      <span
        class="!absolute !-m-px !h-px !w-px !overflow-hidden !whitespace-nowrap !border-0 !p-0 ![clip:rect(0,0,0,0)]"
        >Previous</span
      >
    </button>
    <!--Carousel controls - next item-->
    <button
      class="absolute bottom-0 right-0 top-0 z-[1] flex w-[15%] items-center justify-center border-0 bg-none p-0 text-center text-white opacity-50 transition-opacity duration-150 ease-[cubic-bezier(0.25,0.1,0.25,1.0)] hover:text-white hover:no-underline hover:opacity-90 hover:outline-none focus:text-white focus:no-underline focus:opacity-90 focus:outline-none motion-reduce:transition-none"
      type="button"
      data-te-target="#carouselExampleCaptions"
      data-te-slide="next"
    >
      <span class="inline-block h-8 w-8">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          class="h-6 w-6"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M8.25 4.5l7.5 7.5-7.5 7.5"
          />
        </svg>
      </span>
      <span
        class="!absolute !-m-px !h-px !w-px !overflow-hidden !whitespace-nowrap !border-0 !p-0 ![clip:rect(0,0,0,0)]"
        >Next</span
      >
    </button>
  </div>
  <!-- <div
    v-if="list.length > 0"
    id="carouselExampleCaptions"
    class="relative"
    data-te-carousel-init
    data-te-ride="carousel"
  > 
    <div
      class="relative h-96 rounded-xl shadow-md w-full overflow-hidden after:clear-both after:block after:content-['']"
    > 
      <div
        v-for="item in list"
        :key="item.id"
        class="relative h-96 float-left -mr-[100%] w-full transition-transform duration-[600ms] ease-in-out motion-reduce:transition-none"
        :data-te-carousel-active="list[index] == item"
        data-te-carousel-item
        style="backface-visibility: hidden"
      >
        <img
          :src="media_link + item.banner"
          class="block w-full h-96 object-cover"
          :alt="item.name"
        />
        <div
          class="absolute inset-x-[15%] bottom-5 left-5 text-left hidden py-5 text-white md:block"
        >
          <h5 class="text-xl">{{ item.name }}</h5>
          <p class="">{{ item.url }}</p>
        </div>
      </div>
    </div>
  </div> -->
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
import { Company } from "../../domain/company/entity/company.entity";
import { WrapperDto } from "../../domain/wrapper.dto";
import addCompany from "../../pages/modals/add.business.vue";
import { constants } from "../../constants";

let scroll = ref<number>(0);
let loading = ref<boolean>(false);
let loading_table = ref<boolean>(true);
let page = ref<number>(1);
let addCompanyModel = ref<any>();
const media_link = constants.MEDIA_LINK;

let response = ref<WrapperDto<Company>>(
  new WrapperDto({
    count: 0,
    page: 0,
    total_pages: 1,
    datas: [],
  } as WrapperDto<Company>)
);

let list = ref<Company[]>([new Company(), new Company(), new Company()]);
let index = ref<number>(0);
let search = ref<string | null>(null);
let sort_by = ref<string | null>(null);
let limit = ref<number | null>(5);
// let enabled = ref<boolean>(useRoute().query?.enabled == "true");
let sort = ref<string | null>(null);
let view = ref<string | null>(localStorage.getItem("view_type_business"));
const router = useRouter();

watch(
  () => view.value,
  (val, _) => {
    if (val != null) localStorage.setItem("view_type_business", val!);
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

// function changeRoleType() {
//   load();
// }

const emit = defineEmits<{
  (event: "more"): void;
}>();

async function load() {
  loading_table.value = true;
  console.log("loading ....");
  try {
    const res = (
      await new RequestHandler().get("analytics/clicked_businesses", {
        page: page.value,
        limit: limit.value,
      })
    ).data as WrapperDto<Company>;
    console.log("res for clicked businesses", res);
    response.value = res;
    if ((res.datas?.length ?? 0) > 0) {
      list.value = (res as WrapperDto<Company>).datas ?? [];
      initTE({ Carousel });
    }
  } catch (e) {
    console.log("error is ", e);
    errorHandlerUtil.handle(e, useToast(), useRouter());
  } finally {
    loading_table.value = false;
  }
}
</script>

<style></style>
