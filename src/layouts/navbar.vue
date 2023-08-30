<template>
  <section class="w-full h-screen" :class="[{ '  flex': !home }]">
    <div
      v-if="!route.path.includes('/print/')"
      :class="[{ '  ': !home }]"
      class="scrollbar-thin autoscroll scrollbar-thumb-rounded-lg scrollbar-thumb-gray-200 scrollbar-track-gray-50 dark:scrollbar-thumb-background-darkish dark:scrollbar-track-background-deepdark overflow-y-auto"
    >
      <slot name="sidebar"> </slot>
    </div>

    <section
      class="flex flex-grow overflow-hidden"
      :class="[
        { 'col-span-13': !home },
        { 'col-span-16': route.path.includes('/print/') || !slots['sidebar'] },
      ]"
    >
      <div
        class="flex-1 scrollbar-thin autoscroll scrollbar-thumb-rounded-lg scrollbar-thumb-gray-300 scrollbar-track-gray-100 overflow-y-auto dark:scrollbar-thumb-background-darkish dark:scrollbar-track-background-deepdark"
      >
        <div
          v-show="!route.path.includes('/print/') || slots['sidebar']"
          :class="[
            {
              '  bg-background-lightish shadow-none pt-1 dark:bg-background-dark ':
                !home,
            },
            { ' bg-background-white dark:bg-background-deepdark  ': home },
          ]"
          class="flex w-full flex-row justify-between navbar dark:text-white text-gray-700 shadow py-auto"
        >
          <div class="nav-right select-none">
            <ul v-if="home" class="flex pl-5 flex-row h-full">
              <li class="my-auto">
                <div
                  class="dark:hover:bg-opacity-50 dark:hover:bg-background-darkish flex flex-row py-2 px-3 cursor-pointer hover:bg-background-lightish"
                >
                  <img
                    class="h-14 p-2"
                    :src="constants.MEDIA_LINK + 'icons/app_icon.png'"
                  />
                  <p class="ml-3 my-auto text-gray-700 dark:text-white">
                    {{ t("Bandeja") }}
                  </p>
                </div>
              </li>
            </ul>

            <ul v-else class="flex pl-3 flex-row my-auto h-full">
              <li class="my-auto">
                <div class="mr-2 ml-8 mb-1 md:mb-0 md:ml-0" @click="back">
                  <v-icon
                    class="cursor-pointer"
                    icon="arrow-left"
                    :size="7"
                    cls="dark:text-gray-300"
                    fill="gray-500"
                  />
                </div>
              </li>

              <li class="my-auto">
                <p class="text-lg font-bold capitalize">
                  {{ title != null ? t(title) : title }}
                </p>
              </li>
            </ul>
          </div>

          <div
            class="nav-left my-auto select-none items-center relative md:static px-5 md:flex lg:w-1/2"
          >
            <button
              data-collapse-toggle="mobile-menu"
              type="button"
              @click.stop="showNavbarItems = !showNavbarItems"
              class="md:hidden text-gray-400 my-auto hover:text-gray-900 focus:outline-none focus:ring0 rounded-lg inline-flex items-center justify-center"
              aria-controls="mobile-menu-3"
              aria-expanded="false"
            >
              <svg
                class="w-6 h-6"
                fill="currentColor"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fill-rule="evenodd"
                  d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                  clip-rule="evenodd"
                ></path>
              </svg>
              <svg
                class="hidden w-6 h-6"
                fill="currentColor"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fill-rule="evenodd"
                  d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                  clip-rule="evenodd"
                ></path>
              </svg>
            </button>
            <ul
              id="mobile-menu"
              v-if="showNavbar"
              class="flex-col absolute md:relative top-3 z-40 md:top-0 rounded-lg shadow-lg bg-background-light dark:bg-background-deepdark md:dark:bg-background-dark md:bg-background-lightish w-full md:shadow-none md:rounded-none right-5 md:right-0 pl-5 pr-8 py-5 md:px-0 md:py-0 md:flex-row flex mt-4 md:mt-0 md:text-sm gap-y-3 items-start md:font-medium"
            >
              <li class="my-auto w-full hidden md:flex">
                <search-menu class="" :height="8" />
              </li>

              <li
                class="flex flex-row md:ml-5 my-auto px-2 md:px-3 rounded-full cursor-pointer md:dark:hover:bg-background-darkish md:py-2 md:dark:hover:bg-opacity-50 md:hover:bg-background-lightish"
                @click="showProfile"
              >
                <!--                                 <icon-wrapper :link=user.avatar :padding=0 :size=6 />-->
                <web-image
                  class="mr-3"
                  :link="user.avatar"
                  :height="6"
                  rounded="rounded-full shadow-none"
                  :width="6"
                  :padding="0"
                />
                <p class="text-xs my-auto md:ml-2 ml-4 font-semibold">
                  {{ user?.fullName?.split(" ")[0] }}
                </p>
              </li>

              <!-- <li class="md:ml-3 my-auto cursor-pointer flex">
                                <icon-wrapper svg='notification' :padding=1 :size=10 />
                                <p class="text-xs my-auto ml-2 font-semibold md:hidden flex">{{ t('notifications') }}
                                </p>
                            </li> -->

              <li
                class="md:ml-3 my-auto app-nav-item flex cursor-pointer"
                @click="switchTheme"
              >
                <div
                  class="shadow rounded-full bg-background-lightish dark:bg-background-darkish h-10 w-10"
                >
                  <input
                    id="mode-nav-item"
                    class="toggle m-2"
                    type="checkbox"
                    :checked="temp_user.theme?.toLowerCase().startsWith('dark')"
                  />
                </div>
                <p class="text-xs my-auto ml-2 font-semibold md:hidden flex">
                  {{ t("theme") }}
                </p>
              </li>

              <li class="ml-3 my-auto cursor-pointer hidden md:flex">
                <dropdown-nested-menu
                  ref="nested_dropdown"
                  :size="10"
                  svg="arrow-down"
                  :padding="1"
                />
              </li>

              <!-- <li class="my-auto   flex md:hidden cursor-pointer" @click="OnUserClicked">
                                <icon-wrapper svg='users' :padding=2 :size=10 />
                                <p class="text-xs my-auto ml-2 font-semibold">Users</p>
                            </li> -->

              <li
                class="my-auto flex md:hidden cursor-pointer"
                @click="onLogOut"
              >
                <icon-wrapper svg="sign-out" :padding="2" :size="10" />
                <p class="text-xs my-auto ml-2 font-semibold">Logout</p>
              </li>
            </ul>
          </div>
        </div>

        <div
          v-if="loading"
          id="loading-screen"
          class="w-full h-full fixed block top-0 left-0 bg-white dark:bg-background-dark opacity-50 z-50"
        >
          <span
            class="text-green-500 top-1/3 my-0 mx-auto block relative w-0 h-0"
          >
            <div class="custom_loader w-20 h-20" />
          </span>
        </div>
        <slot> </slot>
      </div>
    </section>
  </section>
