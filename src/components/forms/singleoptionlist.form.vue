<template>
  <section>
      <div>
         <p class="capitalize"> {{(label?.toLowerCase())}} </p>
            <div class=" flex flex-row mt-3 mb-5">
              <div class="mx-5" v-for="option in options" :key="option.name">
                <div v-if="option.color != null" 
                :class="[{'bg-white': option.color === 'white'}, {'bg-gray-800': option.color === 'black'}
                , {'w-4 h-4': selected !== option.name}
                , {'w-5 h-5': selected === option.name}]"
                class="rounded-full bg-white border-2 shadow-lg border-gray-200 mx-auto mb-2">
                </div>
                <div v-if="editing">
                  <p class="hover:text-primary-light text-sm capitalize  cursor-pointer" 
                  :class="[{'font-bold text-primary-light': selected === option.name}]"
                    @click="emit('on-change', option);selected=option.name" >
                     {{t(option.label.toLowerCase())}} </p>
                </div>
                <div v-else>
                  <p :class="[{'text-bold text-primary-light capitalize ': value === option.name}]"> {{t(option.label.toLowerCase())}} </p>
                </div>
              </div>
            </div>
      </div>
  </section>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import { useI18n } from '../../i18n';

const {t} = useI18n();

const props = defineProps<{
    value?: number, editing?: boolean, label?: string, options?: any[]
}>();

const selected = ref<any>(props.value);

watch(() => props.value, (val, x) => {selected.value = val;});
 
const emit = defineEmits<{
  (event: 'on-change', param: string): void
}>();
</script>

<style>

</style>