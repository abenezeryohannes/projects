<template>
  <section>
      
      <div v-if="data.percentage < 50" class="mb-2 text-left flex capitalize">
          <p> {{$t('process_payroll')}}  </p>
          <!-- <p class=" font-normal lowercase ml-1"> {{$t('fromto', {from: $date.dd(data.start_of_period), to: $date.dd(data.end_of_period)} )}}  </p> -->
          <p class="font-bold capitalize ml-1"> {{computeDiff(data.start_of_period, data.end_of_period) }}  </p>

          <p v-if="data.EmployeeWorkSchedule!=null" class="ml-1"> ({{data.EmployeeWorkSchedule.name}}) </p>
          <p v-else class=""> ( {{$t('contract_payment')}} ) </p>

      </div>
      
      <div v-else class="mb-2 text-left flex capitalize">
             <p class=" font-bold capitalize ml-1"> {{computeDiff(data.start_of_period, data.end_of_period) }}  </p>
             
          <p v-if="data.EmployeeWorkSchedule!=null" class="ml-1"> ({{data.EmployeeWorkSchedule.name}}) </p>
          <p v-else class=""> ( {{$t('contract_payment')}} ) </p>
   </div>

      <div class="relative w-full pt-3 hover:bg-accentlight-light dark:bg-accentlight-dark rounded-lg bg-background-light dark:hover:bg-background-darkish shadow-lg text-xs pl-3">
            
            <div v-if="hasCol('#actions#')" class="absolute top-2 right-1 z-10">
                <checkbox-form :value="checked" @on-change="checked = $event; $emit('on-select', {check: checked})"
                    :editing="true"/>
            </div> 

            <div class="absolute top-0 left-0 h-full mb-2 border-l-2 "

                :class="[
                    {'border-warning-light dark:border-warning-dark': data.percentage<30},
                    {'border-warning-light dark:border-warning-dark': data.percentage<50}, 
                    {'border-success-light dark:border-success-dark': data.percentage>50}, 
                ]"
            />
               
            
        <div class="col-span-8 relative pr-3 pb-1 capitalize" :class="[{'cursor-pointer': clickable}]" @click="onClick">

            <div class="flex gap-y-4 text-left capitalize pt-2 w-full justify-between pr-5 pb-3 ">
                <div class="flex flex-col gap-y-4">
                    <p class=""> {{$t('employees_total_payment')}} </p>
                    <p class=""> {{$date.fM(data.net_payment)}} </p>
                </div>
                    <div class="flex flex-col gap-y-4">
                    <p class=""> {{$t('payment_date')}} </p>
                    <p class=""> {{$date.dd(data.payment_date)}} </p>
                </div>
                    <div class="flex flex-col gap-y-4">
                    <p class=""> {{$t('employees')}} </p>
                    <p class=""> {{data.no_of_employees}} ({{data.no_of_skipped_employees}} {{$t('skipped')}}) </p>
                </div> 

            </div>

            <div class=" text-left mt-3 ">
                <p v-if="data.payed_on!=null" class="mb-3 "> {{$t('payed_on')}}: {{$date.dd(data.payed_on)}} </p>
                <p v-else class="mb-3 "
                :class="[
                    {'text-warning-light dark:text-warning-dark': data.percentage<30},
                    {'text-warning-light dark:text-warning-dark': data.percentage<50}, 
                    {'text-success-light dark:text-success-dark': data.percentage>50}, 
                ]">{{$t('waiting payment')}}</p>
                <progressbar-form class="w-full hidden" :value="data.percentage*1" :height="2" bgcolor='bg-primary-whitish  ' accentcolor="bg-primary-light dark:bg-primary-dark"/>
            </div>
 
        </div>
      </div>
  </section>
</template>

<script>
import ProgressbarForm from '../../../forms/progressbar.form'
import errorHandlerUtil from '../../../../modules/util/error.handler.util';
import CheckboxForm from '../../../forms/checkbox.form'; 
export default {
  components: {  ProgressbarForm,   CheckboxForm },
    props: ['index', 'data', 'clickable', 'headers', 'checkAll','unCheckAll', 'error'],
    data(){
      return {
        temp_data: {},
        employee_count: 0,
        percentage: 0,
        editing: false,
        checked: false
      }
    },
    methods: {
        computeDiff(start, end){
            return this.$date.diff(this, start, end);
        },
        onClick(){
            if(this.clickable) this.$emit('on-item-click', {body:this.data, index: this.index});
        },
        hasCol(string){
            for(var i = 0; i< this.headers.length; i++){
                if(this.headers[i].name == string) return true;
            }
            return false;
        },
        getActions(){
             for(var i = 0; i< this.headers.length; i++){
                if(this.headers[i].name == '#actions#') return this.headers[i].actions;
            }
            return ['edit'];
        },
      parseError(key){ return this.error!=null ?  errorHandlerUtil.parse(this.error.errors, key) : null;},

      value(data, header ){ 
          var x = null;
          if(this.error!=null&&this.error.body!=null){
              x= this.error.body[header.name];
          }else if(this.editing){
              x= this.temp_data[header.name];
          }else x=  data[header.name]
        //   var x = (!this.editing) ? data[header.name] : this.temp_data[header.name];
      
    //   console.log(header.name,  data[header.name] );
       return x;
      },
      
      update(key, value){ console.log(key, value); this.temp_data[key] = value; console.log(this.temp_data)},

      refresh(){ this.editing = false; this.temp_data = {};},
      
      onActionClick( data, action){

        if(action == 'edit'){

            this.editing = true;
            if(this.error!=null && this.error.body!=null){this.temp_data  = JSON.parse(JSON.stringify(this.error)); }
            else this.temp_data  = JSON.parse(JSON.stringify(data));
            // for (const [key, value] of Object.entries(x)) { this.$set(this.temp_data, key, value); }

        }else if(action == 'save'){
          
          this.editing = false
          this.$emit('on-action', {body:this.temp_data, action:'edit',  orginal: data});
        
        }else if(action == 'cancel'){
            this.editing = false;
            this.$emit('on-action', {body:this.temp_data, action:'cancel',  orginal: data});
        }else if(action == 'delete'){

            this.$emit('on-action', {body:this.temp_data, action:'delete',  orginal: data});
            
        }
      }

    },
    watch: {
        error(e){if(e!=null && e.body!=null)
            this.temp_data = JSON.parse(JSON.stringify(e.body));
        
            console.log('from row', e)
        },
      
        editing(e){console.log(e)
            //   if(e) this.temp_data = JSON.parse(JSON.stringify(this.data));
        },
      
        unCheckAll(newVal){
            console.log('uncheckall', newVal);
            if(newVal==true)
                this.checked = false;
        },
        checkAll(newVal){
            this.checked = newVal;
        },

      temp_data(newVal){console.log(newVal)}
    },
}
</script>

<style>

</style>