</template>

<script setup lang="ts">
import dropdownNestedMenu from "../components/navbar/nested_dropdown.menu.vue";
// import IconWrapper from "../components/common/icon.wrapper.vue";
import SearchMenu from "../components/navbar/search.menu.vue";
import ThemeManager from "../data/util/theme.manager.util";
import webImage from "../components/common/web-image.vue";
import VIcon from "../components/icons/v-icon.vue";
import { computed, onBeforeUnmount, onMounted, ref, useSlots } from "vue";
import { useStore } from "../store";
import { useRouter, useRoute } from "vue-router";
import { useI18n } from "../i18n";
import { constants } from "../constants";
import { useBreakpoints } from "../components/common/breakpoints";
import { useToast } from "vue-toastification";
import errorHandlerUtil from "../data/util/error.handler.util";

const store = useStore();
const router = useRouter();
const route = useRoute();
const slots = useSlots();

let loading = ref(false);
let title = ref(null);
let temp_user = JSON.parse(JSON.stringify(store.getters.user));
let home = ref<boolean>(false);
const user = computed(() => store.getters.user);

const { type } = useBreakpoints();
const showNavbarItems = ref<boolean>(false);
const showNavbar = computed(() => type.value != "sm" || showNavbarItems.value);
// onBeforeRouteUpdate((to, from) => {
//     home.value = to.name == 'Home'
// })
const { t } = useI18n();

function switchTheme() {
  const tempUser = user.value;
  tempUser.theme = user.value?.theme?.toLowerCase().startsWith("dark")
    ? "light"
    : "dark";
  store.dispatch("signIn", tempUser);

  ThemeManager.loadTheme(user.value)
    ?.then((theme) => {
      temp_user = user.value;
      temp_user.theme = theme;
      store.commit("setUser", tempUser);
    })
    .catch((e) => {
      errorHandlerUtil.handle(e, useToast(), useRouter());
    });
}

function back() {
  router.go(-1);
}

function showProfile() {
  showNavbarItems.value = false;
  if (router.currentRoute.value.name != "profile")
    router.push({ name: "auth" });
}

async function onLogOut() {
  await store.dispatch("signOut");
  console.log("logged - out ");
  showNavbarItems.value = false;
  router.push("/");
}

// function OnUserClicked() {
//   if (router.currentRoute.value.name != "users") router.push({ name: "users" });
//   showNavbarItems.value = false;
// }

function clickedOutsideNavItems() {
  showNavbarItems.value = false;
}

onMounted(() => {
  document.addEventListener("click", clickedOutsideNavItems);
});

onBeforeUnmount(() => {
  document.removeEventListener("click", clickedOutsideNavItems);
});
</script>

<style></style>
