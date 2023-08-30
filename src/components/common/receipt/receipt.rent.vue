<template>
        
    <section class="mt-16">
            <!-- <p class="text-left mb-8 font-semibold text-lg"> {{$t('property')}} </p> -->

            <div class=" py-3 ">
                    <div class="bg-accentlight-light py-3 px-2 capitalize dark:bg-accentlight-dark text-left grid lg:grid-cols-16 lg:gap-x-5">
                        
                        <div class=" col-span-4">
                            <p> {{$t('property')}} </p>
                        </div>
                        
                        <div class=" col-span-3">
                            <p> {{$t('from')}} </p>
                        </div>
                        
                        <div class=" col-span-3">
                            <p> {{$t('period_of')}} </p>
                        </div>

                        <div class=" col-span-3">
                            <p> {{$t('rent_price')}} </p>
                        </div>
  
                        <div v-if="temp_rent.tax_id != null" class=" col-span-3">
                            <p> {{$t('tax')}} </p>
                        </div>

                    </div>

                    <div class="text-left py-5 grid lg:grid-cols-16 lg:gap-x-5">

                        <div  class=" col-span-4 "> 
                              
                            <dropdown-form
                                name="property_id" @on-change="temp_rent.property_id=$event.id; $set(temp_rent, 'Property', $event)" :editing="editing"
                                :link="'rent/properties?limit=5'"  
                                :can_add="editing" @on-add="onPropertyAdd" :placeholder="$t('select_one')"
                                :value="temp_rent.Property.name" :errors="errors" />  

                        </div>
                        <div  class=" col-span-3"> 
                           
                            <p class=""> {{$date.dd((temp_rent.start_date))}} </p>
                                    
                        </div>
                         <div  class=" col-span-3"> 
                            
                                  
                            <number-form
                                :placeholder=3
                                name="period_to_pay"
                                @on-change="$set(temp_rent, 'period_to_pay', $event)" 
                                :value="temp_rent.period_to_pay + ' ' + temp_rent.Recurring.unit"
                                type="number"
                                min="1"
                                :errors="errors"
                                :editing="editing"
                            />
                                    
                        </div>
                        <div  class=" col-span-3"> 
                                 
                            <number-form
                                :placeholder=0
                                name="rent_price"
                                :value="temp_rent.rent_price"
                                @on-change="$set(temp_rent, 'rent_price', $event)" 
                                type="cash" min="0.01"
                                :errors="errors"
                                :editing="editing"
                            />
                                    
                        </div>
                          <div  class=" col-span-3 "> 
                            
                            <dropdown-form
                                name="tax_id" @on-change="temp_rent.tax_id = $event.id;$set(temp_rent, 'Tax', $event)" :editing="editing"
                                :link="'banking/taxes?limit=5'"  
                                :can_add="true" @on-add="onTaxAdd" :placeholder="$t('select_one')"
                                :value="temp_rent.Tax.name" :errors="errors" />  

                        </div>
                          <!-- <div  class=" col-span-2"> 
                            <p class="pt-2"> {{$date.fM((temp_rent.rent_price))}} </p>        
                        </div> -->
                    </div> 

            </div>


            <div class="lg:grid lg:grid-rows-3 lg:gap-y-6 text-sm text-left  mt-16">
                <!-- tax -->
                <div v-if="temp_rent.tax_id != null" class="grid lg:grid-cols-16 lg:gap-x-5">
                    <div class="col-span-11"/>

                    <div  class=" col-span-3"> 
                        <p> {{$t('tax')}} </p>        
                    </div>
                    <div  class=" col-span-2 "> 
                        <p class=""> {{$date.fM( (temp_rent.rent_price * temp_rent.Tax.rate)/100 )}} </p>        
                    </div>
                </div>

                <!-- subtotal -->
                <div v-if="temp_rent.tax_id != null" class="grid lg:grid-cols-16 lg:gap-x-5">
                    <div class="col-span-11"/>

                    <div  class=" col-span-3 "> 
                        <p> {{$t('sub_total')}} </p>      
                    </div>
                    <div  class=" col-span-2 ">  
                        <p class=""> {{$date.fM(temp_rent.rent_price - (temp_rent.rent_price * temp_rent.Tax.rate)/100 )}} </p>         
                    </div>
                </div>

                <!-- total -->
                <div class="grid lg:grid-cols-16 lg:gap-x-5">
                    <div class="col-span-11"/>

                    <div  class=" col-span-3 "> 
                        <p> {{ $t('total') }} </p>         
                    </div>
                    <div  class=" col-span-2 ">  
                        <p class=""> {{$date.fM(temp_rent.rent_price)}} </p>        
                    </div>
                </div>
            </div>


        </section>
</template>


<script>

import DropdownForm from '../../forms/dropdown.form.vue'
import NumberForm from '../../forms/number.form.vue'

export default { 
    components: {   NumberForm, DropdownForm,  },
    props: [ 'temp_rent' ],
    data(){
        return{
            new_attachments:[],
            attachments:[],
            deleted_attachments:[],
            loading: false,
            errors: null,
        }
    },
    
    mounted(){ 

    },
    methods: { 
        onTenantAdd(){

        },
        onTaxAdd(){

        },
        onPropertyAdd(){

        },
        onRecurringAdd(){

        },
        clear(){

        },

    }

}
</script>