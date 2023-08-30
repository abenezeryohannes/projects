<template>
  <section>
      <div class="w-full rounded hover:bg-accentlight-light dark:bg-accentlight-dark bg-background-light dark:hover:bg-background-darkish shadow-lg grid grid-cols-12 gap-x-3">
        <div class="relative col-span-4 bg-background-lightish">
            <web-image rounded="rounded" :link="data.image" :height=300 :width=300 :padding=0 />

            <div v-if="hasCol('#actions#')" class="absolute top-1 left-1 z-10">
                <checkbox-form :value="checked" @on-change="checked = $event; $emit('on-select', {check: checked})"
                    :editing="true"/>
            </div>
        </div>
        <div class="col-span-8 relative pr-3 pb-1" :class="[{'cursor-pointer': clickable}]" @click="onClick">

            <div v-for="(header, header_index) in headers" :key="header_index" >
                    <div v-if="header.label != '#bulk#' && header.name != '#actions#'" class="flex text-gray-700 dark:text-white" > 
                            <!-- data area -->
                            <div class="text-left my-auto text-xs font-semibold truncate py-1">
                            
                                <p v-if="header.type == null" class="truncate ">  {{$t(data[header.name])}} </p>
                            
                                <text-form v-else-if="header.type == 'text'"
                                @on-change="temp_data[header.name]=$event"
                                :value="value( data, header, error)" 
                                :error="parseError(header.name)"  
                                :editing="editing||error!=null" 
                                :placeholder="value( data, header)"
                                />

                                <dropdown-form @on-change="temp_data[header.name]=$event.name" v-if="header.type == 'dropdown'" 
                                :value="value( data, header, error)"  
                                :editing="editing||error!=null"
                                placeholder="selectone" :options="header.options" :height=8 />  

                                <toggle-form v-if="header.type == 'toggle'" :editing="editing" :positive='header.option.positive' 
                                    :negative="header.option.negative" :width=4 :height=4 :toggle="value( data, header, error)" 
                                    @on-change="temp_data[header.name]=$event" /> 


                            </div>
                    </div>
            </div>

                <!-- actions area -->
                <div v-if="hasCol('#actions#')&&false"  class="absolute bottom-2 right-0 flex flex-row justify-end">
                    <div v-for="action in getActions()" :key="action">
                        <div v-show="!editing&&error==null" @click="onActionClick(data, action)" >
                        <v-icon  cls="cursor-pointer mr-2 my-auto dark:text-accent-light" :padding=0 fill="gray-600" :icon="action" :size=5 /> 
                        </div>
                    </div>

                    <div v-show="editing||error!=null" @click="onActionClick(data, 'save')">
                    <v-icon  cls="cursor-pointer mr-2 dark:success-dark" :padding=0 fill="success-light" icon="save" :size=5 /> 
                    </div>
                    
                    <div v-show="editing||error!=null" @click="onActionClick(data, 'cancel')">
                    <v-icon  cls="cursor-pointer mr-2 dark:error-dark" :padding=0 fill="error-light" icon="cancel" :size=5 /> 
                    </div>
                </div>
        </div>
      </div>
  </section>
</template>

<script>
import TextForm from '../../../forms/text.form';
import vIcon from '../../../icons/v-icon'
import dropdownForm from '../../../forms/dropdown.form'
import webImage from '../../../common/web-image'
import toggleForm from '../../../forms/toggle.form'
import errorHandlerUtil from '../../../../modules/util/error.handler.util';
import CheckboxForm from '../../../forms/checkbox.form';
export default {
  components: { vIcon, TextForm, dropdownForm, toggleForm, CheckboxForm, webImage },
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