<template>
  <modal class="w-5/12" ref="Modal" :show="show" @on-show="show = $event">
    <template v-slot:header>
      <p class="text-xl font-bold text-left capitalize">
        {{ "New Utterances" }}
      </p>
    </template>

    <!-- <section v-if="command == null" class="flex justify-evenly py-20">
      <div
        class="lg:px-20 lg:py-10 px-5 py-5 mr-5 shadow-lg rounded-xl hover:bg-background-light dark:hover:bg-background-dark bg-background-lightish dark:bg-background-darkish cursor-pointer font-bold"
        @click="command = 'addDocument'"
      >
        <div class="py-2">
          <v-icon
            cls="dark:text-gray-200"
            :size="24"
            fill="text-gray-600"
            icon="inbox"
          />
        </div>
        <p>Add Document</p>
      </div>

      <div
        class="lg:px-20 lg:py-10 px-5 py-5 shadow-lg rounded-xl bg-background-lightish hover:bg-background-light dark:hover:bg-background-dark dark:bg-background-darkish cursor-pointer font-bold"
        @click="command = 'writeDocument'"
      >
        <div class="py-2 0">
          <v-icon
            cls="dark:text-gray-200"
            :size="24"
            fill="text-gray-600"
            icon="chat-icon"
          />
        </div>
        <p>Write Document</p>
      </div>
    </section> -->

    <section class="w-full pl-3">
      <div class="flex justify-end mb-5 gap-x-5">
        <div
          :class="[
            {
              'cursor-pointer rounded-xl shadow-lg px-5 py-3 font-bold': true,
            },
            {
              'bg-red-500 text-white': language == 'ar',
            },
          ]"
          @click="language = 'ar'"
        >
          Arabic
        </div>
        <div
          :class="[
            {
              'cursor-pointer mr-5 rounded-xl shadow-lg px-5 py-3 font-bold': true,
            },
            {
              'bg-red-500 text-white': language == 'en',
            },
          ]"
          @click="language = 'en'"
        >
          English
        </div>
      </div>

      <div class="w-full md:grid lg:grid-cols-2 lg:gap-x-10 block">
        <div class="w-full font-bold">
          <p class="font-bold text-base mb-3">Add Document</p>
          <add-chat-training-form
            :editing="editing"
            :loading="loading"
            cls-list="overflow-y-auto  max-h-96"
            :errors="errors"
            :temp_utterance="doc_temp_utterance"
            @on-change="doc_temp_utterance = $event"
            @on-icon-change="icon = $event"
          />
        </div>
        <div class="w-full font-bold">
          <p class="font-bold text-base mb-3">Write Answer</p>

          <add-chat-training-form
            :editing="editing"
            :loading="loading"
            cls-list="overflow-y-auto  max-h-96"
            :errors="errors"
            :temp_utterance="ans_temp_utterance"
            @on-change="ans_temp_utterance = $event"
            @on-icon-change="icon = $event"
          />
        </div>
      </div>
      <edit-fab
        class="fixed right-0 mr-5 bottom-5"
        :editing="editing"
        :errors="errors"
        :loading="loading"
        @edit="edit"
        @save="save"
        @cancel="cancel"
      />
    </section>
  </modal>
</template>

<script setup lang="ts">
import addChatTrainingForm from "../forms/add.chat.training.form.vue";
import EditFab from "../../components/common/edit.fab.vue";
import modal from "../../components/common/modal.vue";
import { ref } from "vue";
import errorHandlerUtil from "../../data/util/error.handler.util";
import { useRouter } from "vue-router";
import { useToast } from "vue-toastification";
import RequestHandler from "../../data/util/request.handler";
import { useRoute } from "vue-router";
// import vIcon from "../../components/icons/v-icon.vue";

// const route = useRoute();
const editing = ref<boolean>(false);
const loading = ref<boolean>(false);
const errors = ref<any>(null);
const doc_temp_utterance = ref<String[] | undefined | null>();
//
//

const ans_editing = ref<boolean>(false);
const ans_loading = ref<boolean>(false);
const ans_errors = ref<any>(null);
const ans_temp_utterance = ref<String[] | undefined | null>();
//
//
const Modal = ref<any>(null);
const show = ref<boolean>(false);
const icon = ref<any>();
const router = useRouter();
const route = useRoute();
const toast = useToast();
// const languages = ["en", "am"];
const language = ref<String>("en");
// const commands = ["addDocument", "writeAnswer"];
const command = ref<String | null>(null);
//0973295637

const emit = defineEmits<{
  (event: "on-change"): void;
}>();

defineExpose({
  open,
});

// function created() { window.addEventListener('scroll', handleScroll); }
// function destroyed() { window.removeEventListener('scroll', handleScroll); }
function edit() {
  editing.value = true;
  loading.value = false;
  ans_editing.value = true;
  ans_loading.value = false;
}

function cancel() {
  editing.value = false;
  loading.value = false;
  errors.value = null;
  ans_editing.value = false;
  ans_loading.value = false;
  ans_errors.value = null;
  close();
}

function close() {
  Modal.value?.close();
}

function open() {
  editing.value = true;
  doc_temp_utterance.value = null;
  command.value = null;
  Modal.value?.open();
}

async function save() {
  try {
    // console.log("utterance: ", doc_temp_utterance.value);
    loading.value = true;
    ans_loading.value = true;
    var response = await new RequestHandler().post("chat-trainers/addAll", [
      {
        intent: route.query.intent,
        utterance: doc_temp_utterance.value,
        language: language.value,
        command: "addDocument",
      },
      {
        intent: route.query.intent,
        utterance: ans_temp_utterance.value,
        language: language.value,
        command: "writeAnswer",
      },
    ]);
    console.log(response.status, response);
    emit("on-change");
    close();
  } catch (e) {
    errorHandlerUtil.handle(e, toast, router);
  } finally {
    loading.value = false;
    ans_loading.value = false;
  }
}

// async function load() {
//   try {
//     loading.value = true;
//     var response = (
//       await new RequestHandler().get("tags/" + route.params.id, {})
//     ).data as WrapperDto<Tag>;
//     temp_utterance.value = response.data;
//     //console.log('load', response);
//   } catch (e) {
//     errorHandlerUtil.handle(e, toast, router);
//   } finally {
//     loading.value = false;
//   }
// }
</script>

<style></style>
