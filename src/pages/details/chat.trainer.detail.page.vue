<template>
  <section class="w-full" v-if="route.query.intent != null">
    <add-chat-trainer-modal
      @on-change="
        loadDoc();
        loadAnswer();
      "
      ref="addUtteranceModel"
    />
    <div class="">
      <div class="relative">
        <div class="flex justify-between items-start mb-5">
          <search-table-form
            class="w-full mr-10"
            @on-change="
              search = $event;
              loadDoc();
              loadAnswer();
            "
            @on-page-change="
              doc_page = $event;
              loadDoc();
              loadAnswer();
            "
            @on-view-change="
              doc_view = $event;
              ans_view = $event;
            "
            :value="search"
            :view_controller="true"
            :page="doc_page"
            placeholder="Search..."
            :response="doc_response"
          />
          <div class="flex">
            <div
              :class="[
                {
                  'flex hover:bg-accent-light hover:text-white dark:hover:bg-accent-dark mr-3 cursor-pointer rounded-xl shadow-lg px-5 py-3 font-bold': true,
                },
                {
                  'bg-accent-light dark:bg-accent-dark text-white':
                    language == 'en',
                },
                {
                  'dark:bg-background-deepdark': language != 'en',
                },
              ]"
              @click="
                language = 'en';
                loadDoc();
                loadAnswer();
              "
            >
              English
            </div>
            <div
              :class="[
                {
                  'flex hover:bg-accent-light hover:text-white dark:hover:bg-accent-dark  mr-3 cursor-pointer rounded-xl shadow-lg px-5 py-3 font-bold': true,
                },
                {
                  'bg-accent-light dark:bg-accent-dark text-white':
                    language == 'ar',
                },
                {
                  'dark:bg-background-deepdark': language != 'ar',
                },
              ]"
              @click="
                language = 'ar';
                loadDoc();
                loadAnswer();
              "
            >
              Arabic
            </div>
            <div
              class="hover:bg-accent-light dark:hover:bg-accent-dark hover:text-white dark:bg-background-deepdark flex items-center justify-center pt-1 pl-2 pr-1 cursor-pointer rounded-xl shadow-lg font-bold"
              @click="addUtteranceModel.open()"
            >
              <v-icon
                cls="dark:text-gray-200"
                :size="8"
                fill="text-gray-600"
                icon="add"
              />
            </div>
          </div>
        </div>

        <div class="md:grid md:grid-cols-2 md:gap-x-10">
          <chat-trainer-data-table
            class="mb-10"
            :view="doc_view"
            :response="doc_response"
            :list="doc_list"
            :clickable="true"
            :loading="doc_loading_table"
            @on-limit-change="
              doc_limit = $event;
              loadDoc();
            "
            @on-sort-change="
              doc_sort_by = $event.sort_by;
              doc_sort = $event.sort;
              loadDoc();
            "
            @on-item-click="onItemClick"
            @on-page-change="
              doc_page = $event;
              loadDoc();
            "
            @update-list="loadDoc()"
          />

          <chat-trainer-data-table
            :view="ans_view"
            :response="ans_response"
            :list="ans_list"
            :clickable="true"
            :loading="ans_loading_table"
            @on-limit-change="
              ans_limit = $event;
              loadAnswer();
            "
            @on-sort-change="
              ans_sort_by = $event.sort_by;
              ans_sort = $event.sort;
              loadAnswer();
            "
            @on-item-click="onItemClick"
            @on-page-change="
              ans_page = $event;
              loadAnswer();
            "
            @update-list="loadAnswer()"
          />
        </div>
        <!-- <div
          v-show="scroll < 100 || scroll == null"
          class="fixed transform ease-in-out z-20 duration-1000 right-10 bottom-10"
        >
          <action-fab
            :loading="loading"
            action="add"
            @on-action="addUtteranceModel.open()"
          />
        </div> -->
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import errorHandlerUtil from "../../data/util/error.handler.util";
import RequestHandler from "../../data/util/request.handler";
import SearchTableForm from "../../components/forms/search.table.form.vue";
// import actionFab from "../components/common/action.fab.vue";
import chatTrainerDataTable from "../tables/chat.trainer.data.table.vue";
import { useRouter } from "vue-router";
import { onBeforeUnmount, onMounted, ref, watch } from "vue";
import { useToast } from "vue-toastification";
import { WrapperDto } from "../../domain/wrapper.dto";
import { ChatTrainer } from "../../domain/chat/entity/chat.trainer.entity";
import { useRoute } from "vue-router";
import addChatTrainerModal from "../modals/add.chat-trainer.modal.vue";
import vIcon from "../../components/icons/v-icon.vue";

