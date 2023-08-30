<template>
  <section class="" >
      <div class="flex cursor-pointer mb-5 text-gray-400 dark:text-gray-200" @click="$emit('on-change')">
          <p class="my-auto"> {{ !show?$t('show_less'):$t('show_more') }} </p>
          <v-icon v-show="show" cls="  dark:text-gray-200" fill="gray-500" icon="arrow-down" :size=5 />
          <v-icon v-show="!show" cls=" dark:text-gray-200" fill="gray-500" icon="arrow-up" :size=5 />
      </div>
      <section :class="{'hidden':show}">
        <slot > </slot>
      </section>
  </section>
</template>

<script>
import VIcon from '../icons/v-icon.vue'
export default {
    
    components: {VIcon},

    props:[ 'show' ]
}
</script>

<style>

</style>