<template>
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="0" stroke-linecap="round"
        stroke-linejoin="round"
        :class="['fill-current flex-no-shrink', 'text-' + props.fill, 'h-' + (size == null ? 8 : props.size), 'w-' + (props.size == null ? 8 : props.size), props.cls]">
        <keep-alive>
            <component :is="dynamicComponent"></component>
        </keep-alive>
    </svg>
</template>

<script setup lang="ts" >
import { computed } from 'vue';
import { defineAsyncComponent } from 'vue'

const dynamicIcon = computed(() => `v-${(props.icon == null ? 'notification' : props.icon)}`);
const dynamicFill = computed(() => 'text-' + props.fill); 

const dynamicComponent = defineAsyncComponent(() =>
  import(`./svg/${dynamicIcon.value}.vue`)
) 

const props = defineProps<{
    icon: string,
    size: number,
    cls?: any,
    fill: string
}>();

</script> 