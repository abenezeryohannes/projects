<template>
  <section>
    <div :class="[{ 'gap-y-8 gap-x-8  grid-cols-1 md:grid-cols-2 lg:grid-cols-3': cols == null }, cols]"
      class="w-full grid ">

      <div class=" " v-for="(body, index) in tableData" :key="index">

        <grid-item @on-item-click="emit('on-item-click', $event)" :clickable="clickable" :item="item"
          @on-action="emit('on-action', {index:index, body:$event.body, action:$event.action, orginal:$event.orginal})"
          @on-select="emit('on-select', {index: index, check: $event.check} )" :checkAll="checkAll"
          :unCheckAll="unCheckAll" :data="body" :headers="headers" :error="parseError(index)" :index="index" />

      </div>
    </div>
  </section>
</template>

<script setup lang="ts">

import { ref, watch } from 'vue';
import gridItem from './grid.item.vue';

const props = defineProps<{
  cols?: any[],
  tableData: any[],
  item: string,
  errors?: any[],
  headers: any,
  unCheckAll?: any,
  checkAll?: any,
  clickable?: boolean,
}>();

const temp_tableData = ref<any>({});
const editing = ref<number>(-1);

watch(() => props.tableData, (newVal, oldVal) => {
  refresh();
})

watch(() => editing.value, (e, old) => {
  if (e > 0) {
    temp_tableData.value = JSON.parse(JSON.stringify(props.tableData[e]));
  }
});

watch(() => temp_tableData.value, (newVal, oldVal) => { console.log(newVal) });


const emit = defineEmits<{
  (event: 'bulk-action', param: any): void;
  (event: 'on-action', param: any): void;
  (event: 'on-select', param: any): void;
  (event: 'on-sort-change', param: any): void;
  (event: 'on-item-click', param: any): void;
  (event: 'on-page-change', param: any): void;
  (event: 'on-limit-change', param: any): void;
}>();


function parseError(index: any) {
  var error = null;
  props.errors?.forEach(element => {
    if (element.index == index) error = element;
  });
  return error;
}

function value(index: any, body: any[], header: any) { return (editing.value != index) ? body[header.name] : temp_tableData.value[header.name] }

function update(key: string, value: any) {
  // console.log(key, value);
  temp_tableData.value[key] = value;
  // console.log(temp_tableData.value);
}

function refresh() { editing.value = -1; temp_tableData.value = {}; }

function onActionClick(body: any[], action: any, index: any) {

  if (action == 'edit') {

    editing.value = index;
    var x = JSON.parse(JSON.stringify(props.tableData[index]));
    for (const [key, value] of Object.entries(x)) { temp_tableData.value[key] = value; }

  } else if (action == 'save') {

    editing.value = -1
    emit('on-action', { body: temp_tableData.value, action: 'edit', index: index });

  } else if (action == 'cancel') {

    // console.log('cancel');
    editing.value = -1;

  } else if (action == 'delete') {

    emit('on-action', { body: body, action: action, index: index });

  }
  action = body;
}



</script>

<style>

</style>