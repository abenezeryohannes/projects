<template>
  <div class="relative w-full ml-10 h-screen mt-1">
    <div
      class="mb-10"
      v-if="$route.params.id != null && selectedTags.length > 0"
    >
      <p class="font-bold capitalize flex justify-start pb-5 pl-3 text-lg">
        {{ "selected tags" }}
      </p>
      <tagInputForm
        :editing="false"
        :can_add="false"
        :deletable="false"
        :value="selectedTags"
        @on-change="onChange"
        @on-add="onAdd"
        @on-delete="onDelete"
        link="tags"
        :height="100"
      />
    </div>

    <div v-if="$route.params.id != null" v-for="type in tagTypes" :key="type">
      <div class="capitalize w-full mb-6">
        <p class="font-extrabold text-base flex justify-start py-3">
          {{ type }}
        </p>
        <div class="flex flex-wrap justify-start">
          <div
            class=""
            v-for="tag in tags.filter(
              (t) => t.type?.toLowerCase() == type.toLowerCase()
            )"
          >
            <div
              v-if="
                selectedTags.length > 0 &&
                selectedTags.filter((t) => t.id == tag.id).length > 0
              "
              class="rounded-full text-white shadow-md px-3 py-2 m-1 bg-accent-light dark:bg-accent-dark cursor-pointer"
              @click="onTagClicked(tag)"
            >
              <p class=" ">{{ tag.name }}</p>
            </div>
            <div
              v-else
              class="rounded-full shadow-md px-3 py-2 m-1 bg-background-light dark:bg-background-dark cursor-pointer"
              @click="onTagClicked(tag)"
            >
              <p class=" ">{{ tag.name }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>

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
import { Company } from "../../domain/company/entity/company.entity";
import { Tag } from "../../domain/company/entity/tag.entity";

let loading = ref<Boolean>(false);
let company = ref<any>(null);
let response = ref<any>(null);
let error = ref<any>(null);
const router = useRouter();
const route = useRoute();
const toast = useToast();
let editing = ref<Boolean>(false);
let errors = ref<any[]>([]);
const tags = ref<Tag[]>([]);
const tagTypes = ref<string[]>([]);
const selectedTags = ref<Tag[]>([]);

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
  loadCompanyTag();
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
    loadCompanyTag();
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
      await new httpClient().post(`companies/${route.params.id}/edit`, {
        tags: selectedTags.value.map((t) => t.id),
      })
    ).data as WrapperDto<TagIdentifier>;
    console.log("response: ", res);

    if (res.success || res.datas != null) {
      response.value = res.datas;
      editing.value = false;
      // tags.value = res.datas?.map((data) => data.utterance ?? "") ?? [];
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
      await new httpClient().get(`tags`, {
        limit: 1000,
      })
    ).data as WrapperDto<Tag>;
    console.log("response: ", res);

    if (res.success || res.datas != null) {
      response.value = res.datas;
      tags.value = res.datas?.map((data) => data) ?? [];
      tagTypes.value = res.datas?.map((data) => data.type ?? "") ?? [];
      tagTypes.value = tagTypes.value.filter(
        (f, index) => tagTypes.value.indexOf(f) == index
      );
    } else throw Error(res.message);
  } catch (e) {
    response.value = null;
    error.value = e;
    ErrorHandlerUtil.handle(e, toast, router);
  } finally {
    loading.value = false;
  }
}

async function loadCompanyTag() {
  loading.value = true;
  console.log("loading...", route.params.id);
  try {
    var res = (
      await new httpClient().get(`companies/${route.params.id}`, {
        id: route.params.id,
      })
    ).data as WrapperDto<Company>;
    console.log("company: ", res);

    if (res.success || res.datas != null) {
      company.value = res.data;
      selectedTags.value = res.data?.tags?.map((data) => data) ?? [];
    } else throw Error(res.message);
  } catch (e) {
    company.value = null;
    error.value = e;
    ErrorHandlerUtil.handle(e, toast, router);
  } finally {
    loading.value = false;
  }
}

function isSelected(tag: Tag): boolean {
  return (
    selectedTags.value.length > 0 &&
    selectedTags.value.filter((t) => t.id == tag.id).length > 0
  );
}

// const isSelected = computed((tag: Tag) => {
//   return (
//     selectedTags.value.length > 0 &&
//     selectedTags.value.filter((t) => t.id == tag.id).length > 0
//   );
// });

function onTagClicked(tag: Tag) {
  if (!editing.value) return;
  if (!isSelected(tag)) {
    let temp = selectedTags.value;
    temp.push(tag);
    selectedTags.value = temp;
  } else {
    selectedTags.value = selectedTags.value.filter((s) => s.id != tag.id);
  }
}
</script>

<!-- 
value?: any, type?: string, min?: number, max?: number,height?: number, error?: any, cls?: any, errors?: any[], name?: string,
editing: boolean, placeholder?: string, enabled?: boolean, tags?: any[], deletable?: boolean, link?: string, options?: any[],
property?: any, drop_on_focus?: boolean, option_name?: string, can_add?: boolean, text_alignments?: string, custom_value?: any -->
