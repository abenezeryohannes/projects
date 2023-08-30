<template>
    <section class="w-full grid grid-cols-16 gap-x-1 py-auto ">


        <div class="relative pt-1 my-auto col-span-13">
            <div class="overflow-hidden  mb-4 text-xs flex rounded  " :class="[bgcolor, 'h-' + height]">
                <div :style="'width: ' + value + '%'"
                    class="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center "
                    :class="[accentcolor]"></div>
            </div>
        </div>

        <p class="col-span-3"> {{ value?.toFixed(0) }}% </p>

        <!-- <div class="shadow-lg rounded-lg w-full bg-background-light dark:bg-background-deepdark" :class="[ 'h-'+height]">
      </div> -->
    </section>
</template>
<script lang="ts" setup>
const props = defineProps<{
    value?: number, height?: string, bgcolor?: any, accentcolor?: any
}>();
</script>

<style>

</style>