<template>
  <div
    class="shadow-md my-auto rounded-full bg-background-lightish dark:bg-background-darkish"
    :class="['h-' + size, 'w-' + size, 'p-' + padding]"
  >
    <img
      v-if="link"
      :src="media_link + '?path=' + link"
      class="rounded-full w-full h-full"
    />
    <div v-if="svg" class="rounded-full w-full h-full">
      <v-icon
        :icon="svg"
        :size="size - 2 * padding"
        fill="icon-light"
        cls="dark:text-icon-dark"
      />
    </div>
  </div>
</template>

<script>
import { constants } from "../../constants";
import vIcon from "../icons/v-icon.vue";
export default {
  components: { vIcon },
  props: {
    link: {
      type: String,
      required: false,
    },
    svg: {
      type: String,
      required: false,
    },
    size: {
      type: Number,
      default: 8,
    },
    padding: {
      type: Number,
      default: 2,
    },
  },
  data: () => {
    return {
      media_link: constants.MEDIA_LINK,
    };
  },
};
</script>

<style></style>
