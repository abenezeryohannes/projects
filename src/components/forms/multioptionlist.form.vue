<template>
  <section>
    <!-- <div> -->
    <!-- <p class="capitalize"> {{t(label.toLowerCase())}} </p> -->
    <div class="flex flex-wrap gap-y-3 gap-x-3">
      <div class="" v-for="option in options" :key="option.name">

        <div v-if="editing">

          <p class="hover:text-primary-light text-sm capitalize cursor-pointer"
            :class="[{ 'font-bold text-primary-light': does_contain(selected, option) }]"
            @click="does_contain(selected, option) ? remove_from_array(selected, option) : selected.push(option); emit('on-change', selected); ">
            {{ t(option.name.toLowerCase()) }} </p>

        </div>



        <div v-else>
          <div v-if="does_contain(values, option) || (showAllList)">
            <p class=""
              :class="[{ 'text-bold text-primary-light capitalize ': does_contain(values, option) && showAllList }]">
              {{ t(option.name.toLowerCase()) }} </p>
          </div>
        </div>


      </div>
    </div>
    <!-- </div> -->
  </section>
</template>

<script setup lang="ts">
import { onMounted, ref, watch } from 'vue';
import { useI18n } from '../../i18n';

const { t } = useI18n();

const props = defineProps<{
  values: any, showAllList: boolean,
  label: any, editing: boolean, options: any,
}>();

const emit = defineEmits<{ (event: 'on-change', params: any): void }>();

const selected = ref<any[]>([]);

watch(() => props.values, (val, old) => { selected.value = val; })

onMounted(() => { selected.value = props.values })

function does_contain(x: any[], y: any) {
  if (x.includes(y)) return true;
  else {
    for (var i = 0; i < x.length; i++) {
      if (x[i].id == y.id) return true;
    }
  }
  return false;
}

function remove_from_array(x: any[], y: any) {
  for (var i = 0; i < x.length; i++) {
    if (x[i] === y || x[i].id == y.id) { x.splice(i, 1); return; }
  }
} 
</script>

<style>

</style>