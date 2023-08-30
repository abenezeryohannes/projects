<template>
  <section class="w-full ">

        <div class=" flex flex-wrap  " :class="[cls]">
            <p  v-for="tab in tabs" :key="tab.name" 
                class=" capitalize py-2  px-5 font-bold"
                :class="[{'tab_outline_selected bg-accent-light dark:bg-accent-dark ': value===tab.name}, {'tab_outline': value!==tab.name}]"
                @click="$emit('on-change', tab)"
                > {{tab.name}} </p>
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