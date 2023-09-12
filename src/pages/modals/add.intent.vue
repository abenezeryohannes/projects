<template>
  <modal class="w-5/12" ref="Modal" :show="show" @on-show="show = $event">
    <template v-slot:header>
      <p class="text-xl font-bold text-left capitalize">
        {{ t("New Intent") }}
      </p>
    </template>

    <section class="">
      <div class=" ">
        <add-intent-forms
          class=" "
          :editing="editing"
          :loading="loading"
          :errors="errors"
          :temp_intent="temp_intent"
          @on-name-change="temp_intent.intent = $event"
          @on-ar-ans-change="temp_intent.arAns = $event"
          @on-en-ans-change="temp_intent.enAns = $event"
          @on-ar-doc-change="temp_intent.arDoc = $event"
          @on-en-doc-change="temp_intent.enDoc = $event"
          @on-icon-change="icon = $event"
        />
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
import addIntentForms from "../forms/add.intent.forms.vue";
import EditFab from "../../components/common/edit.fab.vue";
import modal from "../../components/common/modal.vue";
import { ref } from "vue";
import errorHandlerUtil from "../../data/util/error.handler.util";
import { useRouter } from "vue-router";
import { useToast } from "vue-toastification";
import RequestHandler from "../../data/util/request.handler";
import { useI18n } from "../../i18n";
import { ChatTrainer } from "../../domain/chat/entity/chat.trainer.entity";
// import { WrapperDto } from "../../domain/wrapper.dto";

const { t } = useI18n();

// const route = useRoute();
const editing = ref<boolean>(false);
const loading = ref<boolean>(false);
const errors = ref<any>(null);
const temp_intent = ref<any | undefined | null>({
  enDoc: [],
  arDoc: [],
  enAns: [],
  arAns: [],
});
const Modal = ref<any>(null);
const show = ref<boolean>(false);
const icon = ref<any>();
const router = useRouter();
const toast = useToast();

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
}

function cancel() {
  editing.value = false;
  loading.value = false;
  errors.value = null;
  close();
}

function close() {
  Modal.value?.close();
}

function open() {
  editing.value = true;
  Modal.value?.open();
}

async function save() {
  try {
    loading.value = true;
    console.log("request body: ", temp_intent.value);
    console.log("request qqq", await prepare());
    var response = await new RequestHandler().post(
      "chat-trainers/addAll",
      await prepare()
    );
    console.log(response.status, response);
    emit("on-change");
    // close();
  } catch (e) {
    errorHandlerUtil.handle(e, toast, router);
  } finally {
    loading.value = false;
  }
}

async function prepare(): Promise<ChatTrainer[]> {
  const resp: ChatTrainer[] = [];
  if (
    temp_intent.value.enDoc != null &&
    temp_intent.value.enDoc != undefined &&
    Array.isArray(temp_intent.value.enDoc) &&
    (temp_intent.value.enDoc as Array<String>).length > 0
  ) {
    const enDoc: ChatTrainer = new ChatTrainer();
    enDoc.command = "addDocument";
    enDoc.intent = temp_intent.value.intent;
    enDoc.language = "en";
    enDoc.utterance = temp_intent.value.enDoc;
    resp.push(enDoc);
  }

  if (
    temp_intent.value.enAns != null &&
    temp_intent.value.enAns != undefined &&
    Array.isArray(temp_intent.value.enAns) &&
    (temp_intent.value.enAns as Array<String>).length > 0
  ) {
    const enAns: ChatTrainer = new ChatTrainer();
    enAns.command = "writeAnswer";
    enAns.intent = temp_intent.value.intent;
    enAns.language = "en";
    enAns.utterance = temp_intent.value.enAns;
    resp.push(enAns);
  }

  if (
    temp_intent.value.arDoc != null &&
    temp_intent.value.arDoc != undefined &&
    Array.isArray(temp_intent.value.arDoc) &&
    (temp_intent.value.arDoc as Array<String>).length > 0
  ) {
    const arDoc: ChatTrainer = new ChatTrainer();
    arDoc.command = "addDocument";
    arDoc.intent = temp_intent.value.intent;
    arDoc.language = "ar";
    arDoc.utterance = temp_intent.value.arDoc;
    resp.push(arDoc);
  }

  if (
    temp_intent.value.arAns != null &&
    temp_intent.value.arAns != undefined &&
    Array.isArray(temp_intent.value.arAns) &&
    (temp_intent.value.arAns as Array<String>).length > 0
  ) {
    const arAns: ChatTrainer = new ChatTrainer();
    arAns.command = "writeAnswer";
    arAns.intent = temp_intent.value.intent;
    arAns.language = "ar";
    arAns.utterance = temp_intent.value.arAns;
    resp.push(arAns);
  }

  return resp;
}

// async function load() {
//   try {
//     loading.value = true;
//     var response = (
//       await new RequestHandler().get("tags/" + route.params.id, {})
//     ).data as WrapperDto<Tag>;
//     temp_intent.value = response.data;
//     //console.log('load', response);
//   } catch (e) {
//     errorHandlerUtil.handle(e, toast, router);
//   } finally {
//     loading.value = false;
//   }
// }
</script>

<style></style>
