<template>
  <section
    class="flex justify-between tex- w-full items-center dark:bg-card-dark rounded-lg shadow px-5 py-5"
  >
    <div class="text-left font-semibold text-sm">
      <p>Total Number of Users</p>
      <div class="flex gap-x-2 my-4 items-center">
        <v-icon
          cls="dark:text-orange-500"
          :size="5"
          fill="orange-500"
          :icon="
            ((response?.data?.today ?? 0) * 100) /
              (response?.data?.total ?? 1) >=
            0
              ? 'increase'
              : 'decrease'
          "
        />
        <p v-if="response != null" class="font-bold text-xs">
          +{{ (response.data.today * 100) / response.data.total }}%
        </p>
      </div>
      <p v-if="response != null" class="text-3xl font-bold">
        {{ response.data.today }}
      </p>
    </div>
    <div class="ml-20 text-orange-500">
      <v-icon cls="dark:text-orange-500" :size="14" icon="users" />
    </div>
  </section>
</template>
<script setup lang="ts">
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
    const res = (await new RequestHandler().get("analytics/total_users", {}))
      .data as WrapperDto<any>;
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
