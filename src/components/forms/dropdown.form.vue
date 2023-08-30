<template>
  <section ref="root">
    <div class="capitilized">
      <div v-if="editing" class="relative">
        <div class="relative">
          <input
            readonly
            type="text"
            ref="inputfield"
            name="field"
            class="appearance-none border-b-2 border-gray-200 dark:border-gray-500 px-2 cursor-pointer rounded-lg w-full py-2 leading-tight focus:outline-none focus:border-accent-light dark:focus:border-accent-dark font-semibold pl-1 pr-1"
            :class="[
              'h-' + (height == null) ? 10 : height,
              { 'bg-transparent dark:text-white text-gray-700 ': bg == null },
              { 'bg-white dark:text-gray-700 text-gray-700 ': bg != null },
            ]"
            @input="
              $emit('on-change', ($event.target as HTMLInputElement).value)
            "
            @click="toggleShow"
            :value="value"
            :placeholder="placeholder"
          />

          <v-icon
            icon="arrow-right"
            :size="6"
            :padding="0"
            fill="gray-500"
            @click="toggleShow"
            cls="dark:text-gray-400"
            class="ml-3 transition my-auto duration-150 ease-in-out cursor-pointer absolute inset-y-1 right-0"
            :class="{ 'rotate-90': showOptions }"
          />
        </div>

        <div
          :class="[{ hidden: !showOptions }, dropdown_top_margin]"
          class="absolute z-20 pt-1 top-0 w-full shadow-xl bg-background-light max-h-52 overflow-y-auto hide_scrollbar1 hide_scrollbar2 dark:bg-background-darkish transition duration-150 ease-in-out rounded-lg"
        >
          <div
            v-if="can_add"
            @click="$emit('on-add')"
            class="font-bold flex justify-center py-1 my-1 items-center cursor-pointer hover:bg-gray-300 hover:bg-opacity-10"
          >
            <v-icon
              icon="add"
              :size="5"
              fill="primary-light"
              cls="bg-white rounded   shadow-lg dark:text-primary-dark"
            />
            <p class="ml-2">{{ "Add New" }}</p>
          </div>

          <div v-if="options != null">
            <ul class="w-full" v-for="(option, i) in options" :key="i">
              <li
                @click="selected(option)"
                class="py-1 mb-1 px-2 w-full cursor-pointer hover:bg-gray-300 hover:bg-opacity-10"
              >
                <div :class="[text_alignments]">
                  <p>
                    {{
                      option[
                        option_name == null ? "name" : option_name
                      ].toLowerCase()
                    }}
                  </p>
                  <p
                    class="text-ty"
                    v-if="
                      description_option_name != null &&
                      option[description_option_name] != null
                    "
                  >
                    {{ option[description_option_name].toLowerCase() }}
                  </p>
                </div>
              </li>
            </ul>
          </div>

          <div v-else-if="link != null">
            <ul class="w-full" v-for="(option, i) in loaded_option" :key="i">
              <li
                @click="selected(option)"
                class="py-1 mb-1 px-2 w-full cursor-pointer hover:bg-gray-300 hover:bg-opacity-10"
              >
                <div>
                  <p>
                    {{
                      option[
                        option_name == null ? "name" : option_name
                      ].toLowerCase()
                    }}
                  </p>
                  <p class="text-ty" v-if="describe">
                    {{
                      option[
                        description_option_name == null
                          ? "description"
                          : description_option_name
                      ].toLowerCase()
                    }}
                  </p>
                </div>
              </li>
            </ul>
            <div
              v-if="loading"
              class="custom_xsmall_loader mx-auto my-2 w-5 h-5"
            />
          </div>
        </div>

        <div v-if="error != null" class=" ">
          <p class="mt-2 col-start-2 text-red-600 text-xs">{{ error }}</p>
        </div>

        <div v-if="errorserror != null" class=" ">
          <p class="mt-2 col-start-2 text-red-600 text-xs">{{ errorserror }}</p>
        </div>
      </div>
      <p v-else class="capitalize font-semibold" name="field">{{ value }}</p>
    </div>
  </section>
</template>

<script setup lang="ts">
import { onBeforeUnmount, onMounted, ref, watch, computed } from "vue";
import { useRouter } from "vue-router";
import { useToast } from "vue-toastification";
import errorHandlerUtil from "../../data/util/error.handler.util";
import RequestHandler from "../../data/util/request.handler";

const props = defineProps<{
  value?: any;
  error?: any;
  errors?: any;
  text_alignments?: string;
  bg?: any;
  description_option_name?: any;
  link?: any;
  height?: number;
  name?: any;
  editing?: boolean;
  options?: any[];
  describe?: any;
  placeholder?: any;
  option_name?: any;
  can_add?: any;
}>();

let errorserror = ref<any>(null);
let showOptions = ref<boolean>(false);
let loading = ref<boolean>(false);
let loaded_option = ref<any[]>();
let root = ref<any>({});

watch(
  () => props.errors,
  (val, _) => {
    errorserror.value = errorHandlerUtil.parse(val, props.name);
  }
);

const emit = defineEmits<{
  (event: "on-change", param: any): void;
}>();

// const showOption = computed(() => {
//   return showOptions.value ? (props.height == null ? 10 : props.height) : "h-0";
// });

const dropdown_top_margin = computed(() => {
  return showOptions.value
    ? "mt-" + (props.height == null ? 10 : props.height + 2)
    : "mt-0";
});

onMounted(() => {
  document.addEventListener("click", close);
});

onBeforeUnmount(() => {
  document.removeEventListener("click", close);
});

function selected(obj: any) {
  toggleShow();
  emit("on-change", obj);
}

async function loadOptions() {
  try {
    loading.value = true;
    var response = await new RequestHandler().get(props.link, {});
    loaded_option.value = response.data.datas;

    // console.log("drop_down  loaded_option: ", response);
  } catch (e) {
    errorHandlerUtil.handle(e, useToast(), useRouter());
  } finally {
    loading.value = false;
  }
}

function toggleShow() {
  showOptions.value = !showOptions.value;
  if (showOptions.value && props.link != null) {
    loadOptions();
  }
}

function close(e: any) {
  if (!root.value.contains(e.target)) showOptions.value = false;
}
</script>

<style>
.dropdown-menu {
  transition: 300ms;
}

svg.rotate-90 {
  transform: rotate(90deg);
}
</style>