let scroll = ref<number>(0);
// let loading = ref<boolean>(false);
let addUtteranceModel = ref<any>();
const language = ref<String>("en");
const route = useRoute();

let doc_response = ref<WrapperDto<ChatTrainer>>(
  new WrapperDto({
    count: 0,
    page: 0,
    total_pages: 1,
    datas: [],
  } as WrapperDto<ChatTrainer>)
);
let ans_response = ref<WrapperDto<ChatTrainer>>(
  new WrapperDto({
    count: 0,
    page: 0,
    total_pages: 1,
    datas: [],
  } as WrapperDto<ChatTrainer>)
);
let search = ref<string | null>(null);
//
let doc_loading_table = ref<boolean>(true);
let doc_page = ref<number>(1);
let doc_list = ref<ChatTrainer[]>([]);
let doc_sort_by = ref<string | null>(null);
let doc_limit = ref<number | null>(null);
let doc_sort = ref<string | null>(null);
let doc_view = ref<string | null>(
  localStorage.getItem("view_type_chat_trainer_detail")
);
//
let ans_loading_table = ref<boolean>(true);
let ans_page = ref<number>(1);
let ans_list = ref<ChatTrainer[]>([]);
let ans_sort_by = ref<string | null>(null);
let ans_limit = ref<number | null>(null);
let ans_sort = ref<string | null>(null);
let ans_view = ref<string | null>(
  localStorage.getItem("view_type_chat_trainer_detail")
);

watch(
  () => doc_view.value,
  (val, _) => {
    if (val != null)
      localStorage.setItem("view_type_chat_trainer_detail", val!);
  }
);

watch(
  () => route.params,
  (__, _) => {
    loadDoc();
    loadAnswer();
  }
);

onMounted(() => {
  window.addEventListener("scroll", handleScroll);
  loadDoc();
  loadAnswer();
});

onBeforeUnmount(() => {
  window.removeEventListener("scroll", handleScroll);
});

function handleScroll() {
  scroll.value = window.scrollY; // || window.screenTop
}

function onItemClick(event: any) {
  console.log("-----clicked----", event);
  // router.push({
  //   name: "chat-trainer-intent",
  //   params: { intent: doc_list.value[event.index].intent },
  // });
}

// function onUtteranceAdded() {
//   addUtteranceModel.value.open();
// }
// function changeRoleType() {
//   load();
// }

async function loadDoc() {
  if (route.query.intent == null) return;
  doc_loading_table.value = true;
  // console.log('loading .... role_type', this.role_type, this.enabled);
  try {
    const res = (
      await new RequestHandler().get("chat-trainers", {
        intent: route.query.intent,
        language: language.value,
        command: "addDocument",
        search: search.value,
        sort: doc_sort.value,
        sort_by: doc_sort_by.value,
        page: doc_page.value,
        limit: doc_limit.value,
      })
    ).data as WrapperDto<ChatTrainer>;
    console.log("res", res);
    doc_response.value = res;
    if ((res.datas?.length ?? 0) > 0)
      doc_list.value = (res as WrapperDto<ChatTrainer>).datas ?? [];
    else doc_list.value = [];
  } catch (e) {
    errorHandlerUtil.handle(e, useToast(), useRouter());
  } finally {
    doc_loading_table.value = false;
  }
}

async function loadAnswer() {
  if (route.query.intent == null) return;
  ans_loading_table.value = true;
  // console.log('loading .... role_type', this.role_type, this.enabled);
  try {
    const res = (
      await new RequestHandler().get("chat-trainers", {
        intent: route.query.intent,
        language: language.value,
        command: "writeAnswer",
        search: search.value,
        sort: ans_sort.value,
        sort_by: ans_sort_by.value,
        page: ans_page.value,
        limit: ans_limit.value,
      })
    ).data as WrapperDto<ChatTrainer>;
    console.log("res", res);
    ans_response.value = res;
    if ((res.datas?.length ?? 0) > 0)
      ans_list.value = (res as WrapperDto<ChatTrainer>).datas ?? [];
    else ans_list.value = [];
  } catch (e) {
    errorHandlerUtil.handle(e, useToast(), useRouter());
  } finally {
    ans_loading_table.value = false;
  }
}
</script>

<style></style>
