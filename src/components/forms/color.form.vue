<template>
  <section>
    <div>
      <div v-if="editing" :class="[cls]" class="flex ">

        <div class="my-auto mx-auto">
          <input :style="`background-color: ${props.value};`" type="color" name="field"
            class="rounded w-100 py-2 cursor-pointer block pl-6 pr-6"
            @input="emit('on-change', ($event.target as HTMLInputElement).value)" :placeholder="placeholder"
            :value="value" :disabled="!enabled && enabled != undefined" />
        </div>

        <div v-if="error != null" class=" ">
          <p class="mt-2 col-start-2 text-red-600 text-xs"> {{ error }}</p>
        </div>

        <div v-if="errorserror != null" class=" ">
          <p class="mt-2 col-start-2 text-red-600 text-xs"> {{ errorserror }}</p>
        </div>

      </div>
      <div v-else class="flex">
        <div :style="`background-color: ${props.value};`"
          class="w-5 h-4 my-auto mx-auto rounded border border-gray-400"></div>
        <p class="px-2" :name="name" :class="[cls]"> {{ value }}</p>
      </div>

    </div>

  </section>
</template>

<script setup lang="ts">
 
import { onMounted, watch, ref } from 'vue';
import errorHandlerUtil from '../../data/util/error.handler.util'

const props = withDefaults(defineProps<{
  value?: string, type?: string, error?: any, cls?: any, errors?: any[], identifier?: string
  name?: string, editing: boolean, placeholder?: string, enabled?: boolean
}>(), { enabled: true });

const emit = defineEmits<{ (event: 'on-change', param: string): void }>();

const errorserror = ref<any>(null);

watch(() => props.errors, (val, oldVal) => errorserror.value = (props.name != null) ? errorHandlerUtil.parse(val, props.name) : null);

watch(() => props.value, (val, oldVal) => { updateColor(val); });

watch(() => props.editing, (val, oldVal) => { updateColor(); });

onMounted(() => updateColor());

function updateColor(c?: string) {
  // console.log('update color', c);
  // :id="'edCol' + identifier"
  const color = document.getElementById(`color${props.identifier}`);

  const edCol = document.getElementById(`edCol${props.identifier}`);

  if (color != null && (props.value != null || c != null)) {
    color.style.backgroundColor = (c == undefined || null ? props.value : c)!;
  }

  if (edCol != null && (props.value != null || c != null)) {
    edCol.style.backgroundColor = (c == undefined || null ? props.value : c)!;
  }

}


</script>

<style>

</style>