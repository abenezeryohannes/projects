<template>
    <section class=" text-left font-semibold w-full mb-24">
        <div class="flex gap-x-4">

            <image-form v-if="temp_ad.link==null||temp_ad.link.length==0" :local_image_file="banner" :deletable="false" :errors="errors"
                @on-change="banner = $event[$event.length - 1]; emit('on-icon-change', banner);" :editing="editing"
                :link="temp_ad.banner" :padding=0 :editable="true" :width=44 :height=44 rounded="rounded-xl" />

            <!-- <singletext-form class=" text-lg font-bold " name="link" @on-change="emiting('link', $event)"
                :editing="editing" placeholder="link" label="link" :value="temp_ad.link" :errors="errors" /> -->

        </div>
        
        <singletext-form  v-if="banner==null&&false" class="mt-7 text-base font-bold " name="link" @on-change="emiting('link', $event)"
                :editing="editing" placeholder="inpute image link (optional)" label="link" :value="temp_ad.link" :errors="errors" />

        <div class="grid gap-x-8"
            :class="[{ 'grid-cols-2 gap-y-10 gap-x-10 mt-10': editing }, 
                { 'grid-cols-1  mt-3': !editing }]">

           

            <form-control v-bind="{
                type: 'toggle', name: 'enabled', value: temp_ad.enabled, label_cls: ``,
                label: `enabled`, editing: editing, positive: 'yes', negative: 'no',
                errors: errors, direction: `horizontal`,
            }" :value="temp_ad.enabled" @on-change="emiting('enabled', $event)" :width="4" :height="4" />

        </div>

    </section>
</template>
  
<script setup lang="ts">

import SingletextForm from '../../components/forms/singletext.form.vue'
import FormControl from "../../components/formcontrollers/formcontrol.vue";
import imageForm from '../../components/forms/image.form.vue';
import { ref } from 'vue';

const banner = ref<any>();

const props = defineProps<{
    editing: boolean,
    loading: boolean,
    errors: any,
    temp_ad: any,
}>();

const emit = defineEmits<{
    (event: 'on-change', params: any): void
    (event: 'on-icon-change', params: any): void
}>();

function emiting(property: string, value: any) {
    let temp = props.temp_ad;
    temp[property] = value;
    emit('on-change', temp);
}

</script>