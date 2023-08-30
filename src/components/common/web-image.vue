<template>
  <div
    class="my-auto"
    :class="[
      'h-' + (height > 1000 ? 'full' : height),
      'w-' + (width > 1000 ? 'full' : width),
      'p-' + padding,
    ]"
  >
    <full-screen-image
      :link="constants.MEDIA_LINK + props.link"
      :file="local_image_file"
      :show="showBig"
      @on-close="showBig = !showBig"
    />

    <img
      @click="clicked"
      v-if="local_image_file"
      v-lazy="showFile"
      width="500"
      height="600"
      :class="[
        'w-full h-full',
        scale,
        rounded,
        { 'cursor-pointer': clickable },
      ]"
    />

    <img
      @click="clicked"
      v-else-if="props.link"
      v-lazy="constants.MEDIA_LINK + props.link"
      width="500"
      height="600"
      :class="[
        ' w-full h-full ',
        scale,
        rounded,
        { 'cursor-pointer': clickable },
      ]"
    />

    <div
      v-else
      class="w-full h-full object-center object-cover"
      :class="[rounded]"
    />
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from "vue";
import { constants } from "../../constants";
import fullScreenImage from "./fullscreen-image.vue";

const props = withDefaults(
  defineProps<{
    rounded?: string;
    clickable?: boolean;
    link?: string;
    local_image_file?: File;
    scale?: string;
    height?: number;
    width?: number;
    padding?: number;
  }>(),
  {
    rounded: "rounded-full",
    clickable: false,
    scale: "object-center object-fit",
    height: 8,
    width: 8,
    padding: 2,
  }
);

const showBig = ref<boolean>(false);

const showFile = computed(() => {
  if (props.local_image_file == null) return null;
  // console.log(this.local_image_file);
  const res = URL.createObjectURL(props.local_image_file);
  // console.log('localurl', res);
  return res;
});

function clicked() {
  console.log(constants.MEDIA_LINK + props.link);
  if (props.clickable) showBig.value = !showBig.value;
}
</script>

<style></style>
