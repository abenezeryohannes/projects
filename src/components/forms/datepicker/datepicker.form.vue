<template>
    <section class="w-full">
        <div v-if="!editing" class="">
            <p class=" capitalize">
                {{ (original == null||value==null) ? '-' : dd(value, 's') }} </p>
        </div>
        <!-- <div v-else-if="calendar.toLowerCase().startsWith('et')" class="w-full">
            <et-date-picker :gravity='gravity' class="w-full" :value="value" :editing="editing"
                @on-change="$emit('on-change', $event)" />
        </div> -->
        <div v-else class="w-full">
            <grig-date-picker :gravity='gravity' class="w-full" :value="value" :editing="editing"
                @on-change="$emit('on-change', $event)" />
        </div>
        <div class=" text-red-600 ml-2 " v-if="editing && error != null">
            {{ error }}
        </div>
    </section>
</template>

<script setup lang="ts">

import { computed, onMounted } from 'vue';
import errorHandlerUtil from '../../../data/util/error.handler.util'
import { useStore } from '../../../store';
// import etDatePicker from './datepicker.et.form.vue'
import grigDatePicker from './datepicker.grig.form.vue'
import { dd } from '../../../util';

const props = defineProps<{
    value?: Date | null, errors?: any[], name?: string,
    editing: boolean, editonly?: boolean, gravity?: any, original?: Date | null,
}>();

const store = useStore();

onMounted(() => {
    if (props.value instanceof Date)
        console.log('value1 ', (props.value).toDateString());
    console.log('value2 ', new Date().toDateString());
});
const calendar = computed(() => { return store.getters.user.calendar; });
const error = computed(() => { return props.name == null ? null : errorHandlerUtil.parse(props.errors, props.name) });
 
</script>

<style>

</style>