<template>
  <section>
    <keep-alive>
      <component :is="dynamicComponent" :checkAll="checkAll" :clickable="clickable" :unCheckAll="unCheckAll" 
        :data="data" :headers="headers"
        :error="error" :index="index" @on-item-click="emit('on-item-click', $event)"
        @on-action="emit('on-action', $event)" @on-select="emit('on-select', $event)" >
      </component>
    </keep-alive>
  </section>
</template>

<script setup lang="ts">
import { defineAsyncComponent, ref } from 'vue'; 

const props = defineProps<{
  index: number,
  data: any[],
  item: string,
  error?: any,
  headers: any,
  unCheckAll?: any,
  checkAll?: any,
  clickable?: boolean,
}>();

const temp_data = ref<any>({});
const editing = ref<boolean>(false);
const checked = ref<boolean>(false);

 
const dynamicComponent = defineAsyncComponent(() => import(`./items/${props.item}.item.vue`) ) 

const emit = defineEmits<{
  (event: 'on-select', param: any): void;
  (event: 'on-action', param: any): void;
  (event: 'on-item-click', param: any): void;
}>();

</script>

<style>

</style>