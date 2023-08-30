<template>
  <section class="relative page">
    <div class=" "><route-indicator /></div>

    <edit-fab
      class="fixed md:right-10 right-10 bottom-10"
      :errors="errors"
      :loading="loading"
      :editing="editing"
      @edit="edit"
      @save="save"
      @cancel="cancel"
    />
  </section>
</template>

<script lang="ts" setup>
import { onMounted, ref } from "vue";
import { useToast } from "vue-toastification";
import ErrorHandlerUtil from "../../data/util/error.handler.util";
import { useRoute, useRouter } from "vue-router";
import httpClient from "../../data/util/request.handler";
import EditFab from "../../components/common/edit.fab.vue";
import RouteIndicator from "../../components/common/route.indicator.vue";

let loading = ref<Boolean>(false);
let editing = ref<Boolean>(false);
let response = ref<any>(null);
let error = ref<any>(null);
let errors = ref<any[]>([]);
const router = useRouter();
const route = useRoute();
const toast = useToast();

onMounted(() => {
  load();
});

async function load() {
  loading.value = true;
  console.log("loading...", route.query.id);
  try {
    var res = await new httpClient().get(`tags/${route.query.id}`, {
      id: route.params.id,
    });
    // console.log('response: ', res);

    if (res.success || res.data != null) {
      response.value = res.data;
    } else throw Error(res.message);
  } catch (e) {
    response.value = null;
    error.value = e;
    ErrorHandlerUtil.handle(e, toast, router);
  } finally {
    loading.value = false;
  }
}

async function save() {}

function edit() {
  editing.value = !editing.value;
}

async function cancel() {
  loading.value = false;
  editing.value = false;
  errors.value = [];
}
</script>

<style></style>
