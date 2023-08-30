<template>
  <section class="flex calendar"  v-click-outside="clickedOutside" >
      
    <div v-if="editing" class="relative">
        <div class=" flex capitalize" :class="[{'justify-start': gravity === 'left'}, {' justify-end': gravity === 'right' || gravity == null}, {'cursor-pointer':editing}]">
            <div @click="drop = !drop" class="my-auto flex ">
              <v-icon cls="mr-2 cursor-pointer dark:text-gray-200 " fill="gray-500" icon="date" :size=4 v-show="icon_direction==='left'" />

              <p :class="[{'text-gray-400': (min == null || max == null )}, label_cls]">
                {{ (min == null)? $t('select_start_date') : $date.dd(min, 's')  }}   -     {{  (max == null)? $t('select_end_date') : $date.dd(max, 's')}}
              </p>

            <v-icon cls="ml-2 cursor-pointer dark:text-gray-200 " fill="gray-500" icon="date" :size=4 v-show="icon_direction!=='left'" />
          </div>

        </div>
 


        <section class="">

            <div v-if="drop" :class="[{'right-0':gravity==='left'}, {'left-0':gravity==='right'},{'right-0':gravity==null}]"
                        class=" flex   justify-between gap-x-5 absolute z-10 border-2 border-gray-200 dark:border-gray-500
                                top-10 bg-background-light dark:bg-background-darkish
                                rounded-lg shadow-lg py-2 px-2">
            
                <div  class="w-32 hidden md:col-span-4 py-2 text-left md:flex md:flex-col gap-y-2 capitalize"> 

                    <div @click="this_week" class="rounded cursor-pointer px-2 w-full mx-2 py-1 hover:bg-accent-light dark:hover:bg-accent-dark hover:text-white">
                        <p> {{$t('this_week')}} </p>
                    </div>
                    
                    <div @click="this_month" class="rounded cursor-pointer px-2 w-full mx-2 py-1 hover:bg-accent-light dark:hover:bg-accent-dark hover:text-white">
                        <p> {{$t('this_month')}} </p>
                    </div>

                    <div @click="this_year" class="rounded cursor-pointer px-2 w-full mx-2 py-1 hover:bg-accent-light dark:hover:bg-accent-dark hover:text-white">
                        <p> {{$t('this_year')}} </p>
                    </div>

                    <div @click="last_week" class="rounded cursor-pointer px-2 w-full mx-2 py-1 hover:bg-accent-light dark:hover:bg-accent-dark hover:text-white">
                        <p> {{$t('last_week')}} </p>
                    </div>

                    <div @click="last_month" class="rounded cursor-pointer px-2 w-full mx-2 py-1 hover:bg-accent-light dark:hover:bg-accent-dark hover:text-white">
                        <p> {{$t('last_month')}} </p>
                    </div>

                    <div @click="last_year" class="rounded cursor-pointer px-2 w-full mx-2 py-1 hover:bg-accent-light dark:hover:bg-accent-dark hover:text-white">
                        <p> {{$t('last_year')}} </p>
                    </div>

                </div>


                <div class="w-60  md:col-span-6">

                    <div class="grid grid-cols-12 mb-2 items-center">
                        
                        <div @click="goToPrevMonth_min"  class="flex justify-center col-span-2 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light">
                            <v-icon  icon="arrow-left" fill="gray-700" :size=5 cls="dark:text-white" class="" />
                        </div>

                       <div class=" col-span-8 flex justify-start gap-x-3"> 
                             <dropdown-form class="w-20  capitalize"
                                name="months" @on-change="changeMonthMin" :editing="true"
                                :options="months_drop"
                                :value="months_drop[month_min - 1].name" />   
                            <number-form class="text-center font-bold cursor-pointer "
                                     name="year_min" :value="year_min" type="number" @on-change="changeYearMin" min="1900" :editing="true" /> 
                        </div> 
                        <div @click="goToNextMonth_min"  class="flex justify-center col-span-2 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light">
                            <v-icon  icon="arrow-right" fill="gray-700" :size=5 cls="dark:text-white" class="" />
                        </div> 
                    </div>

                    <div class="grid grid-cols-7 gap-x-1 gap-y-2 px-1 py-1">
                        <div v-for="(i, k) in days" :key="k+222">
                            <p class="font-semibold px-1 "> {{i}}</p>
                        </div>
                        <div v-for="(i, index) in populateDays_min" :key="index" class="text-center"> 
                            <p @mouseover="onHover(i)" @mouseleave="onNotHover"  @click="daySelected(i)" 
                                class="px-1 rounded py-1 cursor-pointer hover:bg-accentlight-lightish dark:hover:bg-accentlight-dark" 
                                :class="[
                                        {'opacity-70': i.blur},
                                        {'bg-primary-light dark:bg-accent-dark bg-opacity-80  text-white font-bold  ':
                                            (   (i.blur==false)
                                                && ( ((min!=null&&max!=null) 
                                                            && compareDate(i, {date:selectedDay_min, month: selectedMonth_min, year: selectedYear_min} ) 
                                                            && compareDate( {date:selectedDay_max, month: selectedMonth_max, year: selectedYear_max}, i) )
                                                
                                                || ((min!=null&&max==null) && ( compareDate({date:hovered_day, month: hovered_month, year: hovered_year}, i) && compareDate(i, {date:selectedDay_min, month:selectedMonth_min, year: selectedYear_min}) ) )
                                        ) ) },
                                        {'font-semibold':!i.blur},{'bg-primary-light dark:bg-primary-dark font-bold text-white': 
                                        ((i.blur==false)&&( (selectedDay_min==(i.date)&&selectedYear_min==year_min&&selectedMonth_min==month_min)||
                                                            (selectedDay_max==(i.date)&&selectedYear_max==year_min&&selectedMonth_max==month_min) ))}
                                    ]">
                                {{i.date}} 
                            </p> 
                        </div>
                    </div>                                                          
                                                                                    
                </div>



                <div class="w-60 md:col-span-6">
                    <div class="grid grid-cols-12 mb-2 items-center">
                        
                        <div @click="goToPrevMonth_max"  class="flex justify-center col-span-2 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light">
                            <v-icon  icon="arrow-left" fill="gray-700" :size=5 cls="dark:text-white" class="" />
                        </div>

                       <div class=" col-span-8 flex justify-start gap-x-3"> 
                             <dropdown-form class="w-20 capitalize"
                                name="months" @on-change="changeMonthMax" :editing="true"
                                :options="months_drop"
                                :value="months_drop[month_max - 1].name" />   
                            <number-form class="text-center font-bold cursor-pointer "
                                     name="year_max" :value="year_max" type="number" @on-change="changeYearMax" :min="year_min" :editing="true" /> 
                        </div> 
                        <div @click="goToNextMonth_max"  class="flex justify-center col-span-2 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light">
                            <v-icon  icon="arrow-right" fill="gray-700" :size=5 cls="dark:text-white" class="" />
                        </div> 
                    </div>

                    <div class="grid grid-cols-7 gap-x-1 gap-y-2 px-1 py-1">
                        <div v-for="(i, k) in days" :key="k+111">
                            <p class="font-semibold px-1 "> {{i}}</p>
                        </div>
                        <div v-for="(i, index) in populateDays_max" :key="index" class="text-center"> 
                            <p @mouseover="onHover(i)" @mouseleave="onNotHover" @click="daySelected(i)" 
                                class="px-1 rounded py-1 cursor-pointer hover:bg-accentlight-lightish dark:hover:bg-accentlight-dark" 
                                :class="[
                                        {'opacity-70': i.blur},
                                        {'bg-primary-light dark:bg-accent-dark bg-opacity-80 text-white font-bold  ':
                                            (   (i.blur==false)
                                                && ( ((min!=null&&max!=null) 
                                                            && compareDate(i, {date:selectedDay_min, month: selectedMonth_min, year: selectedYear_min} ) 
                                                            && compareDate( {date:selectedDay_max, month: selectedMonth_max, year: selectedYear_max}, i) )
                                                
                                                || ((min!=null&&max==null) && ( compareDate({date:hovered_day, month: hovered_month, year: hovered_year}, i) ) )
                                        ) ) },
                                        {'font-semibold':!i.blur},{'bg-primary-light dark:bg-primary-dark font-bold text-white': 
                                        ((i.blur===false)&&( (selectedDay_min==(i.date)&&selectedYear_min==year_max&&selectedMonth_min==month_max)||
                                                            (selectedDay_max==(i.date)&&selectedYear_max==year_max&&selectedMonth_max==month_max) ))}
                                    ]">
                                {{i.date}} 
                            </p> 
                        </div>
                    </div>  
                </div>

           


            </div>

           
        </section>



      </div>
      <div v-else>
          <p class="capitalize" :class="[{'text-gray-400': (min == null || max == null )}]"> 
              {{ (min == null)? $t('select_start_date') : $date.dd(min, 's')  }}   -     {{  (max == null)? $t('select_end_date') : $date.dd(max, 's')}} 
              </p>
      </div>
  </section>
