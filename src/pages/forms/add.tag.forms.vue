<template>
  <section class="text-left font-semibold w-full mb-24 select-none">
    <div class="flex gap-x-4">
      <!-- 
            <image-form :local_image_file="icon" :deletable="false" :errors="errors"
                @on-change="icon = $event[$event.length - 1]; emit('on-icon-change', icon);" :editing="editing"
                :link="temp_address.icon" :padding=0 :editable="true" :width=14 :height=14 rounded="rounded-xl" /> -->

      <singletext-form
        class="text-lg font-bold"
        name="name"
        @on-change="emiting('name', $event)"
        :editing="editing"
        placeholder="Name"
        label="name"
        :value="temp_tag.name"
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
          type: 'autocomplete',
          name: 'type',
          value: temp_tag.type,
          label_cls: ``,
          label: `Type`,
          editing: editing,
          errors: errors,
          direction: `vertical`,
          option_name: 'type',
          can_add: false,
          link: 'tags/types',
        }"
        @on-change="emiting('type', $event.type)"
      />

      <form-control
        v-bind="{
          type: 'textarea',
          name: 'desc',
          value: temp_tag.desc,
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
          value: temp_tag.isActive,
          label_cls: ``,
          label: `Active`,
          editing: editing,
          positive: 'yes',
          negative: 'no',
          errors: errors,
          direction: `horizontal`,
        }"
        :rows="10"
        :value="temp_tag.isActive"
        @on-change="emiting('isActive', $event)"
        :width="4"
        :height="4"
      />

      <form-control
        v-bind="{
          type: 'toggle',
          name: 'canDetermine',
          value: temp_tag.canDetermine,
          label_cls: ``,
          label: `Can Determine`,
          editing: editing,
          positive: 'yes',
          negative: 'no',
          errors: errors,
          direction: `horizontal`,
        }"
        :rows="10"
        :value="temp_tag.canDetermine"
        @on-change="emiting('canDetermine', $event)"
        :width="4"
        :height="4"
      />
    </div>
  </section>
</template>

<script setup lang="ts">
import SingletextForm from "../../components/forms/singletext.form.vue";
import FormControl from "../../components/formcontrollers/formcontrol.vue";
// import imageForm from '../../components/forms/image.form.vue';

// const icon = ref<any>();

const props = defineProps<{
  editing: boolean;
  loading: boolean;
  errors: any;
  temp_tag: any;
}>();

const emit = defineEmits<{
  (event: "on-change", params: any): void;
  (event: "on-icon-change", params: any): void;
}>();

function emiting(property: string, value: any) {
  let temp = props.temp_tag;
  temp[property] = value;
  emit("on-change", temp);
}
</script>
