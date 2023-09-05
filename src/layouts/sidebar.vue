<template>
  <section
    class="h-screen capitalize dark:text-white text-gray-700 font-semibold"
    :class="{
      ' absolute w-12 h-11 bg-transparent': screen == 'sm',
      'bg-sidebar-light dark:bg-sidebar-dark': screen != 'sm',
      'w-72': screen == 'lg',
    }"
  >
    <div class="pt-2">
      <div v-if="type === 'regular' || type == null" class="relative">
        <div
          @click.stop="emit('on-sideview')"
          class="absolute cursor-pointer right-3"
          :class="{
            'inset-x-1/3 mt-2': props.screen == 'md',
            'inset-x-1/3': props.screen == 'sm',
            'right-3': props.screen == 'lg',
          }"
        >
          <v-icon
            cls="dark:text-gray-200"
            :size="5"
            fill="text-gray-600"
            icon="list"
          />
        </div>

        <div
          class="ml-5 mt-2"
          :class="{ hidden: props.screen != 'lg', flex: props.screen == 'lg' }"
        >
          <div
            class="mr-3 cursor-pointer rounded-full hover:shadow-lg"
            @click="emit('on-home-clicked')"
          >
            <web-image
              class=""
              :link="icon_link"
              :height="7"
              rounded="shadow-none rounded-lg "
              :width="7"
              :padding="0"
            />
          </div>
          <div class="font-bold my-auto text-left">
            <p class="text-base truncate ...">
              {{
                route.path.split("/").length > 2
                  ? route.path.split("/")[1]
                  : "Linko AI"
              }}
            </p>
          </div>
        </div>
      </div>

      <div class="pl-1 mt-5" v-if="props.screen != 'sm'">
        <avatarwithtext
          v-if="showCompany && props.screen != 'md'"
          class="bg-accentlight-light select-none font-bold py-2 pl-2 dark:bg-accentlight-dark rounded-2xl mx-3"
          :link="user.avatar"
          :title="user.fullName"
          :icon_size="7"
          :sub_title="user.phoneNumber"
          :class="{ '': screen == 'md' }"
        />

        <div class="pb-16">
          <slot> </slot>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import vIcon from "../components/icons/v-icon.vue";
import webImage from "../components/common/web-image.vue";
import Avatarwithtext from "../components/common/avatarwithtext.vue";
import { useI18n } from "../i18n";
import { useStore } from "../store";
import { computed } from "vue";
import { useRoute } from "vue-router";

const route = useRoute();

const { t } = useI18n();

const store = useStore();

const user = computed(() => store.getters.user);

const props = withDefaults(
  defineProps<{
    icon_link?: string;
    title?: string;
    type?: string;
    screen?: string;
    showCompany?: boolean;
  }>(),
  { showCompany: true }
);

const emit = defineEmits<{
  (event: "on-home-clicked"): void;
  (event: "on-sideview"): void;
}>();
</script>

<style></style>
