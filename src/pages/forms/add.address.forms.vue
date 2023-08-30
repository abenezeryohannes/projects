<template>
    <section class=" text-left font-semibold w-full mb-24">
        <div class="flex gap-x-4">
<!-- 
            <image-form :local_image_file="icon" :deletable="false" :errors="errors"
                @on-change="icon = $event[$event.length - 1]; emit('on-icon-change', icon);" :editing="editing"
                :link="temp_address.icon" :padding=0 :editable="true" :width=14 :height=14 rounded="rounded-xl" /> -->

            <singletext-form class=" text-lg font-bold " name="name" @on-change="emiting('name', $event)"
                :editing="editing" placeholder="Name" label="name" :value="temp_address.name" :errors="errors" />

        </div>

        <div class="grid gap-x-8"
            :class="[{ 'grid-cols-2 gap-y-10 gap-x-10 mt-10': editing }, 
                { 'grid-cols-1  mt-3': !editing }]">

            <!-- <form-control v-bind="{
                    type: 'number', name: 'sequence', value: temp_address.sequence, label_cls: ``,
                    label: `sequence`, editing: editing,
                    errors: errors, direction: `vertical`, min: 1, max: 100
                }" @on-change="emiting('sequence', $event)"/>

                <form-control v-bind="{
                    type: 'color', name: 'color', value: temp_address.color, label_cls: ``,
                    label: `color`, editing: editing, errors: errors, direction: `vertical`, enabled: true
                }" @on-change="emiting('color', $event)" :enabled="true" /> -->

            <form-control v-bind="{
                type: 'toggle', name: 'enabled', value: temp_address.enabled, label_cls: ``,
                label: `enabled`, editing: editing, positive: 'yes', negative: 'no',
                errors: errors, direction: `horizontal`,
            }" :value="temp_address.enabled" @on-change="emiting('enabled', $event)" :width="4" :height="4" />

        </div>

    </section>
</template>
  
<script setup lang="ts">

import SingletextForm from '../../components/forms/singletext.form.vue'
import FormControl from "../../components/formcontrollers/formcontrol.vue";
import imageForm from '../../components/forms/image.form.vue';
import { ref } from 'vue';

const icon = ref<any>();

const props = defineProps<{
    editing: boolean,
    loading: boolean,
    errors: any,
    temp_address: any,
}>();

const emit = defineEmits<{
    (event: 'on-change', params: any): void
    (event: 'on-icon-change', params: any): void
}>();

function emiting(property: string, value: any) {
    let temp = props.temp_address;
    temp[property] = value;
    emit('on-change', temp);
}

</script>