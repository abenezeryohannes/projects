<template>
  <section class="w-full">
    <section
      class="w-full"
      :class="[
        { ' ': direction === 'vertical' },
        { flex: direction !== 'vertical' },
        { 'flex-none': error == null },
      ]"
    >
      <label
        v-if="label != null"
        class="font-semibold capitalize"
        :class="[
          { 'my-auto': error == null },
          'w-' + (gap == null ? 44 : gap),
          label_cls,
        ]"
      >
        <span v-if="required && editing" class="text-red-500 text-lg">*</span>
        {{ t(label.toLowerCase()) }} {{ direction !== "vertical" ? ":" : "" }}
      </label>

      <section class="w-full font-semibold">
        <div class="" v-if="type === 'text'">
          <text-form
            :direction="direction"
            :gap="gap"
            :enabled="enabled"
            @on-change="emit('on-change', $event)"
            :required="required"
            type="type"
            :editing="editing"
            :errors="errors"
            :label="label"
            :cls="value_cls"
            :label_cls="label_cls"
            :name="name"
            :placeholder="placeholder"
            :value="value"
          />
        </div>

        <div class="" v-if="type === 'color'">
          <color-form
            :direction="direction"
            :gap="gap"
            :enabled="enabled"
            @on-change="emit('on-change', $event)"
            :required="required"
            type="type"
            :identifier="identifier"
            :editing="editing"
            :errors="errors"
            :label="label"
            :cls="value_cls"
            :label_cls="label_cls"
            :name="name"
            :placeholder="placeholder"
            :value="value"
          />
        </div>

        <div
          class=""
          :class="[{ 'mt-2': direction === 'vertical' }]"
          v-if="type === 'textarea'"
        >
          <text-area
            :direction="direction"
            :gap="gap"
            :required="required"
            :enabled="enabled"
            @on-change="emit('on-change', $event)"
            :editing="editing"
            :errors="errors"
            :label="label"
            :rows="(rows as string)"
            :value_cls="value_cls"
            :label_cls="label_cls"
            :name="name"
            :placeholder="placeholder"
            :value="value"
          />
        </div>

        <div class="" v-if="type === 'tag'">
          <tag-input-form
            :value="value"
            :editing="editing"
            :errors="errors"
            :placeholder="placeholder"
            :link="link"
            @on-add="emit('on-add', $event)"
            @on-delete="emit('on-delete', $event)"
            :drop_on_focus="drop_on_focus"
            @on-select="emit('on-select', $event)"
            :max="max"
            :min="min"
            :options="options"
            :enabled="enabled"
            :option_name="option_name"
            :label="label"
            :value_cls="value_cls"
            :label_cls="label_cls"
            :deletable="deletable"
            :direction="direction"
            :gap="gap"
            :required="required"
            :property="property"
            :custom_value="custom_value"
          />
        </div>

        <div class="" v-else-if="type === 'password'">
          <password-form
            :direction="direction"
            :gap="gap"
            @on-change="emit('on-change', $event)"
            :required="required"
            :enabled="enabled"
            :editing="editing"
            :errors="errors"
            :label="label"
            :value_cls="value_cls"
            :label_cls="label_cls"
            :name="name"
            :placeholder="placeholder"
            :value="value"
          />
        </div>

        <div class="" v-else-if="type === 'autocomplete'">
          <autocomplete-form
            :name="name"
            :height="8"
            :direction="direction"
            :saveOnAdd="saveOnAdd"
            @on-change="emit('on-change', $event)"
            :required="required"
            :can_add="can_add"
            :option_name="option_name"
            @on-add="emit('on-add', $event)"
            :editing="editing"
            :label="label"
            :enabled="enabled"
            :value="value"
            :gap="gap"
            :cls="value_cls"
            :label_cls="label_cls"
            :errors="errors"
            :placeholder="placeholder"
            :link="link"
          />
        </div>

        <div class="" v-else-if="type === 'dropdown'">
          <dropdown-form
            :direction="direction"
            :gap="gap"
            @on-change="emit('on-change', $event)"
            :required="required"
            :can_add="can_add"
            :height="height"
            :value_cls="value_cls"
            :label_cls="label_cls"
            :link="link"
            :option_name="option_name"
            :enabled="enabled"
            :options="options"
            :label="label"
            :editing="editing"
            :errors="errors"
            :name="name"
            :placeholder="placeholder"
            @on-add="emit('on-add')"
            :value="value"
          />
        </div>

        <div
          class=""
          v-else-if="type === 'number' || type === 'cash' || type === 'percent'"
        >
          <number-form
            :direction="direction"
            :gap="gap"
            :enabled="enabled"
            @on-change="emit('on-change', $event)"
            :required="required"
            :min="min"
            :max="max"
            :label="label"
            :editing="editing"
            :type="type"
            :errors="errors"
            :value_cls="value_cls"
            :label_cls="label_cls"
            :name="name"
            :placeholder="placeholder"
            :value="value"
          />
        </div>

        <div
          :class="[{ 'mt-2': direction === 'vertical' }]"
          v-else-if="type === 'toggle'"
        >
          <toggle-form
            :direction="direction"
            :value_cls="value_cls"
            :label_cls="label_cls"
            :toggle="toggle"
            @on-change="emit('on-change', $event)"
            :gap="gap"
            :editing="editing"
            :width="width"
            :height="height"
            :errors="errors"
            :name="name"
            :value="value"
            :enabled="enabled"
          />
        </div>

        <div class="" v-else-if="type === 'checkbox'">
          <checkbox-form
            :direction="direction"
            :value_cls="value_cls"
            :label_cls="label_cls"
            @on-change="emit('on-change', $event)"
            :gap="gap"
            :editing="editing"
            :errors="errors"
            :name="name"
            :value="value"
          />
        </div>

        <div
          :class="[{ 'mt-1.5': direction === 'vertical' }]"
          v-else-if="type === 'date'"
        >
          <datepicker-form
            :gravity="gravity"
            :enabled="enabled"
            :editing="editing"
            @on-change="emit('on-change', $event)"
            :value="value"
            :errors="errors"
            :placeholder="placeholder"
            :name="name"
          />
        </div>

        <div class="" v-else-if="type === 'memo'">
          <memo-form
            class=""
            :label="label"
            :enabled="enabled"
            :memos="value"
            :item_padding="0"
            :item_width="16"
            :item_height="16"
            :name="name"
            @on-change="
              emit('on-change', [
                { name: 'new_pictures', data: $event.new_memos },
                {
                  name: 'deleted_pictures',
                  data: JSON.stringify($event.deleted_memos),
                },
                { name: 'pictures', data: JSON.stringify($event.memos) },
              ])
            "
            :editing="editing"
          />
        </div>
      </section>

      <section class="">
        <div v-if="def != null && editing" class="flex mt-3 gap-x-2">
          <v-icon
            icon="info"
            cls="dark:text-gray-400"
            fill="gray-300"
            :size="4"
          />
          <p class="my-auto text-gray-400 dark:text-gray-400 text-ty">
            ( {{ t(def) }} )
          </p>
        </div>
      </section>
    </section>
  </section>
