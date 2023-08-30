<template>
  <modal class="w-5/12" ref="Modal" :show="show" @on-show="show = $event">
    <template v-slot:header>
      <p class="text-xl font-bold text-left capitalize">
        {{ t("New Tag") }}
      </p>
    </template>

    <section class="">
      <div class=" ">
        <add-tag-forms
          class=" "
          :editing="editing"
          :loading="loading"
          :errors="errors"
          :temp_tag="temp_tag"
          @on-change="temp_tag = $event"
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
import addTagForms from "../forms/add.tag.forms.vue";
import EditFab from "../../components/common/edit.fab.vue";
import modal from "../../components/common/modal.vue";
import { ref } from "vue";
import errorHandlerUtil from "../../data/util/error.handler.util";
import { useRouter } from "vue-router";
import { useToast } from "vue-toastification";
import RequestHandler from "../../data/util/request.handler";
import { useI18n } from "../../i18n";
// import { WrapperDto } from "../../domain/wrapper.dto";
import { Tag } from "../../domain/company/entity/tag.entity";

const { t } = useI18n();

// const route = useRoute();
const editing = ref<boolean>(false);
const loading = ref<boolean>(false);
const errors = ref<any>(null);
const temp_tag = ref<Tag | undefined | null>({ isActive: true });
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
    var response = await new RequestHandler().post("tags/add", temp_tag.value);
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
//     temp_tag.value = response.data;
//     //console.log('load', response);
//   } catch (e) {
//     errorHandlerUtil.handle(e, toast, router);
//   } finally {
//     loading.value = false;
//   }
// }
</script>

<style></style>
