<template>
  <section>
    <div class="flex flex-row">
      <web-image
        class="mr-3"
        :link="props.link"
        :height="props.icon_size == null ? 12 : props.icon_size"
        rounded="rounded-full shadow-none"
        :width="props.icon_size == null ? 12 : props.icon_size"
        :padding="0"
      />
      <div class="font-bold my-auto text-left">
        <p class="text-xs truncate">{{ title }}</p>
        <p class="text-xt truncate">
          {{
            props.sub_title != null
              ? props.sub_title.substring(0, 24) + " ..."
              : props.sub_title
          }}
        </p>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
// import { useI18n } from "../../i18n";
import webImage from "./web-image.vue";

const props = withDefaults(
  defineProps<{
    link?: string;
    title?: string;
    sub_title: string;
    icon_size: number;
  }>(),
  {}
);
// const t = useI18n();
</script>

<style></style>
