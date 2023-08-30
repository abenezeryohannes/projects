<template>
  <section>
      <div class="relative w-full hover:bg-accentlight-light dark:bg-accentlight-dark rounded-lg bg-background-light dark:hover:bg-background-darkish shadow-lg text-xs pl-3">
        
            <div v-if="hasCol('#actions#')" class="absolute top-2 right-1 z-10">
                <checkbox-form :value="checked" @on-change="checked = $event; $emit('on-select', {check: checked})"
                    :editing="true"/>
            </div> 

        <div class="col-span-8 relative pr-3 pb-1" :class="[{'cursor-pointer': clickable}]" @click="onClick">

            <div class="flex flex-col gap-y-3 text-left capitalize pt-2 pr-5 ">

                <p class="text-base font-bold"> {{data.department}} </p>
 
                <div class="flex mb-5">
                    <p class="mr-2"> {{$t('manager')}}: </p>
                    <p class=""> {{data.manager}} </p>
                </div>

                <div class="inline">
                    <div class="px-3 py-2 shadow-lg bg-primary-light dark:bg-primary-dark rounded
                        cursor-pointer text-white inline font-medium " @click="$router.push({name:'employees', query:{department: data.department}})">
                         {{$t('employee')}} </div>
                </div>


                <div class="  mt-3">
                    <p class="mb-3"> {{$t('employees')}}: {{employee_count}} </p>
                    <progressbar-form class="w-full" :value="percentage" :height="2" bgcolor='bg-primary-whitish  ' accentcolor="bg-primary-light dark:bg-primary-dark"/>
                </div>
                
            </div>
 
        </div>
      </div>
  </section>
</template>

<script>
import ProgressbarForm from '../../../forms/progressbar.form'
import errorHandlerUtil from '../../../../modules/util/error.handler.util';
import CheckboxForm from '../../../forms/checkbox.form';
import { get } from '../../../../modules/util/request.handler';
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
    async mounted(){

        try{
            var response = await get('employee/departments/employee_count/'+this.data.id);
            this.employee_count = response.data.data.department;
            this.percentage = this.employee_count * (100/ response.data.data.total);
             

        }catch(e){ console.log(e.toString());}

    },
    methods: {

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