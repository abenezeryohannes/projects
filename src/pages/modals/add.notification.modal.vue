<template>
  <modal class="w-5/12" ref="Modal" :show="show" @on-show="show = $event">
    <template v-slot:header>
      <p class="text-xl font-bold text-left capitalize">
        {{ t("New Business") }}
      </p>
    </template>

    <section class="">
      <div class=" ">
        <add-notification-forms
          class=" "
          :editing="editing"
          :loading="loading"
          :errors="errors"
          :temp_notification="temp_notification"
          @on-change="temp_notification = $event"
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
import EditFab from "../../components/common/edit.fab.vue";
import modal from "../../components/common/modal.vue";
import { ref } from "vue";
import errorHandlerUtil from "../../data/util/error.handler.util";
import { useRouter } from "vue-router";
import { useToast } from "vue-toastification";
import RequestHandler from "../../data/util/request.handler";
import { useI18n } from "../../i18n";
import addNotificationForms from "../forms/add.notification.forms.vue";
// import { WrapperDto } from "../../domain/wrapper.dto";
import { Company } from "../../domain/company/entity/company.entity";

const { t } = useI18n();

// const route = useRoute();
const editing = ref<boolean>(false);
const loading = ref<boolean>(false);
const errors = ref<any>(null);
const temp_notification = ref<Company | undefined | null>({ isActive: true });
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
    console.log("request body: ", temp_notification.value);
    var response = await new RequestHandler().post(
      "notifications/send",
      temp_notification.value
    );
    console.log(response.status, response);
    emit("on-change");
    close();
  } catch (e) {
    errorHandlerUtil.handle(e, toast, router);
  } finally {
    loading.value = false;
  }
}

// async function load() {
//   try {
//     loading.value = true;
//     var response = (
//       await new RequestHandler().get("tags/" + route.params.id, {})
//     ).data as WrapperDto<Tag>;
//     temp_notification.value = response.data;
//     //console.log('load', response);
//   } catch (e) {
//     errorHandlerUtil.handle(e, toast, router);
//   } finally {
//     loading.value = false;
//   }
// }
</script>

<style></style>
