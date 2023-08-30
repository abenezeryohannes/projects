<template>
  <section class=" ">
      <div v-if="!editing" class="capitalize" >
            <p :class="[{'text-gray-400': (min == null || max == null )}]"> 
                    {{ (min == null)? $t('select_start_date') : $date.dd(min, 's')  }}   -     {{  (max == null)? $t('select_end_date') : $date.dd(max, 's')}}
<!--                {{$date.diff(this, min, max)}}-->
            </p>
      </div>
      <!-- <div v-else-if="calendar.toLowerCase().startsWith('et')" class="w-full">
          <et-date-picker :value="value" :editing="editing" @on-change="$emit('on-change', $event)" />
      </div> -->
      <div v-else class=" ">
          <grig-date-range-picker :icon_direction="icon_direction" class="" :gravity="gravity" :label_cls="label_cls" :value_cls="value_cls"
                                  :min="min" :max="max" :editing="editing" @on-change="$emit('on-change', $event)" />
      </div>
      <div class=" text-red-600 ml-2 " v-if=" editing && error != null " > 
          {{ this.error }}
      </div>
  </section>
</template>

<script>
import errorHandlerUtil from '../../../modules/util/error.handler.util'

// import etDatePicker from './datepicker.et.form'
import grigDateRangePicker from './daterangepicker.grig.form.vue'
export default {
    name: 'date-rangepicker-form',
    props: ['min', 'max', 'errors', 'icon_direction', 'label_cls', 'value_cls', 'gravity', 'name', 'editing'],
    components: { grigDateRangePicker},
    data(){
        return {
        }
    },mounted(){
        console.log(this.calendar);
    },
    computed: {
        calendar(){ return this.$store.getters.user.calendar; },
        error(){ return errorHandlerUtil.parse( this.errors, this.name)}
    }
}
</script>

<style>

</style>