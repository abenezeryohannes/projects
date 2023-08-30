<template>
  <section class="flex calendar w-full"  v-click-outside="clickedOutside" >
      
    <div v-if="editing" class="relative w-full ">
        <div @click="drop = !drop; month = selectedMonth; year = selectedYear;" 
            class=" py-2 flex "> 
            <p class="capitalize my-auto"> {{$date.dd(value, 's')}} </p>

            <v-icon cls="ml-2 cursor-pointer dark:text-gray-200 " fill="gray-500" icon="date" :size=4 />
        </div>

        <div v-if="drop&&!pick_year" :class="[{'right-0':gravity=='left'}, {'left-full':gravity=='right'},{'right-0':gravity==null}]"
                    class="absolute text-ty  w-60 z-30  border-2 border-gray-200 dark:border-gray-500
                        top-12 bg-background-light dark:bg-background-darkish
                        rounded-lg shadow-lg py-2 px-2">
           
            <div class="w-full">

                <div class="grid grid-cols-12 mb-2 items-center">
                    <div @click="goToPrevMonth"  class="flex justify-center col-span-2 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light">
                        <v-icon  icon="arrow-left" fill="gray-700" :size=5 cls="dark:text-white" class="" />
                    </div>
                    <!-- <span @click="goToPrevMonth" class="col-span-3 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light"> &lt; </span>   -->
                    <!-- <span @click="pick_year = true;" class="font-bold col-span-8 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light"> {{month_and_year}} </span>   -->
                    
                    
                    <div class=" col-span-8 flex justify-start gap-x-3"> 
                        <!-- <dropdown-form class="w-7/12 capitalize"
                            name="months" @on-change="month = month_names.findIndex(i => {return i.name === $event.name})+1" :editing="true"
                            :options="month_names"
                            :value="month_names[month-1].name" />   -->
                        <span @click="pick_year = true;" class="font-bold px-2 w-6/12 py-2 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light"> 
                            {{$t(months[month-1])}} </span>  

                        <number-form class="text-center w-6/12 font-bold cursor-pointer "
                                    name="year_min" :value="year" type="number" @on-change="year = $event" min="1900" :editing="true" /> 
                    </div> 
                    
                    <div @click="goToNextMonth"  class="flex justify-center col-span-2 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light">
                        <v-icon  icon="arrow-right" fill="gray-700" :size=5 cls="dark:text-white" class="" />
                    </div>
                    <!-- <span @click="goToNextMonth" class="col-span-3 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light"> &gt; </span>   -->
                </div>

                <div class="grid grid-cols-7 gap-x-1 gap-y-2 px-1 py-1">
                    <div v-for="i in days" :key="i">
                        <p class="font-semibold px-1"> {{i}}</p>
                    </div>
                    <div v-for="(i, index) in populateDays" :key="index" class="text-center"> 
                        <p  @click="daySelected(i)" 
                            class=" px-1 rounded py-1 cursor-pointer hover:bg-accentlight-lightish dark:hover:bg-accentlight-dark" 
                            :class="[{'opacity-70': i.blur},{'font-semibold':!i.blur},{'bg-primary-light dark:bg-primary-dark font-bold text-white': 
                                ((i.blur==false)&&selectedDay==(i.date)&&selectedYear==year&&selectedMonth==month)}]">
                            {{i.date}} 
                        </p> 
                    </div>
                </div>     

                <div class="flex justify-end">
                     <p @click="onToday()" 
                        class="font-bold mb-2  mt-2 rounded py-1 px-3 cursor-pointer hover:bg-accentlight-lightish 
                            dark:hover:bg-accentlight-dark capitalize"> {{$t('today')}} </p>
                </div>                                                     
                                                                                
            </div>
        </div>

        <div v-else-if="pick_year" class="capitalize z-30 w-full absolute font-semiboldleft-0 top-12 right-0 bottom-0 shadow ">
            <div class="bg-background-light dark:bg-background-darkish w-full px-3 rounded-lg pt-2">
                <!-- <p class="font-bold text-left mb-2 mt-2">{{$t('year')}} </p>
                <div class="flex flex-row justify-center items-center">
                    <div @click="year-=1; " >
                        <v-icon icon="arrow-left" fill="gray-700" :size=6 cls="dark:text-white" class="cursor-pointer mr-3" />
                    </div>
                        <p @click="year-=1; pick_year = false; drop = true;" class="cursor-pointer opacity-80 mr-3"> {{(year - 1)}}</p>
                        
                        <div @click="editing_year = false" class="font-bold text-md" >
                            <text-form :value='year' :editing="editing_year"/>
                        </div>
                        
                        <p @click="year+=1; pick_year = false; drop = true;" class="cursor-pointer opacity-80 ml-3"> {{(year + 1)}}</p>
                    <div @click="year+=1;">
                        <v-icon  icon="arrow-right" fill="gray-700" :size=6 cls="dark:text-white" class="cursor-pointer ml-3" />
                    </div>
                </div> -->
                <p class="font-bold text-left mb-2 mt-3">{{$t('month')}} </p>
                
                <div class="grid grid-cols-3 text-center capitalize">
                    <div v-for="(i, index) in months" :key="i"
                    @click="month = index+1; pick_year = false; drop = true;"
                    :class="[{' dark:bg-primary-dark bg-primary-light text-white': months[month-1] == i}]"
                     class="font-semibold py-2 hover:bg-accentlight-lightish rounded  dark:hover:bg-accentlight-dark cursor-pointer" >
                        <p> {{$t(i.substring(0, 3))}}</p>
                    </div>
                </div>


                <div class="flex justify-end">
                     <p @click="pick_year = false; drop = true;" 
                        class="font-bold mb-2  mt-2 rounded py-1 px-3 cursor-pointer hover:bg-accentlight-lightish 
                            dark:hover:bg-accentlight-dark"> {{$t('back')}} </p>
                </div>
            </div>
        </div>




      </div>
      <div v-else>
          <p class="capitalize"> {{value}} </p>
      </div>
  </section>
