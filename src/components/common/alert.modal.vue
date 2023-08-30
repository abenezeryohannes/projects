<template>
    <section name="modal" v-if="show"
        class="text-gray-700 dark:text-white 
                                w-full h-full fixed block top-0 left-0 z-30 transition-opacity ease-in-out duration-200 ">
        <div class="relative">
            <div @click="clickedOutside"
                class="modal-mask  bg-background-dark  w-full top-0 left-0 fixed z-30 h-full dark:bg-background-light opacity-20  ">
            </div>
            <div
                class="modal-container px-5 pt-5 pb-3 absolute top-32 left-1/2 transform -translate-x-1/2  z-50 rounded-lg shadow-lg bg-background-light dark:bg-background-deepdark ">

                <div class="flex text-left">

                    <div class="">
                        <v-icon v-show="icon != 'none' && type != 'warning' && type != 'error' && type != 'success'"
                            :icon="icon" cls="dark:text-white" fill="gray-600" :size=8 />
                        <v-icon v-show="icon != 'none' && type == 'warning'" :icon="icon" cls="dark:warning-dark"
                            fill="warning-light" :size=8 />
                        <v-icon v-show="icon != 'none' && type == 'error'" :icon="icon" cls="dark:error-dark"
                            fill="error-light" :size=8 />
                        <v-icon v-show="icon != 'none' && type == 'success'" :icon="icon" cls="dark:success-dark"
                            fill="success-light" :size=8 />
                    </div>

                    <div class=" pl-5">
                        <div class="mr-14">
                            <div class="font-semibold text-lg">
                                <p> {{ title }} </p>
                            </div>

                            <div class="font-normal text-md  pt-5">
                                <p> {{ body }} </p>
                            </div>
                        </div>


                        <div class="flex justify-end mt-8">

                            <div @click="emit('on-change', { id: id, data: data, action: 'no' }); close();"
                                v-if="actions.includes('no')"
                                class="ml-3 cursor-pointer dark:hover:text-error-light hover:text-error-dark px-1 py-1 font-semibold capitalize">
                                <p> {{ $t('no') }}</p>
                            </div>

                            <div @click="emit('on-change', { id: id, data: data, action: 'yes' }); close();"
                                v-if="actions.includes('yes')"
                                class="cursor-pointer ml-3 dark:hover:text-success-light hover:text-success-dark px-1 py-1 font-semibold capitalize">
                                <p> {{ $t('yes') }}</p>
                            </div>

                            <div @click="emit('on-change', { id: id, data: data, action: 'cancel' }); close();"
                                v-if="actions.includes('cancel')"
                                class="ml-3 cursor-pointer dark:hover:text-error-light hover:text-error-dark px-1 py-1 font-semibold capitalize">
                                <p> {{ $t('cancel') }}</p>
                            </div>

                            <div @click="emit('on-change', { id: id, data: data, action: 'oK' }); close();"
                                v-if="actions.includes('ok')"
                                class="cursor-pointer ml-3 dark:hover:text-success-light hover:text-success-dark px-1 py-1 font-semibold capitalize">
                                <p> {{ $t('ok') }}</p>
                            </div>

                            <div @click="emit('on-change', { id: id, data: data, action: 'save' }); close();"
                                v-if="actions.includes('save')"
                                class="cursor-pointer ml-3 dark:hover:text-success-light hover:text-success-dark px-1 py-1 font-semibold capitalize">
                                <p> {{ $t('save') }}</p>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import vIcon from '../icons/v-icon.vue';

const id = ref<string>('none');
const show = ref<boolean>(false);
const autoClose = ref<boolean>(true);
const type = ref<string>('');
const title = ref<string>('');
const body = ref<string>('');
const data = ref<any>(null);
const icon = ref<string>('none');
const actions = ref<any[]>([]);


const emit = defineEmits<{
    (event: 'on-change', param: any): void
}>();

function close() {
    show.value = false;
}
defineExpose({
    open,
});

function open(x: { type: string, body: string, title: string, actions: any[], icon: string, id: any, data: any }) {
    icon.value = x.icon == null ? 'none' : x.icon;
    type.value = x.type; body.value = x.body; id.value = x.id; data.value = x.data;
    title.value = x.title; actions.value = actions == null ? [] : x.actions; show.value = true;
}

function clickedOutside() {
    if (autoClose.value == null || autoClose.value) {
        emit('on-change', { id: id.value, action: 'cancel' });
        close();
    }
}

</script>


<style>

</style>