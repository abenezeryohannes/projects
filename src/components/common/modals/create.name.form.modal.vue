<template>
  <modal class=" "  ref="Modal" :cancelable="true" :top="24" :width="4">

    <template v-slot:header>
      <div class="flex w-full justify-between">
          <p class="text-xl font-bold text-left capitalize "> {{$t(title)}} </p>
      </div>
    </template>
 
   
    <section class=" h-full w-80 text-left py-5  flex flex-col gap-y-10  ">

      <form-control
          v-bind="{type:'text', value: temp[name], label:label, placeholder:'', name: name,
          editing:editing, errors:errors, direction:`vertical`, obj:temp }"
          @on-change="$set(temp, name, $event)" />




    </section>

    <template v-slot:footer>
        <section class="flex justify-end gap-x-5">
            <p @click="close" class="rounded-lg hover:bg-background-lightish dark:hover:bg-background-darkish cursor-pointer py-2 px-3 text-sm text-error-light dark:text-error-dark "> {{$t('cancel')}}</p>
            <p @click="save" class="rounded-lg hover:bg-background-lightish dark:hover:bg-background-darkish cursor-pointer py-2 px-3 text-sm text-success-light dark:text-success-dark "> {{$t('save')}}</p>
        </section>
    </template>

<!--    <template v-slot:leftfab> </template>-->
<!--    <template v-slot:right_fab>-->

<!--      <div class="" @click="save" >-->
<!--        <fab class="w-12 h-12" cls="border border-gray-200"-->
<!--             :errors="errors" :editing="editing" :loading="loading" icon="save" :size="8" />-->
<!--      </div>-->

<!--    </template>-->


  </modal>
</template>

<script>
import modal from '@/components/common/modal'
import {post} from "@/modules/util/request.handler";
import ErrorHandlerUtil from "@/modules/util/error.handler.util";
import FormControl from "@/components/formcontrollers/formcontrol";

export default {
    name: 'create-name-form-modal',
    components: { FormControl, modal },
    data(){
        return {
          temp: {},title:null,label:null,
          loading: false,name:'name',
          editing: true,
          errors: null,
          url: null,
          key: null,
        }
    },
    computed: {
        company: function(){ return this.$store.getters.company; }, 
    },
    methods: {

        close() { this.editing = true; this.temp = {}; this.$refs.Modal.close(); },

        async open({key, name, text, title, label, url}){
          if(name!=null)
            this.temp[name] = text;
          this.editing = true;this.url = url; this.key = key;
          this.title = title; this.label = label; this.name = name;
          this.$refs.Modal.open(); },

        async save(){
          try{
            this.loading = true;
            console.log('request', this.temp);
            let response = await post(this.url, this.temp)
            console.log('response', response);
            this.temp  = JSON.parse( JSON.stringify(response.data.data) );
            this.$emit('on-change', {key: this.key, value: this.temp});
            this.close();
          }catch (e){ this.errors = ErrorHandlerUtil.handle(e, this)
          }finally { this.loading = false; }
        }

    }
}
</script>

<style>

</style>