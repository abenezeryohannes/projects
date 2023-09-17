<template>
  <div
    class="flex h-96 mb-5 w-full justify-between bg-red-50 dark:bg-background-deepdark rounded-xl px-10 py-10 shadow-sm"
  >
    <div class="text-left">
      <p class="font-bold text-3xl mb-2">Retrain AI</p>
      <p class="font-medium text-base w-7/12 mt-5">
        This will retrain the AI after wiping previous training with all
        provided data from the dashboard
      </p>
      <div class="flex">
        <p
          @click="train()"
          class="px-10 py-3 text-base rounded-lg mt-12 cursor-pointer font-bold shadow-sm hover:bg-primary-dark dark:hover:bg-primary-dark text-white bg-accent-light dark:bg-accent-dark"
        >
          {{ loading ? "Training..." : "Train Now" }}
        </p>
      </div>
    </div>
    <div>
      <img :src="myLogoSrc" width="300" height="350" alt="my-logo" />
      <!-- <img
        v-lazy="'/src/assets/public/ai.png'"
        width="600"
        height="600"
        :class="[' w-full h-full object-contain ']"
      /> -->
    </div>
  </div>
</template>

<script setup lang="ts">
import errorHandlerUtil from "../../data/util/error.handler.util";
import RequestHandler from "../../data/util/request.handler";
import { useToast } from "vue-toastification";
import { onBeforeUnmount, onMounted, ref, watch } from "vue";
import { useRouter } from "vue-router";
import VIcon from "../../components/icons/v-icon.vue";
import myLogoSrc from "../../assets/public/ai5.svg";

import { WrapperDto } from "../../domain/wrapper.dto";
let result = ref<any>(null);
let loading = ref<boolean>(false);
let response = ref<WrapperDto<any> | null>(null);

async function train() {
  if (loading.value) return;
  console.log("training...");
  loading.value = true;
  // console.log('loading .... role_type', this.role_type, this.enabled);
  try {
    const res = (await new RequestHandler().post("chat-trainers/train", {}))
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
