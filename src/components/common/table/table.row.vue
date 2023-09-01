<template>
  <section class=" ">
    <div
      :class="{
        'cursor-pointer hover:shadow-sm hover:bg-accentlight-light dark:hover:bg-accentlight-dark':
          clickable,
      }"
      class="w-full grid grid-cols-16 gap-x-2"
    >
      <div
        v-for="(header, header_index) in headers"
        :key="header_index"
        :class="['col-span-' + headers[header_index].width]"
      >
        <div class="w-full h-full my-auto flex text-gray-700 dark:text-white">
          <!-- Check box area -->
          <div
            v-if="header.name === '#bulk#'"
            class="h-full py-2 w-full flex justify-center"
          >
            <checkbox-form
              class=""
              :value="checked"
              @on-change="
                checked = $event;
                emit('on-select', { check: checked });
              "
              :editing="true"
            />
          </div>

          <!-- actions area -->
          <div
            v-else-if="header.name === '#actions#'"
            class="my-auto py-2 mx-auto flex flex-row"
          >
            <div v-for="action in header.actions" :key="action">
              <div
                v-show="!editing && error === null && data != null"
                @click.stop="onActionClick(data, action)"
              >
                <div
                  :class="data['action_' + action + '_cls']"
                  class="mr-2 my-auto"
                >
                  <v-icon
                    cls="cursor-pointer my-auto dark:text-white"
                    :padding="0"
                    fill="gray-600"
                    :icon="action"
                    :size="5"
                  />
                  <!-- 
                                    <p v-show="action==='pay'" class="cursor-pointer my-auto dark:text-white">
                                       {{t(action)}} </p>  -->
                </div>
              </div>
            </div>

            <div
              v-show="editing || error != null || data === null"
              @click.stop="onActionClick(data, 'save')"
            >
              <v-icon
                cls="cursor-pointer mr-2 dark:success-dark"
                :padding="0"
                fill="success-light"
                icon="save"
                :size="5"
              />
            </div>

            <div
              v-show="editing || error != null || data === null"
              @click.stop="onActionClick(data, 'cancel')"
            >
              <v-icon
                cls="cursor-pointer mr-2 dark:error-dark"
                :padding="0"
                fill="error-light"
                icon="cancel"
                :size="5"
              />
            </div>
          </div>

          <div
            v-else-if="header.type === 'status'"
            class="flex justify-center items-center w-full h-full"
          >
            <p :class="data[header.name + '_cls']">
              {{ t(data[header.name]) }}
            </p>
          </div>

          <!-- data area -->
          <div
            v-else
            class="text-left py-2 font-semibold flex w-full h-full"
            @click="onClick"
            :class="
              data != null && data[header.name + '_cls_edit'] != null && editing
                ? data[header.name + '_cls_edit']
                : data != null && data[header.name + '_cls'] != null
                ? data[header.name + '_cls']
                : data != null &&
                  data[header.name] != null &&
                  data[header.name].cls != null
                ? [data[header.name].cls]
                : [header.cls]
            "
          >
            <p v-if="header.type === null && data != null" class="truncate">
              {{ t(data[header.name]) }}
            </p>

            <text-form
              v-else-if="header.type === 'text'"
              @on-change="temp_data[header.name] = $event"
              :class="[{ 'overflow-clip': header.name === 'email_address' }]"
              :value="value(data, header)"
              :error="parseError(header.name)"
              :type="header.type"
              :editing="
                ((editing || error != null) && header.editable) || data === null
              "
              :placeholder="value(data, header)"
            />

            <!-- <color-form v-else-if="header.type === 'color'" @on-change="temp_data[header.name] = $event" :class="[]"
              :value="value(temp_data, header)" :error="parseError(header.name)" :type="header.type" :enabled="true"
              :identifier="value(temp_data, header)"
              :editing="((editing || error != null) && header.editable) || data === null"
              :placeholder="value(data, header)" /> -->

            <color-form
              v-else-if="header.type === 'color'"
              direction="horizontal"
              :enabled="true"
              @on-change="temp_data[header.name] = $event"
              :editing="
                ((editing || error != null) && header.editable) || data === null
              "
              :error="parseError(header.name)"
              :placeholder="value(data, header)"
              :value="value(temp_data, header)"
            />

            <number-form
              v-else-if="header.type === 'number' || header.type === 'cash'"
              @on-change="temp_data[header.name] = $event"
              :class="[{ 'overflow-clip': header.name === 'email_address' }]"
              :value="value(data, header)"
              :max="header.max"
              :min="header.min"
              :error="parseError(header.name)"
              :type="header.type"
              :editing="
                ((editing || error != null) && header.editable) || data === null
              "
              :placeholder="value(data, header)"
            />

            <datepicker-form
              v-if="header.type === 'date'"
              :editing="
                ((editing || error != null) && header.editable) || data === null
              "
              :original="
                data[header.name] != null ? new Date(data[header.name]) : null
              "
              :value="dateValue(data, header)"
              @on-change="temp_data[header.name] = $event"
            />

            <dropdown-form
              @on-change="temp_data[header.name] = $event"
              v-if="header.type === 'dropdown'"
              :value="dropdownValue(data, header)"
              :option_name="header.option_name"
              :editing="
                ((editing || error != null) && header.editable) || data === null
              "
              placeholder="selectone"
              :options="header.options"
              :link="header.link"
              :height="8"
            />

            <autocomplete-form
              @on-change="temp_data[header.name] = $event[header.option_name]"
              @on-add="temp_data[header.name] = $event"
              :save-on-add="header.save_on_add ?? false"
              v-if="header.type === 'autocomplete'"
              :value="dropdownValue(data, header)"
              :option_name="header.option_name"
              :can_add="header.can_add ?? false"
              :editing="
                ((editing || error != null) && header.editable) || data === null
              "
              name="header.options"
              placeholder="selectone"
              :options="header.options"
              :link="header.link"
              :height="8"
            />

            <toggle-form
              v-if="header.type === 'toggle'"
              :cls="data[header.name + '_cls']"
              :editing="
                ((editing || error != null) && header.editable) || data === null
              "
              :positive="
                header.option != null
                  ? header.option.positive
                  : data[header.name + '_options']
              "
              :negative="
                header.option != null
                  ? header.option.negative
                  : data[header.name + '_options']
              "
              :width="4"
              :height="4"
              :toggle="value(data, header)"
              @on-change="temp_data[header.name] = $event"
            />

            <tag-input-form
              @on-change="temp_data[header.name] = $event"
              v-if="header.type === 'tag'"
              :value="data[header.name]"
              :editing="
                ((editing || error != null) && header.editable) || data === null
              "
              placeholder=""
              :options="header.options"
              :link="header.link"
              :height="8"
            />

            <!-- <img  v-if="header.type === 'media' || header.type === 'image'" 
             v-lazy="constants.MEDIA_LINK + value(data, header)" width="10" height="10" 
             :class='[" w-8 h-8 object-center object-fit rounded-full " ]' /> -->

            <image-form
              v-if="header.type === 'media' || header.type === 'image'"
              :local_image_file="localImg"
              :deletable="false"
              @on-change="
                icon = $event[$event.length - 1];
                emit('on-action', {
                  body: temp_data,
                  action: 'edit',
                  index: props.index,
                  files: icon == null ? [] : [{ name: 'icon', file: icon }],
                });
              "
              :editing="
                ((editing || error != null) && header.editable) || data === null
              "
              :link="data[header.name]"
              :padding="0"
              :editable="header.editable"
              :width="10"
              :height="10"
              rounded="rounded"
            />
          </div>
        </div>
      </div>
    </div>
    <transition name="slide-fade">
      <keep-alive v-if="show_item">
        <component
          :data="data"
          :headers="headers"
          :error="error"
          :index="index"
          ref="itemRef"
          :editing="editing"
          :is="dynamicComponent"
        >
        </component>
      </keep-alive>
    </transition>
  </section>
