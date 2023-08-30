<template>
    <section name="modal" @click="clickedOutside" v-if="show" class="text-gray-900 dark:text-white 
                            bg-opacity-20 bg-gray-500   w-full h-full fixed block top-0 left-0 z-30 
                            transition-opacity ease-in-out duration-200 ">
        <div class="  h-full py-10 px-10 w-full bg-transparent flex justify-center modal-mask">
            <div @click.stop="clickedInside" class="modal-container 
                     scrollable max-h-full mx-auto my-auto rounded-lg 
                      px-5 pt-5 pb-3 shadow-lg bg-white dark:bg-sidebar-dark">
                <div class="flex text-left">
                    <div class=" pl-5">
                        <div class="pr-8">
                            <div class="font-semibold text-lg">
                                <slot name="header"> </slot>
                            </div>

                            <div class="font-normal text-md  pt-5">
                                <slot> </slot>
                            </div>
                        </div>
                        <div class="pr-8">
                            <slot name="footer"> </slot>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">import { ref } from 'vue';

const props = defineProps<{
    top?: string,
    bottom?: string
}>();

const id = ref<any>('none');
const show = ref<boolean>(false);
const autoClose = ref<boolean>(true);

defineExpose({ open, close });

function close() { show.value = false; }

function clickedInside() { }

function open(idd: any) {
    id.value = idd;
    show.value = true;
}

function clickedOutside() {
    if (autoClose.value == null || autoClose.value) { close(); }
}

</script>


<style>

</style>