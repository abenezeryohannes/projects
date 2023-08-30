
<template>
  <div class="">
    <div v-if="editing" @click="toggleValue = !toggleValue; emit('on-change', toggleValue)"
      class="flex items-center bg-gray-300 dark:bg-background-darkish rounded-full p-1 duration-300 ease-in-out"
      :class="['bg-background-light dark:bg-background-lightish shadow-lg', 'w-' + (width * (5 / 2)), 'h-' + (height + 2)]">
      <div class="rounded-full shadow-md transform duration-300 ease-in-out" 
          :class="[{ 'bg-accent-light dark:bg-accent-dark shadow-lg': toggleValue },
      { 'bg-gray-300 dark:bg-background-dark shadow-lg': !toggleValue },
      'w-' + width, 'h-' + height, { 'translate-x-4': toggleValue }]">
      </div>
    </div>

    <div v-else>
      <p v-if="toggleValue" :class="[cls, { 'text-accent-light dark:text-accent-dark': cls == null }]"> {{ positive }} </p>
      <p v-else :class="[cls]"> {{ negative }} </p>
    </div>

  </div>
</template>

<script setup lang="ts">

import { onMounted, ref, watch } from 'vue';

const translate = ref<number>(2);
const toggleValue = ref<boolean>(false);
  
const props = withDefaults(defineProps<{
  toggle?: boolean, width?: number, height?: number, positive?: string, negative?: any, cls?: any,
    editing: boolean
}> (), {width: 8, height: 8, toggle: false});
const emit = defineEmits<{
    (event: 'on-change', param: any): void;
}>();
watch(() => props.width, (newVal, oldVal) => {
  translate.value = (props.toggle) ? newVal! / 2 : 0;
});

watch(() => props.toggle, (newVal, oldVal) => {
  if (newVal) translate.value = 0;
  else translate.value = props.width / 2;
  toggleValue.value = (newVal == null) ? true : newVal
});

onMounted(() => {
  toggleValue.value = props.toggle!;
  translate.value = (props.toggle) ? props.width / 2 : 0;
});
 
</script>