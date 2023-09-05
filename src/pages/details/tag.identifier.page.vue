<template>
  <div class="relative w-full h-screen mt-12">
    <p
      v-if="tags.length > 0"
      class="font-bold capitalize flex justify-start pb-5 pl-3 text-lg"
    >
      {{ "Tag Identifiers" }}
    </p>
    <div class="flex w-full pl-3">
      <tagInputForm
        v-if="$route.params.id != null"
        class=""
        :editing="editing ? true : false"
        :can_add="editing ? true : false"
        :deletable="editing ? true : false"
        :value="tags"
        @on-change="onChange"
        @on-add="onAdd"
        @on-delete="onDelete"
        :height="100"
      />

      <edit-fab
        v-if="$route.params.id != null"
        class="fixed md:right-10 right-10 bottom-10"
        :editing="editing"
        :errors="errors"
        :loading="loading"
        @edit="edit"
        @save="save"
        @cancel="cancel"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from "vue";
import tagInputForm from "../../components/forms/tag.input.form.vue";
import ErrorHandlerUtil from "../../data/util/error.handler.util";
import httpClient from "../../data/util/request.handler";
import { useRoute, useRouter } from "vue-router";
import { useToast } from "vue-toastification";
import { WrapperDto } from "../../domain/wrapper.dto";
import { TagIdentifier } from "../../domain/company/entity/tag.identifier.entity";
import EditFab from "../../components/common/edit.fab.vue";
import { onBeforeRouteLeave } from "vue-router";

let loading = ref<Boolean>(false);
let response = ref<any>(null);
let error = ref<any>(null);
const router = useRouter();
const route = useRoute();
const toast = useToast();
let editing = ref<Boolean>(false);
let errors = ref<any[]>([]);
const tags = ref<string[]>([]);

const onAdd = function (event: any) {
  console.log("event: ", event);
  tags.value.push(event);
};

const onChange = function (event: any) {
  console.log("event: ", event);
};

const onDelete = function (event: any) {
  console.log("on Delete: ", event);
  tags.value.pop();
};

onMounted(() => {
  tags.value = [];
  load();
});

function edit() {
  editing.value = !editing.value;
}

onBeforeRouteLeave(() => {
  console.log("route-updated");
});

watch(
  () => route.params,
  (__, _) => {
    load();
  }
);

async function cancel() {
  loading.value = false;
  editing.value = false;
  errors.value = [];
}

async function save() {
  loading.value = true;
  console.log("saving...", route.params.id);
  try {
    var res = (
      await new httpClient().post(`tag-identifiers/addAll`, {
        tagId: route.params.id,
        utterances: tags.value,
        clear: true,
      })
    ).data as WrapperDto<TagIdentifier>;
    console.log("response: ", res);

    if (res.success || res.datas != null) {
      response.value = res.datas;
      tags.value = res.datas?.map((data) => data.utterance ?? "") ?? [];
      editing.value = false;
    } else throw Error(res.message);
  } catch (e) {
    response.value = null;
    error.value = e;
    ErrorHandlerUtil.handle(e, toast, router);
  } finally {
    loading.value = false;
  }
}

async function load() {
  loading.value = true;
  console.log("loading...", route.params.id);
  try {
    var res = (
      await new httpClient().get(`tag-identifiers/${route.params.id}`, {
        id: route.params.id,
      })
    ).data as WrapperDto<TagIdentifier>;
    console.log("response: ", res);

    if (res.success || res.datas != null) {
      response.value = res.datas;
      tags.value = res.datas?.map((data) => data.utterance ?? "") ?? [];
    } else throw Error(res.message);
  } catch (e) {
    response.value = null;
    error.value = e;
    ErrorHandlerUtil.handle(e, toast, router);
  } finally {
    loading.value = false;
  }
}
</script>

<!-- 
value?: any, type?: string, min?: number, max?: number,height?: number, error?: any, cls?: any, errors?: any[], name?: string,
editing: boolean, placeholder?: string, enabled?: boolean, tags?: any[], deletable?: boolean, link?: string, options?: any[],
property?: any, drop_on_focus?: boolean, option_name?: string, can_add?: boolean, text_alignments?: string, custom_value?: any -->
