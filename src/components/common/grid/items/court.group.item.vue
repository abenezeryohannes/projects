<template>
    <section>
        <div class="relative w-full rounded hover:bg-accentlight-light dark:bg-accentlight-dark bg-background-light 
              dark:hover:bg-background-darkish shadow-lg grid grid-cols-16 gap-x-3">
            <div class="static col-span-6 bg-background-lightish dark:bg-background-darkish">
                <image-form :local_image_file="icon" :deletable="false" @on-change="icon = $event[$event.length - 1]; emit('on-action', {
                    data: temp_data, action: 'edit', index: props.index,
                    files: (icon == null) ? [] : [{ name: 'icon', icon }]
                });" :editing="editing" :link="data.icon" :padding=0 :editable="true" :width=2999 :height=32
                    rounded="rounded-lg" />
            </div>
            <div v-if="hasCol('#actions#')" class="absolute top-1 right-0 z-10">
                <checkbox-form :value="checked" @on-change="checked = $event; $emit('on-select', { check: checked })"
                    :editing="true" />
            </div>
            <div class="relative col-span-10 font-semibold pr-3 pb-1 text-left capitalize"
                :class="[{ 'cursor-pointer': clickable }]" @click="onClick">

                <p class="  mb-1 mt-2 truncate text-sm mr-10"> {{ data.name }} </p>

                <!-- <div class="flex mb-3 truncate">
                    <p class=""> {{ data.name }} </p>
                </div> -->

                <div class="flex mb-2">
                    <p class=""> Color: {{ data.color }} </p>
                </div>


                <!-- <div class="flex mb-2">
                    <p class=""> Enabled: {{ data.enabled }} </p>
                </div> -->


                <div class=" flex mb-2 ">
                    <div class="font-light capitalize" >
                        <p v-if="data.enabled" class="text-success-light justify-centerpx-3 py-1"> {{ 'Active' }} </p>
                        <p v-else class="text-success-light justify-centerpx-3 py-1"> {{ 'In-Active' }} </p>
                    </div>
                </div>
                <!-- <div class="flex mb-3">
                      <p class=""> Courts: {{fM(data.price)}} </p>
                  </div> -->

                <!-- <div class=" absolute top-2 right-2 flex ">
                    <div class="text-ty font-light capitalize text-white" :class="[
                        // { 'bg-warning-light dark:bg-warning-dark rounded-2xl shadow-xl px-2 py-1 ': data.status.includes('issue') },
                        { 'bg-warning-light rounded-xl shadow-xl px-2 py-1 ': data.status.includes('waiting') },
                        { 'bg-error-light rounded-xl shadow-xl px-2 py-1 ': data.status.includes('in-active') },
                        // { 'bg-gray-700 rounded-2xl shadow-xl px-2 py-1 ': data.enabled  },
                        // { 'bg-gray-700 rounded-2xl shadow-xl px-2 py-1 ': data.status.includes('ended') },
                        { 'bg-success-light rounded-xl shadow-xl px-3 py-1 ': data.status == ('active') }
                    ]">
                        <p class=""> {{ data.status }} </p>
                    </div>
                </div> -->

            </div>
        </div>
    </section>
</template>
  
<script setup lang='ts'>

import webImage from '../../web-image.vue'
import { ref, watch } from 'vue';
import errorHandlerUtil from '../../../../data/util/error.handler.util';
import CheckboxForm from '../../../forms/checkbox.form.vue';
import { fM } from '../../../../util';
const props = defineProps<{
    index: any,
    data: any,
    headers: any[],
    clickable?: boolean,
    checkAll?: boolean,
    unCheckAll: boolean,
    error?: any,
}>();


const emit = defineEmits<{
    (event: 'bulk-action', param: any): void;
    (event: 'on-action', param: any): void;
    (event: 'on-select', param: any): void;
    (event: 'on-sort-change', param: any): void;
    (event: 'on-item-click', param: any): void;
    (event: 'on-page-change', param: any): void;
    (event: 'on-limit-change', param: any): void;
}>();


const icon = ref<any>({});
const temp_data = ref<any>({});
const editing = ref<boolean>(false);
const checked = ref<boolean>(false);
watch(() => props.error, (newVal, oldVal) => {
    temp_data.value = JSON.parse(JSON.stringify(newVal.body));
    // console.log('from row', e)
});

watch(() => editing, (newVal, oldVal) => {
    // console.log(newVal);
});

watch(() => props.unCheckAll, (newVal, oldVal) => {
    console.log('uncheckall', newVal);
    if (newVal == true)
        checked.value = false;
});

watch(() => props.checkAll, (newVal, oldVal) => {
    checked.value = newVal || false;
});

watch(() => temp_data, (newVal, oldVal) => {
    console.log(newVal);
});

function onClick() {
    if (props.clickable) emit('on-item-click', { body: props.data, index: props.index });
}
function hasCol(string: string) {
    for (var i = 0; i < props.headers?.length; i++) {
        if (props.headers[i].name == string) return true;
    }
    return false;
}
function getActions() {
    for (var i = 0; i < props.headers.length; i++) {
        if (props.headers[i].name == '#actions#') return props.headers[i].actions;
    }
    return ['edit'];
}
function parseError(key: any) { return props.error != null ? errorHandlerUtil.parse(props.error.errors, key) : null; }

function value(data: any, header: any) {
    var x = null;
    if (props.error != null && props.error.body != null) {
        x = props.error.body[header.name];
    } else if (editing.value) {
        x = temp_data.value[header.name];
    } else x = data[header.name]
    return x;
}

function update(key: string, value: any) {
    // console.log(key, value);
    temp_data.value[key] = value;
    //  console.log(temp_data.value);
}

function refresh() { editing.value = false; temp_data.value = {}; }

function onActionClick(data: any, action: string) {

    if (action == 'edit') {

        editing.value = true;
        if (props.error != null && props.error.body != null) { temp_data.value = JSON.parse(JSON.stringify(props.error)); }
        else temp_data.value = JSON.parse(JSON.stringify(data));
        // for (const [key, value] of Object.entries(x)) { this.$set(temp_data.value, key, value); }

    } else if (action == 'save') {

        editing.value = false
        emit('on-action', { body: temp_data.value, action: 'edit', orginal: data });

    } else if (action == 'cancel') {
        editing.value = false;
        emit('on-action', { body: temp_data.value, action: 'cancel', orginal: data });
    } else if (action == 'delete') {
        emit('on-action', { body: temp_data.value, action: 'delete', orginal: data });
    }
}


</script>

<style>

</style>