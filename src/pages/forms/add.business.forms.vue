<template>
  <section class="text-left font-semibold w-full mb-24 select-none">
    <div class="flex gap-x-4">
      <image-form
        :local_image_file="banner"
        :deletable="false"
        :errors="errors"
        @on-change="
          banner = $event[$event.length - 1];
          emit('on-icon-change', banner);
        "
        :editing="editing"
        :link="temp_company.banner"
        :padding="0"
        :editable="true"
        :width="14"
        :height="14"
        rounded="rounded-xl"
      />

      <singletext-form
        class="text-lg font-bold"
        name="name"
        @on-change="emiting('name', $event)"
        :editing="editing"
        placeholder="Name"
        label="name"
        :value="temp_company.name"
        :errors="errors"
      />

      <singletext-form
        class="text-lg font-bold"
        name="arabicName"
        @on-change="emiting('arabicName', $event)"
        :editing="editing"
        placeholder="Arabic Name"
        label="Arabic Name"
        :value="temp_company.arabicName"
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
          type: 'text',
          name: 'url',
          value: temp_company.url,
          label_cls: ``,
          label: `Link`,
          editing: editing,
          errors: errors,
          direction: `vertical`,
        }"
        @on-change="emiting('url', $event)"
      />

      <form-control
        v-bind="{
          type: 'text',
          name: 'phoneNumber',
          value: temp_company.phoneNumber,
          label_cls: ``,
          label: `Phone`,
          editing: editing,
          errors: errors,
          direction: `vertical`,
        }"
        @on-change="emiting('phoneNumber', $event)"
      />

      <form-control
        v-bind="{
          type: 'text',
          name: 'deliveryTime',
          value: temp_company.deliveryTime,
          label_cls: ``,
          label: `Delivery Time`,
          editing: editing,
          errors: errors,
          direction: `vertical`,
        }"
        @on-change="emiting('deliveryTime', $event)"
      />

      <form-control
        v-bind="{
          type: 'text',
          name: 'deliveryFee',
          value: temp_company.deliveryFee,
          label_cls: ``,
          label: `Delivery Fee`,
          editing: editing,
          errors: errors,
          direction: `vertical`,
        }"
        @on-change="emiting('deliveryFee', $event)"
      />

      <form-control
        v-bind="{
          type: 'text',
          name: 'budge',
          value: temp_company.budge,
          label_cls: ``,
          label: `Budge`,
          editing: editing,
          errors: errors,
          direction: `vertical`,
        }"
        @on-change="emiting('badge', $event)"
      />

      <!-- <form-control
        v-bind="{
          type: 'color',
          name: 'budgeColor',
          value: temp_company.badgeColor,
          label_cls: ``,
          label: `Budge Color`,
          editing: editing,
          errors: errors,
          direction: `vertical`,
        }"
        @on-change="emiting('budgeColor', $event)"
      /> -->
      <form-control
        v-bind="{
          type: 'color',
          name: 'badgeColor',
          value: temp_company.badgeColor,
          label_cls: ``,
          label: `Badge Color`,
          editing: editing,
          errors: errors,
          direction: `vertical`,
          enabled: true,
        }"
        @on-change="emiting('badgeColor', $event)"
        :enabled="true"
      />

      <form-control
        v-bind="{
          type: 'textarea',
          name: 'desc',
          value: temp_company.desc,
          label_cls: ``,
          label: `Description`,
          editing: editing,
          errors: errors,
          direction: `vertical`,
          min: 1,
          max: 100,
        }"
        @on-change="emiting('desc', $event)"
      />
      <!-- <form-control v-bind="{
                    type: 'color', name: 'color', value: temp_address.color, label_cls: ``,
                    label: `color`, editing: editing, errors: errors, direction: `vertical`, enabled: true
                }" @on-change="emiting('color', $event)" :enabled="true" /> -->

      <form-control
        v-bind="{
          type: 'toggle',
          name: 'isActive',
          value: temp_company.isActive,
          label_cls: ``,
          label: `Active`,
          editing: editing,
          positive: 'yes',
          negative: 'no',
          errors: errors,
          direction: `horizontal`,
        }"
        :rows="10"
        :value="temp_company.isActive"
        @on-change="emiting('isActive', $event)"
        :width="4"
        :height="4"
      />
    </div>
  </section>
</template>

<script setup lang="ts">
import SingletextForm from "../../components/forms/singletext.form.vue";
import FormControl from "../../components/formcontrollers/formcontrol.vue";
import { ref } from "vue";
import imageForm from "../../components/forms/image.form.vue";

const banner = ref<any>();

const props = defineProps<{
  editing: boolean;
  loading: boolean;
  errors: any;
  temp_company: any;
}>();

const emit = defineEmits<{
  (event: "on-change", params: any): void;
  (event: "on-icon-change", params: any): void;
}>();

function emiting(property: string, value: any) {
  let temp = props.temp_company;
  temp[property] = value;
  emit("on-change", temp);
}
</script>
