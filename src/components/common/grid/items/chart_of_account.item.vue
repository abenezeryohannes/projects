<template>
  <section>
      <div class="relative w-full  text-xs hover:bg-accentlight-light dark:bg-accentlight-dark rounded-lg bg-background-light dark:hover:bg-background-darkish shadow-lg  ">
            <!-- <web-image rounded="rounded" :link="data.image" :height=300 :width=300 :padding=0 /> -->

            <div v-if="hasCol('#actions#')" class="absolute top-2 right-0 z-10">
                <checkbox-form :value="checked" @on-change="checked = $event; $emit('on-select', {check: checked})"
                    :editing="true"/>
            </div>
        <div class="py-2 px-3 font-semibold relative pr-3 pb-1 text-left capitalize" :class="[{'cursor-pointer': clickable}]" @click="onClick">


                <div class="flex mt-2 mb-2 gap-x-2 mb-1 truncate">
                  <p class="text-sm"> {{data.account_id}} </p>
                  <!-- <p class="mr-2"> {{$t('manager')}}: </p> -->
                    <p class="text-sm"> {{data.name}} </p>
                </div>

                <div class="flex mb-1 text-ty truncate">
                    <!-- <p class="mr-2"> {{$t('manager')}}: </p> -->
<!--                    <p class=""> {{data.account_type}} </p>-->
                    <p class=""> {{data.note}} </p>
                </div>

                <div class="flex mb-2 ">
                    <div class="flex gap-x-2" v-if="data.normal_balance === 'debit'">
                      <p class="">{{ $t('debit') }}</p>
                      <p class=""> {{ $date.fM(data.debit_balance)}}</p>
                    </div>
                  <div class="flex gap-x-2" v-else-if="data.normal_balance === 'credit'">
                      <p class="">{{ $t('credit') }}:</p>
                      <p class="">{{$date.fM(data.credit_balance)}}</p>
                    </div>
                </div>


<!--                <div class="flex">-->
<!--                    <div class="text-ty capitalize text-white" :class="[-->
<!--                            {'bg-warning-light dark:bg-warning-dark rounded-2xl shadow-xl px-2 py-1 ':data.status.includes('issue')},-->
<!--                            {'bg-warning-light rounded-2xl shadow-xl px-2 py-1 ': data.status.includes('waiting')}, -->
<!--                            {'bg-error-light rounded-2xl shadow-xl px-2 py-1 ': data.status.includes('defaulted')},-->
<!--                            {'bg-gray-700 rounded-2xl shadow-xl px-2 py-1 ': data.status.includes('canceled')},-->
<!--                            {'bg-gray-700 rounded-2xl shadow-xl px-2 py-1 ': data.status.includes('ended')},-->
<!--                            {'bg-success-light rounded-2xl shadow-xl px-3 py-1 ': data.status.includes('active')}-->
<!--                                    ]">-->
<!--                            <p class=""> {{data.enabled}} </p>-->
<!--                    </div>-->
<!--                </div>-->

 
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
export default {
  components: {   CheckboxForm },
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

        if(action === 'edit'){

            this.editing = true;
            if(this.error!=null && this.error.body!=null){this.temp_data  = JSON.parse(JSON.stringify(this.error)); }
            else this.temp_data  = JSON.parse(JSON.stringify(data));
            // for (const [key, value] of Object.entries(x)) { this.$set(this.temp_data, key, value); }

        }else if(action === 'save'){
          
          this.editing = false
          this.$emit('on-action', {body:this.temp_data, action:'edit',  orginal: data});
        
        }else if(action === 'cancel'){
            this.editing = false;
            this.$emit('on-action', {body:this.temp_data, action:'cancel',  orginal: data});
        }else if(action === 'delete'){

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