</template>

<script>
import VIcon from '../../icons/v-icon.vue';
import NumberForm from '../number.form.vue';
import DropdownForm from '../dropdown.form.vue';

export default {
    components: { VIcon, DropdownForm, NumberForm },
    props: ['min', 'max', 'gravity', 'label_cls', 'value_cls', 'icon_direction'],
    data(){
        return{
            editing: true,
            editing_year: false,
            drop: false,
            pick_year_min: false,
            pick_year_max: false,
            
            months: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 
                    'October', 'November', 'December'],
            
            months_drop: [{name: 'Jan', id:0}, {name: 'Feb', id:1}, {name: 'Mar', id:2}, {name: 'Apr', id:3},
                     {name: 'May', id:4}, {name: 'Jun', id:5}, {name: 'Jul', id:6},
                     {name: 'Aug', id:7}, {name: 'Sep', id:8}, {name: 'Oct', id:9}, {name: 'Nov', id:10}, 
                     {name: 'Dec', id:11}],
            
            days: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
            
            // date_min : new Date(),
            // day_min : new Date().getDate(),
            month_min : new Date().getMonth()+1,
            year_min : new Date().getFullYear(),

            // date_max : new Date(),
            // day_max : new Date().getDate(),
            month_max : new Date().getMonth()+1,
            year_max : new Date().getFullYear(),
           
            date_min : null, day_min : null,  
            date_max : null, day_max : null,  
           
            selectedDate_min : null,
            selectedDay_min : null,
            selectedMonth_min : new Date().getMonth()+1,
            selectedYear_min : new Date().getFullYear(),
             

            hovered_day: null,
            hovered_month: new Date().getMonth() + 1,
            hovered_year: new Date().getFullYear(),

            selectedDate_max : null,
            selectedDay_max : null,
            selectedMonth_max : new Date().getMonth()+1,
            selectedYear_max : new Date().getFullYear(),
        }
    },
    mounted(){
        this.hovered_year = this.selectedYear_min; this.hovered_month = this.selectedMonth_min; this.hovered_day = this.selectedDay_min; 
        this.year_max = this.year_min;
        this.month_max = this.month_min;
        this.year_max= this.nMonth_max.year;
        this.month_max= this.nMonth_max.month;  
    },
    watch:{ 

        min(min){
            
            if(min==null) {
                this.date_min = null; this.day_min = null; 
                this.selectedDate_min = null; this.selectedDay_min = null;
                return;
            }
 
            this.selectedDate_min = min; this.selectedDay_min = min.getDate();
            this.selectedMonth_min = min.getMonth() + 1;
            this.selectedYear_min = min.getFullYear()
            
        },

        max(max){  

            if(max==null) {
                this.date_max = null; this.day_max = null;
                this.selectedDate_max = null; this.selectedDay_max = null;
                return;
            }
           
            this.selectedDate_max = max; this.selectedDay_max = max.getDate();
            this.selectedMonth_max  = max.getMonth() + 1;
            this.selectedYear_max = max.getFullYear();
        }

    },
 
    computed: {
        month_and_year_max(){return this.months[this.month_max-1] + ' ' + this.year_max;},
        nMonth_max(){  
            //returns the next month
            if (this.month_max+ 1 > this.months.length) {
                return {year:this.year_max+1, month: 1}
            }
            return {year:(this.year_max)*1, month: (this.month_max+1)*1 };
        },
        pMonth_max(){
            //returns the previos month
            if (this.month_max- 1 < 1) {
                return {year:this.year_max-1, month: this.months.length}
            }
            return {year:this.year_max*1, month:(this.month_max-1)*1}; 
        }, 
        month_and_year_min(){return this.months[this.month_min-1] + ' ' + this.year_min;},
        nMonth_min(){  
            //returns the next month
            if (this.month_min+ 1 > this.months.length) {
                return {year:this.year_min+1, month: 1}
            }
            return {year:this.year_min*1, month:(this.month_min+1)*1};
        },
        pMonth_min(){
            //returns the previos month
            if (this.month_min- 1 < 1) {
                return {year:this.year_min-1, month: this.months.length}
            }
            return {year:this.year_min*1, month:(this.month_min-1)*1};

        },
        populateDays_min(){
            var dates = [];
            //get the first date of the month
            var month_start_day = this.firstDate(this.year_min, this.month_min).getDay();
            if(month_start_day == 0) month_start_day = 7;
            //console.log('firstdate: ', month_start_day);
            
            if(month_start_day > 1){
                var previos_month_last_date = this.lastDate(this.pMonth_min.year, this.pMonth_min.month).getDate();
               // console.log('previos month last date', previos_month_last_date)
                for(var xxx = month_start_day - 2; xxx >= 0 ; xxx--){
                    dates.push({date:previos_month_last_date - xxx, month:this.pMonth_min.month, year:this.pMonth_min.year, blur: true});
                }
            }

            //populate this month dates
            var no_of_days_in_this_month = this.lastDate(this.year_min, this.month_min).getDate();
            //console.log('no of days in this month', no_of_days_in_this_month);

            for(var vvv = 1; vvv <= no_of_days_in_this_month; vvv++){ dates.push({date:vvv, month:this.month_min, year:this.year_min, blur: false}); }

            //if the table is not full add the next dates
            var no_of_days_of_next_month = this.lastDate(this.nMonth_min.year, this.nMonth_min.month).getDate();
            //console.log('no of days in next month', no_of_days_of_next_month);

            if(dates.length % 7 != 0){
                for(var ext = 1; ext < no_of_days_of_next_month && dates.length % 7 != 0; ext++){
                    dates.push({date:ext, blur:true, month:this.nMonth_min.month, year:this.nMonth_min.year,});
                }
            }
            //console.log('dates', dates);
            return dates;
        },
        populateDays_max(){
            var dates = [];
            //get the first date of the month
            var month_start_day = this.firstDate(this.year_max, this.month_max).getDay();
            //console.log('firstdate: ', month_start_day);
            
            if(month_start_day > 1){
                var previos_month_last_date = this.lastDate(this.pMonth_max.year, this.pMonth_max.month).getDate();
               // console.log('previos month last date', previos_month_last_date)
                for(var xxx = month_start_day - 2; xxx >= 0 ; xxx--){
                    dates.push({date:previos_month_last_date - xxx, month:this.pMonth_max.month, year:this.pMonth_max.year, blur: true});
                }
            }

            //populate this month dates
            var no_of_days_in_this_month = this.lastDate(this.year_max, this.month_max).getDate();
            //console.log('no of days in this month', no_of_days_in_this_month);

            for(var vvv = 1; vvv <= no_of_days_in_this_month; vvv++){ dates.push({date:vvv, month:this.month_max, year:this.year_max, blur: false}); }

            //if the table is not full add the next dates
            var no_of_days_of_next_month = this.lastDate(this.nMonth_max.year, this.nMonth_max.month).getDate();
            //console.log('no of days in next month', no_of_days_of_next_month);

            if(dates.length % 7 != 0){
                for(var ext = 1; ext < no_of_days_of_next_month && dates.length % 7 != 0; ext++){
                    dates.push({date:ext, blur:true, month:this.nMonth_max.month, year:this.nMonth_max.year,});
                }
            }
            //console.log('dates', dates);
            return dates;
        },
    },
    methods: {

        compareDate(date1, date2){ return date1!=null && ( (date1.year > date2.year) || (date1.year == date2.year && date1.month > date2.month) || (date1.date > date2.date && date1.month == date2.month && date1.year == date2.year)  ) },

        onHover(date){  
            if(this.compareDate(date, {year: this.year_min, month: this.month_min, date: this.day_min})){
                this.hovered_day = date.date; this.hovered_month = date.month; this.hovered_year = date.year; 
            }
        },

        onNotHover(){ this.hovered_day = this.day_min; this.hovered_month = this.month_min; this.hovered_year = this.year_min; },

        clickedOutside(e){     
            for (let i = 0; i < e.path.length; i++) {
                if (e.path[i].classList && e.path[i].classList.contains('calendar')) {
                    return ; } }
            this.drop = false;  
        }, 

        goToNextMonth_min () {
            this.year_min = this.nMonth_min.year;
            this.month_min = this.nMonth_min.month; 
            //changing max calendar
            this.year_max = this.year_min;
            this.month_max = this.month_min;
            this.year_max= this.nMonth_max.year;
            this.month_max= this.nMonth_max.month; 
        },


        goToPrevMonth_min () {
            this.year_min = this.pMonth_min.year;
            this.month_min = this.pMonth_min.month;  
            //changing max calendar
            this.year_max = this.year_min;
            this.month_max = this.month_min;
            this.year_max= this.nMonth_max.year;
            this.month_max= this.nMonth_max.month;
        },   


        goToNextMonth_max () {
            this.year_max= this.nMonth_max.year;
            this.month_max= this.nMonth_max.month; 
            //go to next min 
            this.year_min = this.year_max;
            this.month_min = this.month_max;
            this.year_min = this.pMonth_min.year;
            this.month_min = this.pMonth_min.month; 
            
        },


        goToPrevMonth_max () {
            this.year_max= this.pMonth_max.year;
            this.month_max= this.pMonth_max.month;  
            //changing min calendar
            this.year_min = this.year_max;
            this.month_min = this.month_max;
            this.year_min = this.pMonth_min.year;
            this.month_min = this.pMonth_min.month; 
        }, 


        changeMonthMax(event){
            this.month_max = event.id + 1; 
            this.month_min = this.month_max; 
            this.year_min = this.pMonth_min.year;
            this.month_min = this.pMonth_min.month; 
        }, 


        changeMonthMin(event){
            this.month_min = event.id + 1;
            this.month_max = this.month_min;
            this.year_max = this.nMonth_max.year;
            this.month_max = this.nMonth_max.month;
        },

        changeYearMax(event){
            this.year_max = event * 1; 
            this.year_min = this.year_max; 
            this.month_min = this.month_max; 
            this.year_min = this.pMonth_min.year;
            this.month_min = this.pMonth_min.month; 
        },  
        
        changeYearMin(event){
            this.year_min = event * 1;
            this.year_max = this.year_min;
            this.month_max = this.month_min;
            this.year_max = this.nMonth_max.year;
            this.month_max = this.nMonth_max.month;
        }, 

        daySelected(day){
            console.log('day: ', day);
            console.log('min: ', day);
            console.log('max: ', day);

            if(this.min != null && this.compareDate({date:this.min.getDate(), month: this.min.getMonth()+1, year: this.min.getFullYear()}, day) ){
            //if there is min and no max make the selected date max
                this.$emit('on-change', { min: (new Date(day.year + '-' + (day.month) + '-' + (day.date))).toISOString(),
                                        max: null, });
            }else if(this.min != null && this.max == null){
            //if there is min and the selected date is before it delete max and make only min starting from it
                this.$emit('on-change', { min: this.min,
                                        max: (new Date(day.year + '-' + (day.month) + '-' + (day.date))).toISOString(), });
                                        this.drop = false;
            }else{
            //if there is min and max make the selected date slected_min date
                this.$emit('on-change', { min: (new Date(day.year + '-' + (day.month) + '-' + (day.date))).toISOString(),
                                        max: null, });
            }
            
        }, 

        lastDate(y,m){ return  new Date(y, m , 0); },
 
        firstDate(y,m){ return  new Date(y, m-1, 1); }, 

        this_week(){
            var curr = new Date;
            var firstday = new Date(curr.setDate( (curr.getDate() - curr.getDay()) + 1));
            var lastday = new Date(curr.setDate(curr.getDate() - curr.getDay()+7));
            this.$emit('on-change', {min:  firstday, max: lastday});
             this.drop = false;
        },
        this_month(){
            var curr = new Date();
            var firstday = new Date(curr.getFullYear(), curr.getMonth(), 1);
            var lastday = new Date(curr.getFullYear(), curr.getMonth() + 1, 0);
            this.$emit('on-change', {min:  firstday, max: lastday});
             this.drop = false;
        },
        this_year(){
            var curr = new Date;
            var firstday = new Date(curr.getFullYear(), 0, 1);
            var lastday = new Date(curr.getFullYear(), 11, 31);
            this.$emit('on-change', {min:  firstday, max: lastday});
             this.drop = false;
        },
        last_week(){
             var curr = new Date;
            var firstday = new Date(curr.setDate( (curr.getDate() - curr.getDay()) - 6));
            var lastday = new Date(curr.setDate(curr.getDate() - curr.getDay()+7));
            this.$emit('on-change', {min:  firstday, max: lastday});
             this.drop = false;
        },
        last_month(){
            var curr = new Date();
            if(curr.getMonth() == 0){
                var firstday = new Date(curr.getFullYear()-1, 11, 1);
                var lastday = new Date(curr.getFullYear()-1, 11, 31);
            }else{
                firstday = new Date(curr.getFullYear(), curr.getMonth() - 1, 1);
                lastday = new Date(curr.getFullYear(), curr.getMonth(), 0);
            }
            this.$emit('on-change', {min:  firstday, max: lastday});
             this.drop = false;
        },
        last_year(){ 
            var curr = new Date;
            var firstday = new Date(curr.getFullYear()-1, 0, 1);
            var lastday = new Date(curr.getFullYear()-1, 11, 31);
            this.$emit('on-change', {min:  firstday, max: lastday}); 
            this.drop = false;
        },
 
    }
}
</script>

<style>

</style>