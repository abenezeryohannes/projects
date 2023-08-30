<template>
    <section name="modal"  v-if="show" class="text-gray-900 dark:text-white
                            bg-opacity-20 bg-gray-500 w-full h-full fixed block top-0 left-0 z-30
                            transition-opacity ease-in-out duration-200 ">
        <div class="  h-full py-0 pl-10 w-full bg-transparent flex justify-end modal-mask">
            <!-- <div @click="clickedOutside" class="modal-mask  bg-background-dark  w-full top-0 left-0 fixed z-30 h-full dark:bg-background-light opacity-20  ">
            </div> -->
                <!-- <div class="modal-container px-5 pt-5 pb-3 absolute md:left-1/3 transform md:-translate-x-1/4  z-50 rounded-lg shadow-lg 
                        bg-background-light dark:bg-background-dark scrollable max-h-full"
                        :class="[('bottom-'+0), 'right-'+0, 'top-'+0]"
                        > -->
                <div @click="clickedOutside" class="" :class="['w-'+(width!=null?(12-width):6)+'/12']">

                </div>
                <div :class="['w-'+(width!=null?width:6)+'/12']"  class="modal-container
                      rounded-lg h-full relative shadow-lg bg-white ">

                    <div class="scrollable w-full h-full dark:bg-sidebar-dark px-5 pt-5 pb-3">
                       <div  class="flex h-full w-full text-left ">

                           <div class=" pl-2 h-full w-full ">
                               <div class=" h-full w-full">

                                   <div class="w-full font-semibold text-lg">
                                        <slot name="header"> </slot>
                                   </div>

                                    <div  class="w-full font-normal h-full text-md ">
                                        <slot> </slot>
                                    </div>


                               </div>

                               <div class="pr-8">
                                  <slot name="footer" > </slot>
                               </div>

                           </div>

                       </div>

                    <div class="absolute bottom-10 left-10 ">
                      <slot name="leftfab" > </slot>
                    </div>
                    <div class="absolute bottom-10 right-10 ">
                      <slot name="rightfab" > </slot>
                    </div>
                  </div>
                </div>
        </div>
    </section>
</template>

<script>
export default {
  components: {  },
   props:  ['top', 'bottom', 'cancelable', 'width'],
    data() {
        return {
            id:'none',
            show: false
        };
    },
  methods: {
    close() {
      this.show = false;
    },
    clickedInside(){},
    open(id) {
         this.id = id;
         this.show = true;
    },
    clickedOutside(){
        if(this.cancelable == null || this.cancelable) {
         this.close();
        }
    },

  }
};
</script>


<style>

</style>