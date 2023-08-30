<template>
    <section name="modal" @click="clickedOutside" v-if="show" class="text-gray-900 dark:text-white 
                            bg-opacity-20 bg-gray-500   w-full h-full fixed block top-0 left-0 z-30 
                            transition-opacity ease-in-out duration-200 ">
        <div class="  h-full py-0 pl-10 w-full bg-transparent flex justify-end modal-mask">
            <!-- <div @click="clickedOutside" class="modal-mask  bg-background-dark  w-full top-0 left-0 fixed z-30 h-full dark:bg-background-light opacity-20  ">
            </div> -->
            <!-- <div class="modal-container px-5 pt-5 pb-3 absolute md:left-1/3 transform md:-translate-x-1/4  z-50 rounded-lg shadow-lg 
                        bg-background-light dark:bg-background-dark scrollable max-h-full"
                        :class="[('bottom-'+0), 'right-'+0, 'top-'+0]"
                        > -->
            <div @click.stop="clickedInside" class="modal-container 
                     scrollable max-h-full rounded-lg h-full
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

defineExpose({
    open, close
});

function close() {
    show.value = false;
}

function clickedInside() { }

function open(idd: any) {
    id.value = idd;
    show.value = true;
}

function clickedOutside() {
    if (autoClose.value == null || autoClose.value) {
        close();
    }
}

</script>
 


<style>

</style>