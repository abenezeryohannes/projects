<template>
  <section ref="root" class="relative w-full select-none">
    <div
      class="flex flex-wrap gap-y-1 w-full rounded-lg pb-1"
      :class="[
        { '  border-accent-light dark:border-accent-dark': focused },
        { 'border-b-2': editing },
      ]"
    >
      <div class="my-auto" v-for="(tag, index) in value" :key="index">
        <div
          :class="[
            cls,
            {
              ' flex justify-center items-center  px-2 py-1 bg-sidebar-light border border-gray-400   dark:bg-background-darkish mx-1 rounded-full':
                cls == null,
            },
          ]"
          class="min-w-min flex"
        >
          <span class="my-auto">
            {{
              t(
                tag !== null
                  ? typeof tag === "string"
                    ? tag
                    : property == null
                    ? tag.name
                    : tag[property]
                  : ""
              )
            }}
          </span>
          <span
            v-show="deletable || editing"
            class="flex justify-center items-center cursor-pointer w-4 h-5 ml-1 my-auto mx-auto"
            @click="onDelete(index)"
          >
            <v-icon
              icon="cancel"
              fill="gray-500"
              cls="dark:text-white hover:text-red-500"
              :size="3"
            />
          </span>
        </div>
      </div>
      <div v-show="editing" class="flex min-w-10">
        <v-icon
          icon="arrow-right"
          fill="gray-300"
          cls="dark:text-gray-500 my-auto hidden"
          :size="5"
        />
        <input
          type="text"
          ref="input-field"
          name="field"
          v-on:keyup.enter="onEnter"
          @focus="
            focused = true;
            showOptions = drop_on_focus ? true : showOptions;
          "
          @blur="focused = false"
          @keydown.delete="input.length === 0 ? onDelete(null) : doNothing()"
          class="appearance-none bg-transparent dark:text-white rounded min-w-min py-2 inline text-gray-700 focus:outline-none font-semibold pl-1 pr-1"
          autocomplete="off"
          :class="['h-' + (height == null) ? 10 : height]"
          v-model="input"
          :placeholder="placeholder"
        />
      </div>
    </div>

    <div
      :class="[
        { hidden: !showOptions || loadOptions.length === 0 },
        dropdown_top_margin,
      ]"
      class="absolute z-30 pt-1 max-h-56 top-0 w-full shadow-xl bg-background-light overflow-y-auto dark:bg-background-darkish transition duration-150 ease-in-out rounded-lg hide_scrollbar1 hide_scrollbar2"
    >
      <div
        v-if="can_add"
        @click="emit('on-add', null)"
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

      <div v-if="loaded_option != null">
        <ul class="w-full" v-for="(option, i) in loaded_option" :key="i">
          <li
            @click="selected(option)"
            class="py-1 mb-1 px-2 w-full cursor-pointer hover:bg-gray-300 hover:bg-opacity-10"
          >
            <div :class="[text_alignments]" v-if="Array.isArray(option_name)">
              <p v-for="(d, index) in option_name" :key="index">
                {{ t(option[d]) }}
              </p>
            </div>
            <p v-else>
              {{ t(option[option_name == null ? "name" : option_name]) }}
            </p>
          </li>
        </ul>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import VIcon from "../icons/v-icon.vue";
import RequestHandler from "../../data/util/request.handler";
import errorHandlerUtil from "../../data/util/error.handler.util";
import { onMounted, onUnmounted, ref, watch, computed } from "vue";
import { useToast } from "vue-toastification";
import { useRouter } from "vue-router";
import { useI18n } from "../../i18n";

const props = defineProps<{
  value?: any;
  type?: string;
  min?: number;
  max?: number;
  height?: number;
  error?: any;
  cls?: any;
  errors?: any[];
  name?: string;
  editing: boolean;
  placeholder?: string;
  enabled?: boolean;
  tags?: any[];
  deletable?: boolean;
  link?: string;
  options?: any[];
  property?: any;
  drop_on_focus?: boolean;
  option_name?: string;
  can_add?: boolean;
  text_alignments?: string;
  custom_value?: any;
}>();

const emit = defineEmits<{
  (event: "on-change", param: any): void;
  (event: "on-select", param: any): void;
  (event: "on-add", param: any): void;
  (event: "on-delete", param: any): void;
}>();

const { t } = useI18n();

const root = ref<any>(null);
const input = ref<string>("");
const typed = ref<string>("");
const focused = ref<boolean>(false);
const showOptions = ref<boolean>(false);
const loading = ref<boolean>();
const loaded_option = ref<any[]>([]);

onMounted(() => {
  loadOptions();
  document.addEventListener("click", close);
});

const dropdown_top_margin = computed(() => {
  return showOptions.value
    ? "mt-" + (props.height == null ? 10 : props.height + 2)
    : "mt-0";
});

watch(
  () => input.value,
  (val, _) => {
    readAndModifyIfNeccesery();
    showOptions.value =
      val.length > 0 && (props.link != null || props.options != null);
    if (showOptions.value) loadOptions();
  }
);

const readAndModifyIfNeccesery = function () {
  const separated = input.value.split("||");
  if (separated.length > 1) {
    separated.forEach((sep, _) => {
      // if (separated.length > index + 1)
      if (!duplicate(sep) && sep.trim().length > 0) emit("on-add", sep);
    });
    input.value = "";
  }
};
//function onChange(x: any) { emit('on-change', x); }

function doNothing() {}

function onEnter() {
  console.log("on-add", duplicate(input.value));
  if (duplicate(input.value)) return;
  // if (!props.custom_value || duplicate(input.value)) return;
  //console.log('on-add', input.value);
  if (props.max == null || props.max > props.value?.length) {
    emit("on-add", input.value);
    input.value = "";
  } //console.log('max error');
  else input.value = "";
}

function onDelete(index: any) {
  props.min == null || props.min == 0 || props.min < props.value.length
    ? emit("on-delete", index == null ? props.value.length - 1 : index)
    : console.log("min error");
}

function duplicate(input: any) {
  if (typeof input === "string" && input.length === 0) return true;
  for (let i = 0; i < props.value.length; i++) {
    if (typeof input === "string") {
      if (
        input.localeCompare(props.value[i]) === 0 ||
        (typeof props.value[i] !== "string" &&
          input.localeCompare(
            props.property == null
              ? props.value[i].name
              : props.value[i][props.property]
          ))
      ) {
        console.log("here 1 " + props.value[i]);
        return true;
      }
    } else if (
      String(
        input[props.property == null ? "name" : props.property]
      ).localeCompare(
        String(props.value[i][props.property == null ? "name" : props.property])
      ) === 0
    ) {
      return true;
    }
  }
  return false;
}

function selected(obj: any) {
  showOptions.value = false;
  if (duplicate(obj)) {
    input.value = "";
    return;
  }
  emit("on-select", obj);
  input.value = "";
}

async function loadOptions(value?: string) {
  if (props.options != null && props.link == null) {
    loaded_option.value = props.options;
    return;
  } else if (props.options == null && props.link == null) return;
  try {
    loading.value = true;
    let response = await new RequestHandler().get(props.link!, {
      search: value,
    });
    loaded_option.value = response.data.data;
  } catch (e) {
    errorHandlerUtil.handle(e, useToast(), useRouter());
  } finally {
    loading.value = false;
  }
}

function close(e: any) {
  if (!root.value.contains(e.target)) {
    showOptions.value = false;
    typed.value = props.value;
  }
}

onUnmounted(() => {
  document.removeEventListener("click", close);
});
</script>

<style scoped></style>
