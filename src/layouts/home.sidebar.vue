<template>
  <div>
    <sidebar
      title="Linko"
      :screen="showType"
      icon_link="icon/app_logo.png"
      @on-home-clicked="$router.push({ name: 'home' })"
      @on-sideview="onSidebarMenuClicked"
    >
      <section class=" ">
        <sidebar-list
          class=" "
          :screen="showType"
          @on-change="onChange"
          :dropdownList="dropdownList"
          :selectedListItem="selectedListItem"
        />
      </section>
    </sidebar>
    <div v-if="showAbsolute" class="absolute left-0 top-0 bottom-0 z-40">
      <sidebar
        title="Linko"
        screen="lg"
        icon_link="icon/app_logo.png"
        @on-home-clicked="$router.push({ name: 'home' })"
        @on-sideview="onSidebarMenuClicked"
      >
        <section class=" ">
          <sidebar-list
            class=" "
            screen="lg"
            @on-change="onChange"
            :dropdownList="dropdownList"
            :selectedListItem="selectedListItem"
          />
        </section>
      </sidebar>
    </div>
  </div>
</template>

<script setup lang="ts">
import sidebar from "./sidebar.vue";
import sidebarList from "../components/common/sidebar.list.vue";
import { onBeforeRouteUpdate, useRoute, useRouter } from "vue-router";
import { onBeforeUnmount, onMounted, ref, watch } from "vue";
import { useBreakpoints } from "../components/common/breakpoints";
import { computed } from "vue";

const route = useRoute();
const router = useRouter();

let showSideBar = ref<boolean>(true);

const { type } = useBreakpoints();

const showType = computed(() => {
  if (type.value == "lg" && !showSideBar.value) {
    return "md";
  } else return type.value;
});

const selectedListItem = ref<any>({ subList: "add", option: null, id: 0 });

const dropdownList = ref<any>([
  // {
  //   name: "main",
  //   subList: [{ name: "Dashboard", options: null, id: 0, svg: "dashboard" }],
  // },
  {
    name: "Businesses",
    subList: [
      { name: "Businesses", options: null, id: 1, svg: "order" },
      { name: "Business Tag Trainer", options: null, id: 4, svg: "ad" },
    ],
  },
  {
    name: "AiTraining",
    subList: [
      { name: "Tags", options: null, id: 2, svg: "tag" },
      { name: "Tag Identifiers", options: null, id: 3, svg: "tagidentifier" },
      // { name: "Business Indentifiers", options: null, id: 5, svg: "features" },
      { name: "Chat Trainer", options: null, id: 6, svg: "chattraining" },
    ],
  },
  // {
  //   name: "chats",
  //   subList: [{ name: "Chats", options: null, id: 7, svg: "chat" }],
  // },
  // {
  //   name: "Users",
  //   subList: [
  //     { name: "Admins", options: null, id: 8, svg: "admin" },
  //     { name: "Customers", options: null, id: 10, svg: "users" },
  //   ],
  // },
]);

onMounted(() => {
  // console.log('home-sidebar', useRouter().currentRoute.value.name);
  computeSelected();
  showSideBar.value = localStorage.getItem("sidebar") == "true";
});

watch(
  route,
  (to) => {
    // console.log("to, from");
    console.log(to);
    const x = to?.name;
    switchTo(x?.toString() ?? "");
  },
  { flush: "pre", immediate: true, deep: true }
);

onBeforeRouteUpdate((to, from) => {
  // console.log("to, from");
  console.log(to, from);
  computeSelected();
});

function computeSelected() {
  const currentRoute: string =
    router.currentRoute.value.name == null
      ? ""
      : router.currentRoute.value.name.toString();
  //console.log('currentRoute: ', currentRoute);
  switchTo(currentRoute);
  //console.log(selectedListItem.value);
}

function switchTo(currentRoute?: string | null | undefined) {
  if (
    currentRoute == null ||
    currentRoute == undefined ||
    currentRoute == "home" ||
    currentRoute == ""
  ) {
    selectedListItem.value = { subList: "dashboard", option: null, id: 0 };
  } else if (currentRoute?.startsWith("dashboard"))
    selectedListItem.value = { subList: "Dashboard", option: null, id: 1 };
  else if (currentRoute?.startsWith("tags"))
    selectedListItem.value = { subList: "Tags", option: null, id: 2 };
  else if (currentRoute?.startsWith("tag-identifiers"))
    selectedListItem.value = {
      subList: "Tag Identifiers",
      option: null,
      id: 1,
    };
  else if (currentRoute?.startsWith("businesses"))
    selectedListItem.value = { subList: "Businesses", option: null, id: 1 };
  else if (currentRoute?.startsWith("business-tag-trainer"))
    selectedListItem.value = {
      subList: "Business Tag Trainer",
      option: null,
      id: 4,
    };
  else if (currentRoute?.startsWith("chat-trainer"))
    selectedListItem.value = {
      subList: "Chat Trainer",
      option: null,
      id: 6,
    };
}

function onChange(event: any) {
  selectedListItem.value.subList = event.subList.name;
  selectedListItem.value.id = event.subList.id;
  //console.log(selectedListItem.value.subList);
  if (selectedListItem.value.subList.endsWith("Dashboard")) {
    router.push({ name: "home" });
  } else if (selectedListItem.value.subList.endsWith("Tags")) {
    router.push({ name: "tags" });
  } else if (selectedListItem.value.subList.endsWith("Tag Identifiers")) {
    router.push({ name: "tag-identifiers" });
  } else if (selectedListItem.value.subList.endsWith("Businesses")) {
    router.push({ name: "businesses" });
  } else if (selectedListItem.value.subList.endsWith("Business Tag Trainer")) {
    router.push({ name: "business-tag-trainer" });
  } else if (selectedListItem.value.subList.endsWith("Chat Trainer")) {
    router.push({ name: "chat-trainer" });
  } else {
    router.push({ name: "home" });
  }
}

const showAbsolute = computed(() => showSideBar.value);

function onSidebarMenuClicked() {
  if (type.value == "lg") {
    showSideBar.value = !showSideBar.value;
    localStorage.setItem("sidebar", showSideBar.value ? "true" : "false");
  } else {
    if (showSideBar.value) {
      closeIfAbsolute();
    } else showSideBar.value = !showSideBar.value;
  }
}

function closeIfAbsolute() {
  if (showType.value != "lg") showSideBar.value = false;
}

onMounted(() => {
  document.addEventListener("click", closeIfAbsolute);
});

onBeforeUnmount(() => {
  document.removeEventListener("click", closeIfAbsolute);
});
</script>
