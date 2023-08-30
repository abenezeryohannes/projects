<template>
  <div  class="flex flex-col font-semibold text-sm select-none" >
    <div class="flex items-center text-lg font-bold justify-between cursor-pointer " :class="'h-'+height" @click.prevent="toggleShow">
        {{ title }}
        <svg xmlns="http://www.w3.org/2000/svg" class="ml-3 transition duration-150 ease-in-out" :class="{'rotate-90' : showMenu}" width="24" height="24" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
        </svg>
    </div>

    <ul class="absolute z-30 bg-background-light dark:bg-background-deepdark py-1 shadow transition duration-150 ease-in-out"  :class="[{'hidden': !showMenu}, dropdown_top_margin]">
        <slot> </slot>
    </ul>
  </div>
</template>

<script>
export default {
    props:{
        title: {
            type: String,
            require: true
        },
        height: {
            type: Number,
            default: 8,
            require: false
        }
    },
    data() {
        return {
            showMenu: false
        };
    },
    methods: {
        toggleShow() {
            this.showMenu = !this.showMenu;
        },
        close (e) {
            if (!this.$el.contains(e.target)) 
                this.showMenu = false
        }
    },

    computed: {
        class() {
        return this.showMenu ? this.height : "h-0";
        },
        dropdown_top_margin(){
            return this.showMenu?  "mt-"+(this.height + 4) : 'mt-0';
        }
    },
    mounted () {
        document.addEventListener('click', this.close)
    },
    beforeDestroy () {
        document.removeEventListener('click',this.close)
    }
}
</script>

<style>
.dropdown-menu {
  transition: 300ms;
}
svg.rotate-90 {
  transform: rotate(90deg);
}
</style>