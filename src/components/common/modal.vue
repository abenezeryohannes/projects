<template>
  <section
    name="modal"
    v-if="show"
    class="text-gray-700 dark:text-white w-screen h-screen fixed block left-0 z-40 transition-opacity ease-in-out duration-200"
  >
    <div class="relative">
      <div
        @click="clickedOutside"
        class="modal-mask bg-background-dark w-full h-full top-0 left-0 fixed z-40 dark:bg-background-light opacity-20"
      ></div>
      <div
        class="modal-container px-5 pt-5 pb-3 absolute top-1/2 md:left-1/4 md:right-1/4 left-10 right-10 transform -translate-x-3/2 -translate-y-3/2 z-50 rounded-lg shadow-lg bg-background-light dark:bg-background-deepdark"
      >
        <div class="text-left">
          <div class="pl-5">
            <div class="mr-14">
              <div class="font-semibold text-lg">
                <slot name="header"> </slot>
              </div>

              <div class="font-normal text-md pt-5">
                <slot> </slot>
              </div>
            </div>

            <div class="flex justify-end mt-8">
              <slot name="footer"> </slot>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { ref } from "vue";
withDefaults(
  defineProps<{
    top?: number;
    show?: boolean;
  }>(),
  {
    show: false,
  }
);

let id = ref<string>("none");
let autoClose = ref<boolean>(true);

defineExpose({
  open,
  close,
});

const emit = defineEmits<{
  (event: "on-show", params: boolean): void;
}>();

function close() {
  emit("on-show", false);
}
function open(idd: string) {
  id.value = idd;
  emit("on-show", true);
}
function clickedOutside() {
  if (autoClose == null || autoClose) {
    close();
  }
}
</script>

<style></style>
