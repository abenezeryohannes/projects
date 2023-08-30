<template>
    <section>
        <div :class="[{
            'relative w-full rounded hover:bg-accentlight-light dark:bg-accentlight-dark bg-background-light dark:hover:bg-background-darkish shadow-lg': true
        },
        { 'border-blue-500 border-solid border-2': data.enabled }]">
            <div class="static w-full">
                <web-image class="w-full h-44" rounded="rounded-lg" :width="2999" :link="data.banner" :padding=0 />
            </div>
            <div v-if="hasCol('#actions#')" class="absolute top-1 right-0 z-10">
                <checkbox-form :value="checked" @on-change="checked = $event;
                $emit('on-select', {check: checked})" :editing="true" />
            </div>
        </div>
    </section>
</template>

<script setup lang='ts'>

import webImage from '../../web-image.vue'
import { ref, watch } from 'vue';
import errorHandlerUtil from '../../../../data/util/error.handler.util';
import CheckboxForm from '../../../forms/checkbox.form.vue';




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