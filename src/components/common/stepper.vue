<template>
<section class=" select-none">
  <div class="">
      <div class="  flex" >
          <div class="flex "  v-for="(step, index) of steps" :key="index">
            <span @click="$emit('on-change', index)" class="relative rounded-full border-4 border-gray-400 dark:border-gray-500 px-2 py-1 text-center align-middle"
                  :class="[{'cursor-pointer group hover:border-accent-light dark:hover:border-accent-dark'
                              :clickable},
                              {'border-accent-light dark:border-accent-dark': active_step === index},
                              {'bg-accent-light dark:bg-accent-dark border-accent-light dark:border-accent-dark text-white': active_step > index}]"
                 >{{ index + 1 }}
                <span class="absolute text-gray-700 dark:text-white -left-10 w-24 text-center -bottom-6" :class="['group-hover:text-accent-light dark:group-hover:text-accent-light',
                 ]"
                > {{$t(step.name)}} </span>
            </span>
            <div :class="['w-'+line_width,
                   {'bg-accent-light dark:bg-accent-dark border-accent-light dark:border-accent-dark text-white border-solid': active_step > index}]"
                            v-if="index < steps.length-1" class="my-auto border-b-2 border-gray-300 border-dashed"></div>
          </div>
      </div>

<!--      <div class="w-full hidden flex justify-between mt-2">-->
<!--          <div v-for="(step,index) of steps" :key="index">-->
<!--            <p :class="['ml-8 '+(parseInt(step.name.length/2))]">{{$t(step.name)}}</p>-->
<!--          </div>-->
<!--      </div>-->
  </div>

  <div v-for="(step, index) in steps" :key="index">
    <slot :name="step.id"></slot>
  </div>

</section>
</template>

<script>
export default {
  name: "stepper",
  props: ['direction', 'steps', 'active_step', 'icons_size', 'line_width', 'clickable'  ],
  data(){
    return {

    }
  },
  computed:{
    // line_width(){
    //   console.log('width: ', this.width);
    //   console.log('icons_size: ', this.icons_size);
    //   console.log('steps_length: ', this.steps.length);
    //   let line =  (Number(this.width) - (Number(this.steps.length)*Number(this.icons_size)) )/Number(this.steps.length-1);
    //   console.log('lines: ', parseInt(line));
    //   return parseInt(line);
    // },

  }
}
</script>

<style scoped>

</style>