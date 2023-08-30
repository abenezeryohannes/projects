<template>
  <section>
      <div class="relative w-full  text-xs hover:bg-accentlight-light dark:bg-accentlight-dark rounded-lg bg-background-light dark:hover:bg-background-darkish shadow-lg  ">
            <!-- <web-image rounded="rounded" :link="data.image" :height=300 :width=300 :padding=0 /> -->

            <div v-if="hasCol('#actions#')" class="absolute top-2 right-0 z-10">
                <checkbox-form :value="checked" @on-change="checked = $event; $emit('on-select', {check: checked})"
                    :editing="true"/>
            </div>
        <div class="py-2 px-3 font-semibold relative pr-3 pb-1 text-left capitalize" :class="[{'cursor-pointer': clickable}]" @click="onClick">

              <p class=" mb-1 mt-2 truncate text-sm"> {{data.reference}} </p>

                <div class="flex mb-3 text-ty font-normal truncate">
                  <!-- <p class="mr-2"> {{$t('manager')}}: </p> -->
                  <p class=""> {{$date.dd(data.date)}} </p>
                </div>
<!--                <div class="flex mb-2 truncate">-->
<!--                    &lt;!&ndash; <p class="mr-2"> {{$t('manager')}}: </p> &ndash;&gt;-->
<!--                    <p class=""> {{data.warehouse}} </p>-->
<!--                </div>-->


                 <div class="flex justify-between mb-2">
                   <p class=""> {{data.warehouse}} </p>

                   <p class=""> {{$date.number((data.no_of_items!=null)?data.no_of_items:0) + ' ' +$t('items')}}  </p>
                </div>


<!--                <div class="flex">-->
<!--                    <div class="text-ty capitalize text-white" :class="[-->
<!--                            // {'bg-warning-light dark:bg-warning-dark rounded-2xl shadow-xl px-2 py-1 ':data.status.includes('issue')},-->
<!--                            // {'bg-warning-light rounded-2xl shadow-xl px-2 py-1 ': data.status.includes('waiting')},-->
<!--                            // {'bg-error-light rounded-2xl shadow-xl px-2 py-1 ': data.status.includes('defaulted')},-->
<!--                            // {'bg-gray-700 rounded-2xl shadow-xl px-2 py-1 ': data.status.includes('canceled')},-->
<!--                            // {'bg-gray-700 rounded-2xl shadow-xl px-2 py-1 ': data.status.includes('ended')},-->
<!--                            // {'bg-success-light rounded-2xl shadow-xl px-3 py-1 ': data.status.includes('active')}-->
<!--                                    ]">-->
<!--                            <p class=""> {{// data.quantity_on_hand}} </p>-->
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
          let x = null;
          if(this.error!=null&&this.error.body!=null){
              x= this.error.body[header.name];
          }else if(this.editing){
              x= this.temp_data[header.name];
          }else x=  data[header.name]

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

        }else if(action==='save'){
          
          this.editing = false
          this.$emit('on-action', { body:this.temp_data, action:'edit',  orginal: data });
        
        }else if(action==='cancel'){

            this.editing = false;
            this.$emit('on-action', { body:this.temp_data, action:'cancel',  orginal: data });

        }else if(action==='delete'){

            this.$emit('on-action', { body:this.temp_data, action:'delete',  orginal: data });
            
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