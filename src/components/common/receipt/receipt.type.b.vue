<template>
        
    <section class="">


<!-- top wating paid or defaulted or canceled or ended -->
          <div  :style="{ 'background-color': status.color }"
               :class="[' bg-gradient-to-r dark:from-background-deepdark capitalize from-background-light ', status.cls]" class=" rounded flex justify-end h-10"> 
            <p class="text-lg my-auto text-white mx-5"> {{$t(status.text)}} </p>
          </div>

            
          <!-- top -->
          <div class="grid grid-cols-2 gap-x-10 px-5"> 
            <!-- tenant -->
            <div class=""> 
                
              <!-- company icon -->
                <img v-if="company.logo != null" v-lazy="media_link + '?path=' + company.logo"  :class='["w-24 h-24 mt-10 object-center object-cover"]'/>
                <div v-else class=" animate-pulse bg-accentlight-light dark:bg-accentlight-darkw-24 h-24 w-24 rounded-full mt-10" />
              <!-- tenant desc -->
              <div class="text-left mt-5"> 

                <div class="mb-8">
                  <p class="mb-2"> {{ $t('bill_from') }}:</p>
                  <p class="text-xs"> {{companyuser.full_name}} </p>
                </div>
               
              
                <div class="flex items-center mb-2">
                  <p class=""> {{ $t('tin_number') }}:</p>
                  <p class="text-xs ml-2"> {{companyuser.tin_number}} </p>
                </div>
              
                <div class="flex items-center mb-2">
                  <!-- <p class=""> {{ $t('phone_number') }}:</p> -->
                  <p class="text-xs "> {{companyuser.phone_number}} </p>
                </div>
              
               <div class="flex items-center mb-2">
                  <!-- <p class=""> {{ $t('email_address') }}:</p> -->
                  <p class="text-xs "> {{companyuser.email_address}} </p>
                </div>
              
              </div>

            </div>
              
            <!-- company -->
            <div class="flex justify-end mt-5">
              
              <!-- company desc -->
              <div class="text-right mt-5"> 

                <div class="mb-8">
                <p class="mb-2"> {{company.name}} </p>
                  <p class="text-xs"> {{company.address}} </p>
                </div>
              
              
                <div class="flex justify-end items-center mb-2">
                  <p class=""> {{ $t('tin_number') }}:</p>
                  <p class="text-xs ml-2"> {{company.tin_number}} </p>
                </div>
              
                <div class="flex justify-end items-center mb-2">
                  <!-- <p class=""> {{ $t('phone_number') }}:</p> -->
                  <p class="text-xs "> {{company.phone_number}} </p>
                </div>
              
               <div class="flex justify-end items-center mb-2">
                  <!-- <p class=""> {{ $t('email_address') }}:</p> -->
                  <p class="text-xs "> {{company.email_address}} </p>
                </div>
              
              </div>

            </div>
          </div>








        <!-- _________________________________________________________ -->
        <section class="mt-16">
                <!-- <p class="text-left mb-8 font-semibold text-lg"> {{$t('property')}} </p> -->

                <div class=" py-3 ">
                        <div class="bg-accentlight-light py-3 md:px-5 capitalize dark:bg-accentlight-dark text-left grid grid-cols-16 gap-x-5">
                            

                            <div v-for="(header, index) in headers" :key="index" :class="[ 'col-span-' + header.span ]">
                            <!-- <div  > -->
                                    <p> {{$t(header.title)}} </p>
                                <!-- </div> -->
                            </div>

                        </div>

                        <div class="text-left py-5 grid grid-cols-16 md:px-5 gap-x-5">
                            
                            <div v-for="(header, index) in headers" :key="index" :class="[ 'col-span-' + header.span ]">
                            <!-- <div  > -->
                                    <p> {{$t(header.body)}} </p>
                                <!-- </div> -->
                            </div>
                        
                        </div> 

                </div>


                <div class="grid grid-rows-3 gap-y-6 md:px-5 text-left  mt-14 pb-14 capitalize">


                    <div v-for="(side, index) in sides" :key="index" class="grid grid-cols-16 gap-x-5">
                        <div class="col-span-10"/>

                        <div  class=" col-span-3"> 
                            <p> {{$t(side.title)}} </p>        
                        </div>

                        <div  class=" col-span-3 "> 
                            <p class=""> {{side.body}} </p>        
                        </div>

                    </div>

                </div>


        </section>
    </section>
</template>


<script>


export default { 
    components: {     },
    props: [ 'temp_rent', 'headers', 'sides', 'company', 'companyuser', 'status'],
    data(){
        return{
            media_link: process.env.VUE_APP_MIDEA_LINK,
            
        }
    },
    watch:{
        // headers(val){ console.log('header: ', val); }
    },
    mounted(){ 

    },
    methods: { 

    }

}
</script>