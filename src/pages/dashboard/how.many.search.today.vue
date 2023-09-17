<template>
  <section
    class="relative my-10 px-5 py-7 shadow rounded-xl"
    :style="{ backgroundColor: '#006d9c' }"
  >
    <div class="absolute -right-10 top-5 bottom-2 opacity-10 dark:opacity-20">
      <v-icon
        cls="text-gray-50 dark:text-background-dark"
        :size="28"
        fill=""
        icon="search"
      />
    </div>
    <div class="grid grid-cols-12 gap-x-10">
      <div class="col-span-3 w-20 h-20 relative">
        <circle-progress
          :percent="
            (
              ((response?.data?.today ?? 0) * 100) /
              (response?.data?.total ?? 1)
            ).toPrecision(2)
          "
          size="80"
          :is-bg-shadow="false"
          empty-color="#F8F9FE"
          fill-color="#05b0fa"
          :border-width="5"
          :border-bg-width="5"
        />
        <div
          class="text-center absolute top-7 left-7 flex items-center justify-center"
        >
          <p class="text-sm text-white font-bold">
            {{
              (
                ((response?.data?.today ?? 0) * 100) /
                (response?.data?.total ?? 1)
              ).toPrecision(2)
            }}
            %
          </p>
        </div>
      </div>
      <div
        class="col-span-9 text-white flex justify-start items-center text-start"
      >
        <div>
          <p class="text-3xl font-extrabold">
            {{ response?.data.today ?? "..." }}
          </p>
          <p class="text-sm font-semibold">Searches today</p>
        </div>
      </div>
    </div>
  </section>
</template>
<script setup lang="ts">
import CircleProgress from "vue3-circle-progress";
import errorHandlerUtil from "../../data/util/error.handler.util";
import RequestHandler from "../../data/util/request.handler";
import { useToast } from "vue-toastification";
import { onMounted, ref, watch } from "vue";
import { useRouter } from "vue-router";
import VIcon from "../../components/icons/v-icon.vue";

import { WrapperDto } from "../../domain/wrapper.dto";
let loading = ref<boolean>(false);
let response = ref<WrapperDto<any> | null>(null);

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

async function load() {
  console.log("loading");
  loading.value = true;
  // console.log('loading .... role_type', this.role_type, this.enabled);
  try {
    const res = (
      await new RequestHandler().get("analytics/total_searches_today", {})
    ).data as WrapperDto<any>;
    console.log("res", res);
    response.value = res;
  } catch (e) {
    console.log(e);
    errorHandlerUtil.handle(e, useToast(), useRouter());
  } finally {
    loading.value = false;
  }
}
</script>
