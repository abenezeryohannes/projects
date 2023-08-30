<template>
  <section class="overflow-hidden flex bg-transparent absolute top-0 right-0" :class="[{'w-40 h-40': size==null},  'w-'+size, 'h-'+size]">

    <div class="absolute text-center flex -left-24 bg-blue-500 transform   w-96"
         :class="[cls,{'h-8':cls==null}, {'bottom-20':size==null}, 'bottom-'+size/2, {'rotate-45': direction==null}, {'-rotate-45': direction==='left'}]">
      <p class="w-full h-full mt-1"> {{$t(text)}} </p>
    </div>

  </section>
</template>

<script>
export default {
  name: "diagonal-badge",
  props: ['size', 'text', 'cls', 'direction'],
}
</script>

<style scoped>

</style>