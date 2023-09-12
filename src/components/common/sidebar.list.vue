<template>
  <section
    class="select-none overflow-y-auto"
    :class="{ 'mt-10': screen == 'md' }"
  >
    <div class="" v-for="(list, topindex) in dropdownList" :key="topindex">
      <p
        :class="[
          { 'mt-5': topindex == 0 },
          { 'mt-4': topindex > 0 },
          {
            'pl-1 pr-2 font-thin text-ty': screen == 'md',
            'text-xs font-bold pl-5 ': screen != 'md',
          },
        ]"
        class="dark:text-gray-300 text-left text-gray-500 capitalize"
      >
        {{ list.name }}
      </p>

      <div
        class=""
        v-for="(subList, index) in list.subList"
        :key="index + topindex"
      >
        <div
          class="flex md:mr-2 md:rounded-lg flex-row text-left cursor-pointer hover:bg-card-light dark:hover:bg-card-dark"
          @click="
            subList.options != null
              ? drop(subList)
              : clicked(list, subList, null)
          "
          :class="[
            { 'mt-1': index > 0 },
            { 'mt-2': index == 0 },
            {
              ' bg-card-light dark:bg-card-dark':
                ((list.name == selectedListItem.list ||
                  selectedListItem.list == null) &&
                  subList.options == null &&
                  selectedListItem.subList == subList.name &&
                  selectedListItem.option == null) ||
                ((list.name == selectedListItem.list ||
                  selectedListItem.list == null) &&
                  subList.options != null &&
                  !dropdown[subList.name] &&
                  selectedListItem.subList == subList.name),
            },
          ]"
        >
          <div
            :class="[
              {
                'border-l border-2 border-primary-light dark:border-primary-dark ':
                  ((list.name == selectedListItem.list ||
                    selectedListItem.list == null) &&
                    subList.options == null &&
                    selectedListItem.subList == subList.name &&
                    selectedListItem.option == null) ||
                  ((list.name == selectedListItem.list ||
                    selectedListItem.list == null) &&
                    subList.options != null &&
                    !dropdown[subList.name] &&
                    selectedListItem.subList == subList.name),
              },
            ]"
          />

          <div
            class="pl-5 my-auto lg:pl-4 py-3"
            :class="{ 'py-3 px-3': screen == 'md', 'py-2 ': screen != 'md' }"
          >
            <web-image
              v-show="subList.link != null"
              class="mr-3"
              :padding="0"
              :link="subList.link"
              :height="5"
              :width="5"
              rounded="shadow-none"
            />
            <v-icon
              v-show="subList.svg != null"
              fill="gray-500 "
              :cls="[
                {
                  'dark:text-primary-light text-primary-light':
                    ((list.name == selectedListItem.list ||
                      selectedListItem.list == null) &&
                      subList.options == null &&
                      selectedListItem.subList == subList.name &&
                      selectedListItem.option == null) ||
                    ((list.name == selectedListItem.list ||
                      selectedListItem.list == null) &&
                      subList.options != null &&
                      !dropdown[subList.name] &&
                      selectedListItem.subList == subList.name),
                },
              ]"
              class="mr-3 dark:text-gray-200"
              :icon="subList.svg"
              :size="5"
            />
          </div>

          <p
            class="dark:text-white text-gray-700 capitalize text-xs font-bold my-4 text-left"
            :class="[
              {
                'capitalize  text-primary-light text-xs ':
                  ((list.name == selectedListItem.list ||
                    selectedListItem.list == null) &&
                    subList.options == null &&
                    selectedListItem.subList == subList.name &&
                    selectedListItem.option == null) ||
                  ((list.name == selectedListItem.list ||
                    selectedListItem.list == null) &&
                    subList.options != null &&
                    !dropdown[subList.name] &&
                    selectedListItem.subList == subList.name),
                hidden: screen == 'md',
                flex: screen != 'md',
              },
            ]"
          >
            {{
              subList.name != null
                ? subList.name.length > 20
                  ? subList.name.substring(0, 20) + "..."
                  : subList.name
                : ""
            }}
          </p>

          <v-icon
            v-show="subList.options != null"
            class="my-auto mx-1 transition duration-150 ease-in-out"
            :icon="'arrow-right'"
            :class="{ 'rotate-90': dropdown[subList.name] }"
            :size="5"
            fill="text-gray-600"
          />
        </div>

        <div v-if="dropdown[subList.name]">
          <ul
            class="font-bold text-xs text-left"
            v-for="(option, lastindex) in subList.options"
            :key="lastindex + topindex + index"
          >
            <li
              class="mb-1 flex cursor-pointer"
              :class="[
                { 'mt-2': lastindex == 0 },
                {
                  'text-primary-light text-xs font-bold bg-accentlight-light dark:bg-accentlight-dark':
                    (list.name == selectedListItem.list ||
                      selectedListItem.list == null) &&
                    selectedListItem.subList == subList.name &&
                    selectedListItem.option == option.name,
                },
              ]"
              @click="clicked(list, subList, option)"
            >
              <div
                :class="[
                  {
                    'border-l border-2 border-primary-light dark:border-primary-dark ':
                      (list.name == selectedListItem.list ||
                        selectedListItem.list == null) &&
                      selectedListItem.subList == subList.name &&
                      selectedListItem.option == option.name,
                  },
                ]"
              />

              <p class="py-2 pl-16">{{ option.name }}</p>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import WebImage from "./web-image.vue";
import VIcon from "../icons/v-icon.vue";
import { computed, onMounted, ref, watch } from "vue";
// import { useI18n } from "../../i18n";

// const t = useI18n();

const props = defineProps<{
  dropdownList: any[];
  selectedListItem?: any;
  screen?: string;
}>();

const emit = defineEmits<{
  (event: "on-change", param: any): void;
}>();

let dropdown = ref<any>({});

watch(
  () => props.dropdownList,
  (now, prev) => {
    prepareDrop();
  }
);
const screen = computed(() => props.screen);

onMounted(() => prepareDrop());

function prepareDrop() {
  //  console.log('dropdown changed')
  props.dropdownList?.forEach((item) => {
    (item.subList as any[])?.forEach((subList) => {
      if (!Object.prototype.hasOwnProperty.call(dropdown.value, subList.name))
        // this.$set(dropdown.value, subList.name, true)
        dropdown.value[subList.name] = true;
    });
  });
}
function drop(subList: any) {
  // this.$set(dropdown.value, subList.name, !dropdown.value[subList.name]);
  dropdown.value[subList.name] = !dropdown.value[subList.name];
}
function clicked(list: any, subList: any, option: any) {
  // console.log(list.name, subList.name, option.name);
  // this.$emit('on-change', {list, subList, option});
  emit("on-change", { list, subList, option });
}
</script>
