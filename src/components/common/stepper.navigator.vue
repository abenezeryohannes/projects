<template>
<section class=" flex w-full " :class="[{'justify-end': active_step===0}, {'justify-between': active_step > 0}]">

    <div class="" @click="$emit('on-change', active_step>0?active_step-1:0)">
        <fab class="w-12 h-12" v-show="active_step>0"
           :errors="errors" :editing="editing" :loading="loading" icon="arrow-left" :size="8" />
    </div>

    <div class="" @click="$emit('on-change', active_step+1)">
          <fab class="w-12 h-12 " :errors="errors"
             :editing="editing" :loading="loading" icon="arrow-right" :size="8" />
    </div>

</section>
</template>

<script>
import Fab from "@/components/common/fab";
export default {
  name: "stepper-navigator",
  components: {Fab},
  props: ['direction', 'errors', 'editing', 'loading',  'size',   'active_step',   'line_width',   ],
  data(){
    return {

    }
  },
}
</script>

<style scoped>

</style>