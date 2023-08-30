<template>
  <section>
      <div>

        <div class="flex w-full justify-start" :class="[cls]"> 
            <p  v-for="tab in tabs" :key="tab.name" 
                class=" capitalize py-1  px-2 font-bold"
                :class="[{'tab_item_selected ': value==tab.name}, {'tab_item': value!=tab.name}]"
                @click="$emit('on-change', tab)"
                > {{tab.name}} </p>
        </div>

        <div>
            <slot> </slot>
        </div>
      </div>
      
  </section>
</template>

<script>
export default {
    props: {
        tabs: {
            type: Array,
            default: () => {return []}
        },
        value: {
            type: String,
            default: null
        },
        cls: {
            type: String,
            default: 'justify-start'
        }
    }

}
</script>

<style>

</style>