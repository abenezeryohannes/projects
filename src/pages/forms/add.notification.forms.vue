<template>
  <section class="text-left font-semibold w-full mb-24 select-none">
    <div class="flex justify-stretch gap-x-10 mb-10 mt-5 w-1/2">
      <form-control
        v-bind="{
          type: 'autocomplete',
          name: 'Receiver',
          value: temp_notification.receiver,
          label_cls: ``,
          label: `Receiver`,
          editing: editing,
          errors: errors,
          direction: `vertical`,
          option_name: 'fullName',
          can_add: false,
          link: 'users/findAll',
        }"
        @on-change="
          emiting('receiver', $event.fullName);
          emiting('userId', $event.id);
        "
      />
    </div>
    <div class="flex justify-stretch gap-x-10">
      <singletext-form
        class="text-lg font-bold"
        name="title"
        @on-change="emiting('title', $event)"
        :editing="editing"
        placeholder="Title"
        label="title"
        :value="temp_notification.title"
        :errors="errors"
      />

      <singletext-form
        class="text-lg font-bold"
        name="arabicTitle"
        @on-change="emiting('arabicTitle', $event)"
        :editing="editing"
        placeholder="Arabic Title"
        label="Arabic Title"
        :value="temp_notification.arabicTitle"
        :errors="errors"
      />
    </div>

    <div
      class="grid gap-x-8"
      :class="[
        { 'grid-cols-2 gap-y-10 gap-x-10 mt-10': editing },
        { 'grid-cols-1  mt-3': !editing },
      ]"
    >
      <form-control
        v-bind="{
          type: 'textarea',
          name: 'message',
          value: temp_notification.message,
          label_cls: ``,
          label: `Message`,
          editing: editing,
          errors: errors,
          direction: `vertical`,
          rows: 5,
          min: 1,
          max: 100,
        }"
        @on-change="emiting('message', $event)"
      />

      <form-control
        v-bind="{
          type: 'textarea',
          name: 'arabicMessage',
          value: temp_notification.message,
          label_cls: ``,
          label: `Arabic Message`,
          editing: editing,
          rows: 5,

          errors: errors,
          direction: `vertical`,
          min: 1,
          max: 100,
        }"
        @on-change="emiting('arabicMessage', $event)"
      />
    </div>
  </section>
</template>

<script setup lang="ts">
import SingletextForm from "../../components/forms/singletext.form.vue";
import FormControl from "../../components/formcontrollers/formcontrol.vue";

const props = defineProps<{
  editing: boolean;
  loading: boolean;
  errors: any;
  temp_notification: any;
}>();

const emit = defineEmits<{
  (event: "on-change", params: any): void;
  (event: "on-icon-change", params: any): void;
}>();

function emiting(property: string, value: any) {
  let temp = props.temp_notification;
  temp[property] = value;
  emit("on-change", temp);
}
</script>
