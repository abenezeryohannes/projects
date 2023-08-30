<template>
  <section>
      <div class=" " :class="{'': error==null}">
          <label v-if="label!=null&&memos!=null&&memos.length>0||label!=null&&editing" class="capitalize my-auto"> {{$t(label.toLowerCase())}} </label>

          <memo-form :class="[{'pl-16':label!=null}]" class=" mt-5" :memos="memos" :item_padding='item_padding' :item_width='item_width' :item_height='item_height'
                @on-change="$emit('on-change', $event)"
                :editing="editing"/>
      </div>
  </section>
</template>

<script>
import memoForm from '../forms/memo.form.vue';

export default {
    components: {memoForm},
    data(){return {error:null}},
    props: ['memos','errors', 'item_padding', 'item_width', 'label', 'item_height', 'editing'],
    methods: {
      errorChanged(){
        this.error = null;
        if(this.errors!=null){
          this.errors.errors.forEach(function(e) {
            if(Object.prototype.hasOwnProperty.call(e, this.name)){
              if(this.error==null)
                this.error = e[this.name];
            } 
          });
        }
      }
    },
    watch: {
      errors: function(){
        this.errorChanged();
      }
    }


}
</script>

<style>

</style>