</template>

<script>
// import textForm from '../../../components/forms/text.form'
import VIcon from '../../icons/v-icon.vue'; 
// import DropdownForm from '../dropdown.formcontrol.vue';
import NumberForm from '../number.form.vue';

export default {
    components: { VIcon,   NumberForm},
    props: ['value', 'gravity'],
    data(){
        return{
            editing: true,
            editing_year: false,
            drop: false,
            pick_year: false,
            
            months: ['Meskerem', 'Tikimt', 'Hidar', 'Tahisas', 'Tir', 'Yekatit', 'Megabit', 'Meyaziya', 'Ginbot', 'Sene', 
                    'Hamle', 'Nehase', 'Puagme'],

            month_names: [{name:'Meskerem'}, {name:'Tikimt'}, {name:'Hidar'}, {name:'Tahisas'},
                     {name:'Tir'}, {name:'Yekatit'}, {name:'Megabit'}, {name:'Meyaziya'}, 
                     {name:'Ginbot'}, {name:'Sene'}, {name:'Hamle'}, {name: 'Nehase'}, 
                     {name:'Puagme'}],
            
            days: ['Se', 'Ma', 'Ro', 'Ha', 'Ar', 'Qi', 'Eh'],
            // dates: [],

            date : this.$date.convertToEt(new Date()),
            day : this.$date.convertToEt(new Date()).date,
            month : this.$date.convertToEt(new Date()).month,
            year :this.$date.convertToEt(new Date()).year,

            selectedDate : this.$date.convertToEt(new Date()),
            selectedDay : this.$date.convertToEt(new Date()).date,
            selectedMonth : this.$date.convertToEt(new Date()).month,
            selectedYear : this.$date.convertToEt(new Date()).year,
        }

    },
    watch:{
        value(value){
            if(value==null) return;
            // value = this.$date.convertToEt(value);
            this.date = this.$date.convertToEt(value); this.day = this.$date.convertToEt(value).date;
            this.month = this.$date.convertToEt(value).month; this.year = this.$date.convertToEt(value).year;

            this.selectedDate = this.$date.convertToEt(value);   this.selectedDay = this.$date.convertToEt(value).date; 
            this.selectedMonth = this.$date.convertToEt(value).month;  this.selectedYear = this.$date.convertToEt(value).year;
        }
    },
    computed: {
        month_and_year(){return this.months[this.month-1] + ' ' + this.year;},
        nMonth(){  
            //returns the next month
            if (this.month + 1 > this.months.length) {
                return {year:this.year+1, month: 1}
            }
            return {year:this.year, month:this.month+1};
        },
        pMonth(){
            //returns the previos month
            if (this.month - 1 < 1) {
                return {year:this.year-1, month: this.months.length}
            }
            return {year:this.year, month:this.month-1};

        },
        populateDays(){
            var dates = [];
            //get the first date of the month
            var month_start_day = this.firstDate(this.year, this.month);
            if(month_start_day == 0) month_start_day = 7;
            console.log('firstdate: ', month_start_day);
            
            if(month_start_day > 1){
                var previos_month_last_date = this.lastDate(this.pMonth.year, this.pMonth.month);
                console.log('previos month last date', previos_month_last_date)
                for(var xxx = month_start_day - 2; xxx >= 0 ; xxx--){
                    dates.push({date:previos_month_last_date - xxx, month:this.pMonth.month, year:this.pMonth.year, blur: true});
                }
            }

            //populate this month dates
            var no_of_days_in_this_month = this.lastDate(this.year, this.month);
            console.log('no of days in this month', no_of_days_in_this_month);

            for(var vvv = 1; vvv <= no_of_days_in_this_month; vvv++){ dates.push({date:vvv, month:this.month, year:this.year, blur: false}); }

            //if the table is not full add the next dates
            var no_of_days_of_next_month = this.lastDate(this.nMonth.year, this.nMonth.month);
            console.log('no of days in next month', no_of_days_of_next_month);

            if(dates.length % 7 != 0){
                for(var ext = 1; ext < no_of_days_of_next_month && dates.length % 7 != 0; ext++){
                    dates.push({date:ext, blur:true, month:this.nMonth.month, year:this.nMonth.year,});
                }
            }
            console.log('dates', dates);
            return dates;
        },
    },
    methods: {
        onToday(){ 
            this.selectedDate = this.$date.convertToEt(new Date());
            this.selectedDay = this.$date.convertToEt(new Date()).date;
            this.selectedMonth = this.$date.convertToEt(new Date()).month;
            this.selectedYear = this.$date.convertToEt(new Date()).year;
            this.year = this.selectedYear; this.month = this.selectedMonth;
            this.drop = !this.drop; 
        },
        clickedOutside(e){     
            for (let i = 0; i < e.path.length; i++) {
                if (e.path[i].classList && e.path[i].classList.contains('calendar')) {
                    return ;
                }
            }
            this.drop = false; this.pick_year = false
        },

        goToNextMonth () {
            this.year = this.nMonth.year;
            this.month = this.nMonth.month;
        },
        goToPrevMonth () {
            this.year = this.pMonth.year;
            this.month = this.pMonth.month;
        }, 
        daySelected(day){
            var etDate = this.$date.etDate(day.year, day.month, day.date, new Date().getHours(), new Date().getMinutes(), new Date().getSeconds());
            
            this.selectedDate = this.$date.convertToGrig(etDate);
			this.selectedDay = (day.date);
			this.selectedMonth = day.month;
			this.selectedYear = day.year;
            this.month = day.month; this.year = day.year;
            this.drop = false;
            this.$emit('on-change', this.selectedDate.toISOString());
            // this.$toast.success('date: '+day.date + ' month: '+ (day.month) + ' year: ' + this.year);
        },
        lastDate(y,m){
            if(m>12) {
                var yy = y+9;
                if(yy % 4 == 0){
                    if(yy % 100 == 0){
                        if(yy%400 == 0) return 6;
                        else return 5;
                    }else return 6;
                }else{ return 5; }
            }
            else return 30;
        },
        firstDate(y,m){
            var etDate = this.$date.etDate(y, m, 1, new Date().getHours(), new Date().getMinutes(), new Date().getSeconds());
            // console.log('year', y, 'month', m)
            // console.log('etDate: ')
            // console.log( etDate)
            // console.log( 'etDate day', etDate.getDay())
            
            //there seams to be an error calculating the date
            return  etDate.getDay();
        },
    
    }
}
</script>

<style>

</style>