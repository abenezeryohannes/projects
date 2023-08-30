<template>
  <section>
      <div class="w-full relative rounded hover:bg-accentlight-light dark:bg-accentlight-dark bg-background-light 
                dark:hover:bg-background-darkish shadow-lg flex"
                 :class="[{'cursor-pointer': clickable}]" @click="onClick" >
        <div class=" bg-background-lightish">
            <web-image rounded="rounded" :link="data.image" :height=28 :width=24 :padding=0 />

            <div v-if="hasCol('#actions#')" class="absolute top-2 right-0 z-10">
                <checkbox-form :value="checked" @on-change="checked = $event; $emit('on-select', {check: checked})"
                    :editing="true"/>
            </div>
        </div>
        <div class="pl-3 font-semibold relative pr-3 pb-1 text-left capitalize">

              <p class="  mb-1 mt-2 truncate text-sm"> {{data.full_name}} </p>
 
                <div class="flex mb-1 lowercase truncate">
                    <p class=""> {{data.email_address}} </p>
                </div>

                <div class="flex mb-1  truncate">
                    <p class=""> {{data.phone_number}} </p>
                </div>
 
                <div class="flex text-ty mb-2">
                    <p class=""> {{data.business_type}} </p>
                </div> 
        </div>
      </div>
  </section>
</template>

<script>

import webImage from '../../../common/web-image.vue'
import errorHandlerUtil from '../../../../modules/util/error.handler.util';
import CheckboxForm from '../../../forms/checkbox.form';

export default {
  components: {   CheckboxForm, webImage },
    props: ['index', 'data','clickable', 'headers', 'checkAll','unCheckAll', 'error'],
    data(){
      return {
        temp_data: {},
        editing: false,
        checked: false
      }
    },
    computed:{
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