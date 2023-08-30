<template>
    <section ref="root">
        <input ref="file" v-show="false" type="file" id="imgpckr" class="slotted" />

        <div v-if="editing && link == null && editable" class="relative cursor-pointer" @click="onClick">
            <web-image :clickable="true" :rounded="rounded" class="bg-transparent" :link="link"
                :local_image_file="local_image_file" :width="width" :height="height" :padding="padding" />
            <v-icon icon="add" fill="white" :size="8" class="center_absolute z-20" />
            <div :class='["absolute left-0 top-0 z-10 bg-black w-full h-full opacity-30", rounded]' />
        </div>

        <div v-else-if="editing" class="relative cursor-pointer">
            <web-image :clickable="true" :rounded="rounded" class="bg-transparent" :local_image_file="local_image_file"
                :link="link" :width="width" :height="height" :padding="padding" />
            <div class="absolute z-20 flex top-1/3 w-full text-center ">
                <div v-show="editable" @click="onClick" class=" mx-auto">
                    <v-icon icon="edit" fill="white" :size="6" />
                </div>
                <div v-show="deletable" @click="onDelete" class=" mx-auto">
                    <v-icon icon="delete" fill="white" :size="6" />
                </div>
            </div>
            <div :class='["absolute left-0 top-0 z-10 bg-black w-full h-full opacity-30", rounded]' />
        </div>

        <div v-else>
            <web-image :clickable="true" :rounded="rounded" :link="link" :width="width" :height="height"
                :padding="padding" />
        </div>

    </section>
</template>

<script setup lang="ts" >

import vIcon from '../icons/v-icon.vue'
import WebImage from '../common/web-image.vue'
import { onMounted, ref } from 'vue';

const props = withDefaults(defineProps<{
    editable?: boolean,
    deletable?: boolean,
    rounded?: string,
    link?: string,
    local_image_file?: any,
    width?: number,
    height?: number,
    padding?: number,
    editing: boolean,
}>(), {
    editable: true,
    deletable: true,
    rounded: 'rounded-full',
    local_image_file: null,
    width: 20,
    height: 20,
    padding: 0,
});

const imageUrl = ref<string | null>(null);
const image = ref<any>(null);
const files = ref<any[]>([]);
const root = ref<any>(null); 
const input = ref<any>(null);

const emit = defineEmits<{
    (event: 'on-change', param: any): void
    (event: 'on-delete', param: any): void
}>();

onMounted(() => {
    input.value = root.value?.querySelector('input[type=file]');
    if (input.value != null) {
        input.value.addEventListener('change', () => onFilePicked());
        input.value.style.display = 'none';
    }
});

function onDelete() { emit('on-delete', props.link); }

function onClick() {
    onPickFile();
}

function onSubmit() { emit('on-change', null); }

function onPickFile() {
    const event = new MouseEvent('click', {
        'view': window,
        'bubbles': true,
        'cancelable': true
    });
    input.value.dispatchEvent(event)
}

function onFilePicked() {
    for (let file of input.value.files) {
        files.value.push(file)
    }
    emit('on-change', files.value);
    input.value.value = null;
}

// function removeFile(index: number) {
//     files.value.splice(index, 1) 
// }

// watch(files, (val, old) => {
//     emit('on-change', val)
// });
</script>

<style>

</style>