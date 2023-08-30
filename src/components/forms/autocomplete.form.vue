<template>
  <section :ref="root">
    <div class="  ">
      <div v-if="editing" class="relative" :class="[cls]">
        <div class="relative flex">
          <input
            type="text"
            ref="inputfield"
            name="field"
            class="appearance-none border-b-2 border-gray-200 bg-transparent dark:text-white dark:border-gray-500 rounded w-full py-2 text-gray-700 leading-tight focus:outline-none focus:border-accent-light dark:focus:border-accent-dark truncate font-semibold pl-1 pr-1"
            autocomplete="off"
            :value="typed"
            @focus="
              showOptions = true;
              loadOptions(($event.target as HTMLInputElement).value);
            "
            :class="['h-' + (height == null) ? 10 : height]"
            @input="onChange(($event.target as HTMLInputElement).value)"
            :placeholder="placeholder"
          />
          <div class="w-5 h-1" />
          <div @click="toggleShow()">
            <v-icon
              icon="arrow-right"
              :size="6"
              :padding="0"
              fill="gray-500"
              cls="dark:text-white"
              class="ml-3 transition opacity-40 my-auto duration-150 ease-in-out cursor-pointer absolute top-1 right-0"
              :class="{ 'rotate-90': showOptions }"
            />
          </div>
        </div>

        <div
          :class="[{ hidden: !showOptions }, dropdown_top_margin]"
          class="absolute z-30 pt-1 max-h-56 top-0 w-full shadow-xl bg-background-light overflow-y-auto dark:bg-background-darkish transition duration-150 ease-in-out rounded-lg hide_scrollbar1 hide_scrollbar2"
        >
          <div
            v-if="can_add"
            @click="saveOnAdd != null ? save() : emit('on-add', typed)"
            class="font-bold flex justify-center py-1 my-1 items-center cursor-pointer hover:bg-gray-300 hover:bg-opacity-10"
          >
            <v-icon
              icon="add"
              :size="5"
              fill="primary-light"
              cls="bg-white rounded   shadow-lg dark:text-primary-dark"
            />
            <p class="ml-2">{{ t("add_new") }}</p>
          </div>

          <div v-if="filteredOptions != null">
            <ul class="w-full" v-for="(option, i) in filteredOptions" :key="i">
              <li
                @click="selected(option)"
                class="py-1 mb-1 px-2 w-full cursor-pointer hover:bg-gray-300 hover:bg-opacity-10"
              >
                <div
                  :class="[text_alignments]"
                  v-if="Array.isArray(option_name)"
                >
                  <p v-for="(d, index) in option_name" :key="index">
                    {{ t(option[d]) }}
                  </p>
                </div>
                <div v-else>
                  <p>
                    {{ t(option[option_name == null ? "name" : option_name]) }}
                  </p>
                </div>
              </li>
            </ul>
          </div>
        </div>

        <div v-if="error != null" class=" ">
          <p class="mt-2 col-start-2 text-red-600 text-xs">{{ error }}</p>
        </div>
        <div v-if="errorserror != null" class=" ">
          <p class="mt-2 col-start-2 text-red-600 text-xs">{{ errorserror }}</p>
        </div>
      </div>
      <p v-else class="capitalize font-semibold" :class="[cls]">
        {{ t(value) }}
      </p>
    </div>
  </section>
</template>

<script setup lang="ts">
import { onBeforeUnmount, onMounted, ref, watch, computed } from "vue";
import { useRouter } from "vue-router";
import { useToast } from "vue-toastification";
import errorHandlerUtil from "../../data/util/error.handler.util";
import RequestHandler from "../../data/util/request.handler";
import { useI18n } from "../../i18n";
const { t } = useI18n();

const root = ref<any>();
const typed = ref<string>();
const showOptions = ref<boolean>(false);
const loading = ref<boolean>(false);
const loaded_option = ref<any[]>([]);
const errorserror = ref<any>(null);

const props = defineProps<{
  value: any;
  error?: any;
  link?: string;
  height: number;
  text_alignments?: string;
  name: string;
  editing: boolean;
  options?: any[];
  placeholder?: any;
  option_name?: string | null;
  can_add?: boolean;
  saveOnAdd?: string;
  cls?: any;
}>();

const emit = defineEmits<{
  (event: "on-change", params: any): void;
  (event: "on-add", params: any): void;
}>();

const dropdown_top_margin = computed(() => {
  return showOptions.value
    ? "mt-" + (props.height == null ? 10 : props.height + 2)
    : "mt-0";
});

const filteredOptions = computed(() => {
  if (loaded_option.value != null) return loaded_option.value;
  else if (props.options != null) {
    return props.options.filter((o) => {
      return o[
        props.option_name == null ? "name" : props.option_name
      ].startsWith(typed.value);
    });
  } else return null;
});

watch(
  () => props.error,
  (val) => {
    errorserror.value = errorHandlerUtil.parse(val, props.name);
  }
);

function onChange(value: any) {
  typed.value = value;
  if (value.length >= 0 && !showOptions.value && props.link != null) {
    toggleShow();
  } else if (value.length === 0 && showOptions.value) {
    toggleShow();
  } else if (value.length > 1) {
    loadOptions(value);
  }
}

async function save() {
  try {
    loading.value = true;
    let request: any = {};
    request[props.option_name == null ? "name" : props.option_name] =
      typed.value;
    let response = await new RequestHandler().post(props.saveOnAdd!, request);
    // console.log('response: ', response);
    selected(response.data.data);
  } catch (e: any) {
    console.log(e.toString());
  } finally {
    loading.value = false;
  }
}

function selected(obj: any) {
  toggleShow();

  typed.value = obj[props.option_name == null ? "name" : props.option_name];

  emit("on-change", obj);
}

async function loadOptions(value: any) {
  try {
    loading.value = true;
    if (props.link != null) {
      var response = await new RequestHandler().get(props.link, {
        search: value,
      });
      loaded_option.value = response.data.datas;
    } else if (props.options != null) {
      loaded_option.value = props.options;
    } else loaded_option.value = [];
  } catch (e) {
    errorHandlerUtil.handle(e, useRouter(), useToast());
  } finally {
    loading.value = false;
  }
}

function toggleShow() {
  showOptions.value = !showOptions.value;
  if (showOptions.value && props.link != null) {
    loadOptions(typed.value);
  }
}

function close(e: any) {
  if (!root.value?.contains(e.target)) {
    showOptions.value = false;
    typed.value = props.value;
  }
}

onMounted(() => {
  document.addEventListener("click", close);
});
onBeforeUnmount(() => {
  document.removeEventListener("click", close);
});
</script>

<style>
.dropdown-menu {
  transition: 300ms;
}

svg.rotate-90 {
  transform: rotate(90deg);
}
</style>
