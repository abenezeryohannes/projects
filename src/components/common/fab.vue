<template>
  <section>
      <div class="group mx-auto my-auto
                hover:bg-accent-light dark:hover:bg-accent-light dark:text-background-white dark:bg-background-darkish
                bg-white shadow-lg cursor-pointer rounded-full w-full h-full p-2 "
                @click="$emit('on-action')" :class="[cls]">
                <v-icon  :icon="icon" :size='size' fill="text-gray-600" cls=" my-auto mx-auto group-hover:text-white "/>
            </div>
  </section>
</template>

<script>
import VIcon from '../icons/v-icon.vue';
export default {
    components: {VIcon, },
    props: ['icon', 'loading', 'size', 'errors', 'editing', 'cls'],
    data(){
         return { }
    },
    methods: {
        save: function(){
            this.$emit('on-click');
        },
    }


}
</script>

<style>

</style>