</template>

<script setup lang="ts">
import TextForm from "../../forms/text.form.vue";
import ColorForm from "../../forms/color.form.vue";
import NumberForm from "../../forms/number.form.vue";
import vIcon from "../../icons/v-icon.vue";
import dropdownForm from "../../forms/dropdown.form.vue";
import imageForm from "../../forms/image.form.vue";
import toggleForm from "../../forms/toggle.form.vue";
import CheckboxForm from "../../forms/checkbox.form.vue";
import DatepickerForm from "../../forms/datepicker/datepicker.form.vue";
import TagInputForm from "../../forms/tag.input.form.vue";
import { computed, ref, watch } from "vue";
import errorHandlerUtil from "../../../data/util/error.handler.util";
import AutocompleteForm from "../../forms/autocomplete.form.vue";
import { useI18n } from "../../../i18n";

const props = defineProps<{
  index: number;
  data: any;
  headers: any[];
  show_item_on: any;
  item: any;
  checkAll: boolean;
  unCheckAll: boolean;
  error?: any;
  clickable?: boolean;
}>();

const t = useI18n();
const temp_data = ref<any>({});
const temp_item_data = ref<any>({});
const editing = ref<boolean>(false);
const checked = ref<boolean>(false);
const show_item = ref<boolean>(false);
const itemRef = ref<any>({});
const icon = ref<any>(null);
const localImg = ref<any>(null);

const dynamicComponent = computed(() => {
  return () => import(`./items/${props.item}.item.vue`);
});

