<template>
  <section>
      <div class="relative flex justify-content w-full  text-xs hover:bg-accentlight-light dark:bg-accentlight-dark rounded-lg bg-background-light dark:hover:bg-background-darkish shadow-lg  ">
            <!-- <web-image rounded="rounded" :link="data.image" :height=300 :width=300 :padding=0 /> -->

            <div v-if="hasCol('#actions#')" class="absolute top-2 right-0 z-10">
                <checkbox-form :value="checked" @on-change="checked = $event; $emit('on-select', {check: checked})"
                    :editing="true"/>
            </div>


        <diagonal-badge v-if="data.main" class="absolute bottom-0 right-0 h-full" :size="20" cls="bg-success-light opacity-50 h-4"
                        text='main' direction="left" />

        <div class="flex w-5/12 bg-gray-100 dark:bg-background-deepdark rounded-lg" :class="[{'cursor-pointer': clickable}]" @click="onClick">

          <div class="bg-transparent w-full h-full" v-show="data.image!=null">
            <web-image class="w-full h-full" rounded="rounded" :link="data.image" :padding=0 />
          </div>

          <p class="text-center capitalize mx-auto my-auto truncate text-sm "> {{data.name}} </p>

        </div>
        <div class="py-2 px-3 w-full font-semibold relative pr-3 pb-1 text-left capitalize" :class="[{'cursor-pointer': clickable}]" @click="onClick">


                <div class="flex mb-2 text-xs truncate">
                    <!-- <p class="mr-2"> {{$t('manager')}}: </p> -->
                    <p class=""> {{data.city}} </p>
                </div>
                <div class="flex mb-2 text-xs truncate">
                    <!-- <p class="mr-2"> {{$t('manager')}}: </p> -->
                    <p class=""> {{data.address}} </p>
                </div>

              <div class="flex mb-2 text-xs truncate">
                <!-- <p class="mr-2"> {{$t('manager')}}: </p> -->
                <p class=""> {{data.no_of_items}} {{$t('items')}} </p>
              </div>

              <div class="  mt-3">
                <p class="mb-2"> {{$t('value')}}: {{$date.fM(data.value)}} </p>
                <progressbar-form class="w-full" :value="data.percentage" :height="2"
                                  bgcolor='bg-primary-whitish  ' accentcolor="bg-primary-light dark:bg-primary-dark"/>
              </div>
        </div>
      </div>
  </section>
</template>

<script>
// import TextForm from '../../../forms/text.form';
// import vIcon from '../../../icons/v-icon'
// import dropdownForm from '../../../forms/dropdown.form'
// import webImage from '../../../common/web-image'
// import toggleForm from '../../../forms/toggle.form'
import errorHandlerUtil from '../../../../modules/util/error.handler.util';
import CheckboxForm from '../../../forms/checkbox.form';
import ProgressbarForm from "@/components/forms/progressbar.form";
import WebImage from "@/components/common/web-image";
import DiagonalBadge from "@/components/common/diagonal.badge";
export default {
  components: {DiagonalBadge, WebImage, ProgressbarForm,   CheckboxForm },
    props: ['index', 'data','clickable', 'headers', 'checkAll','unCheckAll', 'error'],
    data(){
      return {
        temp_data: {},
        editing: false,
        checked: false
      }
    },
    computed:{
      percentage(){
        return  ((this.data.cost*100)/((this.data.total_cost>0)?this.data.total_cost:1))
      }
    },
    methods: {

        onClick(){
            if(this.clickable) this.$emit('on-item-click', {body:this.this.data, index: this.index});
        },
        hasCol(string){
            for(var i = 0; i< this.headers.length; i++){
                if(this.headers[i].name === string) return true;
            }
            return false;
        },
        getActions(){
             for(var i = 0; i< this.headers.length; i++){
                if(this.headers[i].name === '#actions#') return this.headers[i].actions;
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