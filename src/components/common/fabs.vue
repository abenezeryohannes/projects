<template>
  <section class="fixed transform ease-in-out duration-1000 right-10  bottom-10 "
    :class="[{'flex flex-row gap-y-3' : direction == 'horizontal'}, { ' flex flex-col gap-y-3'  : direction != 'horizontal' }]"
  >
       
                <div v-for="(action, index) in actions" :key="index"  class="tooltip">
                  <fab class="w-12 h-12" :size=6 :icon='action.icon'
                    @on-action="$emit('on-action', action)" />
                  <span v-show="action.tooltip!=null" class="tooltiptext">{{$t(action.tooltip)}}</span>
                </div>
  </section>
</template>

<script>
import fab from '../common/fab.vue'
export default {
    components: {fab},
    props: [ 'actions', 'direction']
}
</script>

<style>

</style>