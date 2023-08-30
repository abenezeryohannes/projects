<template>
  <section class=" w-full">

    <section class=" " :class="[{ 'grid grid-cols-16 gap-y-10 text-sm' :headers_cls == null}, headers_cls]">
      <div :class="['col-span-'+header.width]" v-for="(header, index) in headers" :key="index">
        <p class="bg-gray-50 dark:bg-background-darkish px-1 capitalize py-3 font-bold " :class="[{'pr-5':index!==headers.length-1}, header.cls,
        { 'rounded-tl rounded-bl':index===0}, {'rounded-br rounded-tr':(index===headers.length-1)||(index === headers.length-2 && headers[index+1].name==='#' )}]"
            >{{header.label}}</p>
      </div>
    </section>

    <section class="pt-3 " >
      <div class="  px-1" v-for="(body, index) in bodies" :key="index" :class="[{ 'grid grid-cols-16 gap-x-5 gap-y-5 py-1' :bodies_cls == null}, bodies_cls]">
        <div class="my-auto" :class="['col-span-'+header.width, body.cls, header.row_cls, {'py-2':!editing}, {'pb-1':editing}]" v-for="(header, header_index) in headers" :key="header_index" >

          <form-control v-if="header.name !== '#'" class=" my-auto " :class="[body['cls_'+header.name]]"
              :type="header.type" :name="header.name" :value="body[header.name]" :label="null"
                        :editing="(body['form_'+header.name]==null || body['form_'+header.name].editing  )&&editing&&header.editable" :errors="errors"
              v-bind="body['form_'+header.name]==null?header.form:body['form_'+header.name]"
                        @on-change="$emit('on-change', { index:index, key: header.name, value: $event});" />

         </div>
      </div>
    </section>


  </section>
</template>



<script>

import FormControl from "@/components/formcontrollers/formcontrol";
export default {
  name: "report-table",
  components: {  FormControl},
  props: ['errors', 'headers', 'bodies', 'editing', 'loading', 'headers_cls', 'bodies_cls' ]
}
</script>


<style scoped> </style>