const emit = defineEmits<{
  (event: "on-action", param: any): void;
  (event: "on-select", param: any): void;
  (event: "on-item-click", param: any): void;
}>();

watch(
  () => props.error,
  (e, _) => {
    if (e != null && e.body != null)
      temp_data.value = JSON.parse(JSON.stringify(e.body));

    // console.log('from row', e)
  }
);

watch(
  () => props.unCheckAll,
  (newVal, _) => {
    // console.log('uncheckall', newVal);
    if (newVal === true) checked.value = false;
  }
);

watch(
  () => props.checkAll,
  (newVal, _) => {
    checked.value = newVal;
  }
);

watch(
  () => props.data,
  (_, __) => {
    editing.value = false;
    temp_data.value = {};
    if (props.item != null && itemRef.value != null) {
      itemRef.value.load(false);
    }
  }
);

function onClick() {
  if (!editing.value && props.error === null && props.clickable) {
    if (
      props.show_item_on != null &&
      props.show_item_on.includes("click") &&
      props.item != null
    )
      show_item.value = !show_item.value;
    else emit("on-item-click", { index: props.index, body: props.data });
  }
}

function parseError(key: any) {
  return props.error != null
    ? errorHandlerUtil.parse(props.error.errors, key)
    : null;
}

function value(data: string[], header: any) {
  var x = null;
  if (props.error != null && props.error.body != null) {
    x = props.error.body[header.name];
  } else if (editing.value || data === null) {
    x = temp_data.value[header.name];
  } else {
    x = props.data[header.name];
    if (header.name == "color") {
      console.log(props.data.name, x);
      console.log(props.data);
      console.log("---------------");
    }
  }

  return x;
}

function dateValue(data: any, header: any) {
  var x = null;
  if (props.error != null && props.error.body != null) {
    x = new Date(props.error.body[header.name]);
  } else if (editing.value || data === null) {
    x =
      temp_data.value[header.name] != null
        ? new Date(temp_data.value[header.name])
        : new Date();
  } else x = new Date(data[header.name]);
  return x;
}

function dropdownValue(data: any, header: any) {
  var x = null;
  if (props.error != null && props.error.body != null) {
    x = props.error.body[header.name];
  } else if (editing.value && data != null) {
    x =
      typeof temp_data.value[header.name] === "string"
        ? temp_data.value[header.name]
        : temp_data.value[header.name].name;
  } else if (data === null) {
    if (temp_data.value[header.name] != null)
      x =
        typeof temp_data.value[header.name] === "string"
          ? temp_data.value[header.name]
          : temp_data.value[header.name].name;
    else x = "- select one -";
  } else
    x =
      typeof data[header.name] === "string"
        ? data[header.name]
        : data[header.name].name;
  return x;
}

// function refresh() {
//   editing.value = false;
//   temp_data.value = {};
//}

function onActionClick(data: any, action: string) {
  if (action === "edit") {
    editing.value = true;
    if (props.error != null && props.error.body != null) {
      temp_data.value = JSON.parse(JSON.stringify(props.error));
    } else temp_data.value = JSON.parse(JSON.stringify(data));
    if (
      props.show_item_on != null &&
      props.show_item_on.includes("edit") &&
      props.item != null
    )
      show_item.value = true;
    // for (const [key, value] of Object.entries(x)) { this.$set(temp_data.value, key, value); }
  } else if (action === "save") {
    // console.log('testinging: ', temp_item_data.value)
    if (props.item != null) {
      temp_item_data.value = JSON.parse(itemRef.value.getRequest());
    }
    // console.log('temp temp temping: ', temp_item_data.value)
    editing.value = false;
    emit("on-action", {
      body: temp_data.value,
      item_body: temp_item_data.value,
      action: "edit",
      orginal: data,
    });
  } else if (action === "cancel") {
    if (props.item != null) {
      itemRef.value.cancel();
    }
    editing.value = false;
    emit("on-action", {
      body: temp_data.value,
      action: "cancel",
      orginal: data,
    });
  } else if (action === "delete") {
    emit("on-action", {
      body: temp_data.value,
      action: "delete",
      orginal: data,
    });
  } else if (action === "more") {
    if (props.show_item_on != null && props.item != null)
      show_item.value = !show_item.value;
  } else
    emit("on-action", {
      body: temp_data.value,
      item_body: temp_item_data.value,
      action: action,
      orginal: data,
    });
}
</script>

<style>
/* Enter and leave animations can use different */
/* durations and timing functions.              */
.slide-fade-enter-active {
  transition: all 0.7s ease-out;
}

.slide-fade-leave-active {
  transition: all 0.3s ease-in-out;
}

.slide-fade-enter-from,
.slide-fade-leave-to {
  transform: translateY(-20px);
  opacity: 0;
}
</style>
