<template>
  <!-- <transition name="fade">  -->

  <div
    @click="$emit('on-close')"
    v-if="show"
    id="image-screen"
    class="w-full h-full fixed flex justify-center items-center top-0 left-0 z-30 bg-opacity-50 dark:bg-background-lightish bg-background-darkish dark:bg-opacity-50"
  >
    <div class="img-zoom-container">
      <img
        @click.stop=""
        id="myimage"
        v-if="props.link"
        v-lazy="constants.MEDIA_LINK + props.link"
        class="transition w-10/12 h-10/12 shadow-md object-center object-cover"
      />
    </div>
  </div>
  <!-- </transition> -->
</template>

<script setup lang="ts">
import { ref, watch } from "vue";
import { constants } from "../../constants";
const props = defineProps<{
  link: string;
  show: boolean;
}>();
const showBig = ref<boolean>(true);
function imageZoom(imgID: any, resxultID: any) {
  console.log(imgID, resultID);
}

watch(
  () => props.show,
  (now, _) => {
    if (now) imageZoom("myimage", "myresult");
  }
);
</script>

<style>
/* .fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
} */
</style>