</template>

<script setup lang="ts">
import { ref, watch } from "vue";
import errorHandlerUtil from "../../data/util/error.handler.util";

import VIcon from "../../components/icons/v-icon.vue";
import TextForm from "../../components/forms/text.form.vue";
import ColorForm from "../../components/forms/color.form.vue";
import TextArea from "../../components/forms/textarea.form.vue";
import TagInputForm from "../../components/forms/tag.input.form.vue";
import PasswordForm from "../../components/forms/password.form.vue";
import AutocompleteForm from "../../components/forms/autocomplete.form.vue";
import DropdownForm from "../../components/forms/dropdown.form.vue";
import NumberForm from "../../components/forms/number.form.vue";
import ToggleForm from "../../components/forms/toggle.form.vue";
import MemoForm from "../../components/forms/memo.form.vue";
import CheckboxForm from "../../components/forms/checkbox.form.vue";
import DatepickerForm from "../../components/forms/datepicker/datepicker.form.vue";
import { useI18n } from "../../i18n";

const { t } = useI18n();
const error = ref<any>(null);

const props = withDefaults(
  defineProps<{
    obj?: any;
    def?: string;
    label?: string;
    value?: any;
    required?: boolean;
    gap?: string;
    value_cls?: any;
    rows?: string | number;
    cols?: string | number;
    placeholder?: any;
    memos?: any[];
    item_padding?: any;
    item_width?: any;
    item_height?: string | number;
    editing: boolean;
    direction?: string;
    negative?: string;
    positive?: string;
    width?: number;
    label_cls?: string;
    height?: number;
    link?: string;
    identifier?: string;
    can_add?: boolean;
    min?: number;
    max?: number;
    type: string;
    errors?: any[];
    name: string;
    option_name?: string;
    options?: any[];
    description_option_name?: string;
    describe?: any;
    saveOnAdd?: string;
    deletable?: boolean;
    custom_value?: any;
    property?: any;
    drop_on_focus?: boolean;
    text_alignments?: string;
    gravity?: string;
    enabled?: boolean;
    toggle?: boolean;
  }>(),
  {
    enabled: true,
  }
);

watch(
  () => props.errors,
  (newVal, _) => {
    error.value = errorHandlerUtil.parse(newVal, props.name);
  }
);

const emit = defineEmits<{
  (event: "on-change", params: any): void;
  (event: "on-delete", params: any): void;
  (event: "on-add", params: any): void;
  (event: "on-add"): void;
  (event: "on-select", params: any): void;
}>();
</script>

<style></style>
