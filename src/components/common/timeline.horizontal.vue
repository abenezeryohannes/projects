<template>
  <section class="w-full text_theme relative">
    <div class="absolute top-4 w-full pr-10 pl-10" >
        <div  class=" border-t border-background-dark opacity-40 shadow-lg dark:border-background-light w-full border-dashed" />
    </div>
      <div class="z-5 absolute w-full ">

            
            <div class="flex justify-between">
                <div v-for="(point, index) in points" :key="index" >
                    
                    <!-- <div /> -->

                    <div class="">
                        <div    :style="{ 'background-color': point.color }" 
                                class="rounded-full mx-auto shadow-lg" 
                                :class="['h-'+point.icon_size, 'w-'+point.icon_size, point.cls]" 
                                />

                        <p class="font-bold mt-3"> {{$t(point.title)}} </p>
                        <p class="font-semibold mt-1"> {{$t(point.subtitle)}} </p>
                    </div>

                </div>
            </div>

      </div>
  </section>
</template>

<script>
export default {
    props: [ 'points' ],
    data(){
        return { first_padding: 10, last_padding: 10 };
    },
    watch:{
        points(val){
            // console.log(val);
            var first_txt = val[0].title + val[0].subtitle ;
            var last_txt = val[val.length - 1].title + val[val.length - 1].subtitle ;

            this.first_padding = first_txt.length / 2;
            this.last_padding = last_txt.length / 2;
        },
    }

}
</script>

<style>

</style>