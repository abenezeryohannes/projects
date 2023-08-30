<template>
  <div
    ref="root"
    class="select-none w-full relative text-gray-700 dark:text-white"
  >
    <div class="flex items-center justify-center">
      <div class="relative text-gray-400 focus-within:text-gray-600 w-full">
        <span class="absolute inset-y-0 left-0 flex items-center pl-2">
          <!-- <button type="submit" class="p-1 focus:outline-none focus:shadow-outline"> -->
          <!-- <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" class="w-6 h-6 dark:text-gray-400"><path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg> -->
          <!-- </button> -->
          <v-icon
            icon="search"
            class="p-1 focus:outline-none focus:shadow-outline"
            fill="gray-400"
            cls="stroke-current stroke-1 dark:text-gray-400"
            :size="6"
          />
        </span>
        <input
          v-on:keyup.enter="onEnter"
          v-model="query"
          type="search"
          name="searchText"
          class="w-full py-2 font-semibold pr-2 text-sm text-white rounded-full shadow pl-10 focus:outline-none bg-background-lightish dark:bg-background-darkish dark:focus-text-gray-200 dark:text-white focus:text-gray-900"
          :placeholder="t('search') + '...'"
          autocomplete="off"
        />
      </div>
    </div>

    <div
      class="absolute rounded-lg shadow-lg z-30 w-full bg-background-light dark:bg-background-deepdark py-1 transition duration-150 ease-in-out"
      :class="[{ hidden: !showSearchResult }, dropdown_top_margin]"
    >
      <ul v-for="item in filteredPage" :key="item.name" @click="goTo(item)">
        <li
          class="flex flex-row py-2 px-3 cursor-pointer w-full hover:bg-background-lightish dark:hover:bg-background-darkish dark:bg-opacity-50"
        >
          <!-- <icon-wrapper link="public/page.png" class="my-auto"/> -->
          <div class="flex flex-col mx-3 my-auto">
            <p class="text-left text-sm font-semibold">{{ item.name }}</p>
            <p class="text-xs mt-1">{{ item.description }}</p>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>
<script setup lang="ts">
import vIcon from "../icons/v-icon.vue";
import { useRouter } from "vue-router";
import { useStore } from "../../store";
import { useI18n } from "../../i18n";
import { computed, onBeforeUnmount, onMounted, ref, watch } from "vue";
import { loadJsonFileToList } from "../../util";
import Page, { IPage } from "../../domain/page";

const root = ref<any>(null);
const router = useRouter();
const store = useStore();
const { t } = useI18n();
let query = ref<string | null>("");
const showSearchResult = ref<boolean>(false);

const props = defineProps<{
  height: number;
}>();
watch(query, function (val, oldVal) {
  if (val == oldVal) return;
  if (val == null || val.length == 0) showSearchResult.value = false;
  else {
    //go with the logic
    showSearchResult.value = true;
  }
});

onMounted(() => {
  document.addEventListener("click", close);
});

onBeforeUnmount(() => {
  document.removeEventListener("click", close);
});

const dropdown_top_margin = computed<string>(() =>
  showSearchResult.value ? "mt-" + 4 : "mt-0"
);

const pages = computed<Page[]>(() => store.getters.pages);

const filteredPage = computed<Page[]>(() => {
  console.log("loaded", pages.value.length);
  if (query.value == null) return [];
  loadPagesFromAssetAndTryAgain();
  const temp: string = query?.value?.toLowerCase();
  return pages.value
    ?.filter((p) => {
      return (
        p?.name?.toLowerCase().includes(temp) ||
        p?.description?.toLowerCase().includes(temp)
      );
    })
    .slice(0, 5);
});

async function loadPagesFromAssetAndTryAgain(): Promise<Page[] | null> {
  //    if (pages.value.length > 0) return null;
  const list = (
    await loadJsonFileToList<IPage>(`src/assets/data/pages.json`)
  )?.map((m: any) => new Page(m));
  if (list == null) return [];

  //console.log('list', list);
  await store.dispatch("loadPages", list);
  return list;
}

function onEnter() {
  const pages = filteredPage.value;
  if (pages != null && pages.length > 0) {
    query.value = null;
    goTo(pages[0]);
  }
}

function toggleShow() {
  showSearchResult.value = !showSearchResult.value;
}
function close(e: any) {
  if (!(root.value != null && root.value.contains(e?.target)))
    showSearchResult.value = false;
}
function goTo(page: Page) {
  if (router.currentRoute.value.name != page.path)
    router.push({ path: page.path });
}
</script>

<!-- <script>
import { computed, defineComponent, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { useI18n } from '../../i18n';
import vIcon from '../icons/v-icon.vue'
import { useRouter } from 'vue-router';
import { useStore } from '../../store';
// import iconWrapper from './icon.wrapper.vue';
export default defineComponent({
    components: { vIcon },
    props: {
        height: {
            type: Number, default: 8, require: false
        }
    },
    data() {
        return {
            query: "",
            showSearchResult: false,
        };
    },
    watch: {
        query: function (val, oldVal) {
            if (val == oldVal) return;
            if (val == null || val.length == 0) this.showSearchResult = false;
            else {
                //go with the logic
                this.showSearchResult = true;
            }
        }
    },
    methods: {
        onEnter: function () {
            const pages = this.filteredPage;
            if (pages != null && pages.length > 0) {
                this.query = null;
                this.goTo(pages[0])

            }
        },
        toggleShow() {
            this.showSearchResult = !this.showSearchResult;
        },
        close(e) {
            if (!this.$el.contains(e.target))
                this.showSearchResult = false
        },
        goTo(page) {
            if (this.$router.currentRoute.name != page.path)
                this.$router.push({ name: page.path });
        }
    },

    computed: {
        dropdown_top_margin() {
            return this.showSearchResult ? "mt-" + (4) : 'mt-0';
        },
        pages() {
            return this.$store.getters.pages;
        },
        filteredPage() {
            if (this.query == null) return [];
            return this.pages.filter((p) => {
                return p.name.toLowerCase().includes(this.query.toLowerCase())
                    || p.description.toLowerCase().includes(this.query.toLowerCase())
            })
                .slice(0, 5);
        }
    },
    mounted() {
        document.addEventListener('click', this.close)
    },
    beforeDestroy() {
        document.removeEventListener('click', this.close)
    }
})
</script> -->

<style>
.dropdown-menu {
  transition: 300ms;
}

svg.rotate-90 {
  transform: rotate(90deg);
}
</style>
../../domain/page../../domain/page
