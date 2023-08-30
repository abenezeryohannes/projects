<template>
    <section class="flex calendar w-full" v-click-outside="clickedOutside">

        <div v-if="editing" class="relative w-full">
            <div @click="drop = !drop; month = selectedMonth; year = selectedYear;" class=" py-2 flex ">
                <p class="capitalize my-auto"> {{ value == null ? '-' : dd(value, 's') }} </p>

                <v-icon cls="ml-2 cursor-pointer dark:text-gray-200 " fill="gray-500" icon="date" :size=4 />
            </div>


            <div v-if="drop && !pick_year"
                :class="[{ 'right-0': gravity == 'left' }, { 'left-full': gravity == 'right' }, { 'right-0': gravity == null }]"
                class="absolute  text-ty w-60 z-30  top-12 border-2 border-gray-200 dark:border-gray-500
                    bg-background-light dark:bg-background-darkish rounded-lg shadow-lg py-2 px-2">

                <div class="w-full">

                    <div class="grid grid-cols-12 mb-2 items-center">
                        <div @click="goToPrevMonth"
                            class="flex justify-center col-span-2 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light">
                            <v-icon icon="arrow-left" fill="gray-700" :size=5 cls="dark:text-white" class="" />
                        </div>
                        <!-- <span @click="goToPrevMonth" class="col-span-3 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light"> &lt; </span>   -->
                        <!-- <span @click="pick_year = true;" class="text-center font-bold col-span-8 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light"> {{month_and_year}} </span>   -->


                        <div class=" col-span-8 flex justify-start gap-x-3">
                            <!-- <dropdown-form class="w-7/12 capitalize"
                            name="months" @on-change="month = month_names.findIndex(i => {return i.name === $event.name})+1" :editing="true"
                            :options="month_names"
                            :value="month_names[month-1].name" />   -->
                            <span @click="pick_year = true;"
                                class="font-bold px-2 w-6/12 py-2 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light">
                                {{ t(months[month - 1]) }} </span>

                            <number-form class="text-center w-6/12 font-bold cursor-pointer " name="year_min"
                                :value="year.toString()" type="number" @on-change="year = Number($event)" :min=1900
                                :editing="true" />
                        </div>


                        <div @click="goToNextMonth"
                            class="flex justify-center col-span-2 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light">
                            <v-icon icon="arrow-right" fill="gray-700" :size=5 cls="dark:text-white" class="" />
                        </div>
                        <!-- <span @click="goToNextMonth" class="col-span-3 py-1 cursor-pointer dark:hover:bg-accentlight-dark hover:bg-accentlight-light"> &gt; </span>   -->
                    </div>

                    <div class="grid grid-cols-7 gap-x-1 gap-y-2 px-1 py-1">
                        <div v-for="i in days" :key="i">
                            <p class="font-semibold px-1"> {{ i }}</p>
                        </div>
                        <div v-for="(i, index) in populateDays" :key="index" class="text-center">

                            <p @click="daySelected(i)"
                                class="px-1 rounded py-1 cursor-pointer hover:bg-accentlight-lightish dark:hover:bg-accentlight-dark"
                                :class="[{ 'opacity-70': i.blur }, { 'font-semibold': !i.blur }, {
                                    'bg-primary-light dark:bg-primary-dark font-bold text-white':
                                        ((i.blur == false) && selectedDay == (i.date) && selectedYear == year && selectedMonth == month)
                                }]">
                                {{ i.date }}
                            </p>

                        </div>
                    </div>

                    <div class="flex justify-end">
                        <p @click="onToday()" class="font-bold mb-2  mt-2 rounded py-1 px-3 cursor-pointer hover:bg-accentlight-lightish 
                            dark:hover:bg-accentlight-dark capitalize"> {{ t('today') }} </p>
                    </div>

                </div>
            </div>

            <div v-else-if="pick_year"
                class="capitalize z-30 w-full absolute font-semiboldleft-0 top-12 right-0 bottom-0 shadow ">
                <div class="bg-background-light dark:bg-background-darkish w-full px-3 rounded-lg pt-2">
                    <!-- <p class="font-bold text-left mb-2 mt-2">{{t('year')}} </p>
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
                    <p class="font-bold text-left mb-2 mt-3">{{ t('month') }} </p>

                    <div class="grid grid-cols-3 text-center capitalize">
                        <div v-for="(i, index) in months" :key="i"
                            @click="month = index + 1; pick_year = false; drop = true;"
                            :class="[{ ' dark:bg-primary-dark bg-primary-light ': months[month - 1] == i }]"
                            class="font-semibold py-2 hover:bg-accentlight-lightish rounded  dark:hover:bg-accentlight-dark cursor-pointer">
                            <p> {{ t(i.substring(0, 3)) }}</p>
                        </div>
                    </div>


                    <div class="flex justify-end">
                        <p @click="pick_year = false; drop = true;" class="font-bold mb-2  mt-2 rounded py-1 px-3 cursor-pointer hover:bg-accentlight-lightish 
                            dark:hover:bg-accentlight-dark"> {{ t('next') }} </p>
                    </div>
                </div>
            </div>


        </div>

        <div v-else>
            <p class="capitalize"> {{ value }} </p>
        </div>
    </section>
</template>

<script setup lang="ts">


import { computed, ref, watch } from 'vue';
import { useI18n } from '../../../i18n';
import VIcon from '../../icons/v-icon.vue';
import NumberForm from '../number.form.vue';
import { dd } from '../../../util';

const { t } = useI18n();

const props = defineProps<{
    value?: Date | null, gravity?: string
}>();


const editing = ref<boolean>(true);
const editing_year = ref<boolean>(false);
const drop = ref<boolean>(false);
const pick_year = ref<boolean>(false);

const months = ref<string[]>(['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September',
    'October', 'November', 'December']);

const month_names = ref<{ name: string }[]>([{ name: 'January' }, { name: 'February' }, { name: 'March' }, { name: 'April' }, { name: 'May' }, { name: 'June' }, { name: 'July' },
{ name: 'August' }, { name: 'September' }, { name: 'October' }, { name: 'November' }, { name: 'December' }]);

const days = ref<string[]>(['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']);

const date = ref<Date>(new Date());
const day = ref<number>(new Date().getDate());
const month = ref<number>(new Date().getMonth() + 1);
const year = ref<number>(new Date().getFullYear());

const selectedDate = ref<Date>(new Date());
const selectedDay = ref<number>(new Date().getDate());
const selectedMonth = ref<number>(new Date().getMonth() + 1);
const selectedYear = ref<number>(new Date().getFullYear());

watch(() => props.value, (value, oldVal) => {
    if (value == null) return;
    date.value = value; day.value = value!.getDate()
    month.value = value?.getMonth() + 1; year.value = value.getFullYear()

    selectedDate.value = value; selectedDay.value = value.getDate();
    selectedMonth.value = value.getMonth() + 1
    selectedYear.value = value.getFullYear()
});

const emit = defineEmits<{
    (event: 'on-change', param: any): void
}>();

const month_and_year = computed(() => { return months.value[month.value - 1] + ' ' + year.value; });

const nMonth = computed(() => {
    //returns the next month
    if (month.value + 1 > months.value.length) {
        return { year: year.value + 1, month: 1 }
    }
    return { year: year.value, month: month.value + 1 };
});

const pMonth = computed(() => {
    //returns the previos month
    if (month.value - 1 < 1) {
        return { year: year.value - 1, month: months.value.length }
    }
    return { year: year.value, month: month.value - 1 };

});
const populateDays = computed(() => {
    var dates = [];
    //get the first date of the month 0 1 2 3 4 5 6
    var month_start_day = firstDate(year.value, month.value).getDay();
    if (month_start_day == 0) month_start_day = 7;
    console.log('firstdate: ', month_start_day);

    if (month_start_day > 1) {
        var previos_month_last_date = lastDate(pMonth.value.year, pMonth.value.month).getDate();
        console.log('previos month last date', previos_month_last_date)
        for (var xxx = month_start_day - 2; xxx >= 0; xxx--) {
            dates.push({ date: previos_month_last_date - xxx, month: pMonth.value.month, year: pMonth.value.year, blur: true });
        }
    }

    //populate this month dates
    var no_of_days_in_this_month = lastDate(year.value, month.value).getDate();
    console.log('no of days in this month', no_of_days_in_this_month);

    for (var vvv = 1; vvv <= no_of_days_in_this_month; vvv++) { dates.push({ date: vvv, month: month.value, year: year.value, blur: false }); }

    //if the table is not full add the next dates
    var no_of_days_of_next_month = lastDate(nMonth.value.year, nMonth.value.month).getDate();
    console.log('no of days in next month', no_of_days_of_next_month);

    if (dates.length % 7 != 0) {
        for (var ext = 1; ext < no_of_days_of_next_month && dates.length % 7 != 0; ext++) {
            dates.push({ date: ext, blur: true, month: nMonth.value.month, year: nMonth.value.year, });
        }
    }
    console.log('dates', dates);
    return dates;
});

function onToday() {
    selectedDate.value = new Date();
    selectedDay.value = new Date().getDate();
    selectedMonth.value = new Date().getMonth() + 1;
    selectedYear.value = new Date().getFullYear();
    year.value = selectedYear.value; month.value = selectedMonth.value;
    drop.value = !drop.value;
}
function clickedOutside(e: any) {
    for (let i = 0; i < e.path.length; i++) {
        if (e.path[i].classList && e.path[i].classList.contains('calendar')) {
            return;
        }
    }
    drop.value = false; pick_year.value = false
}

function goToNextMonth() {
    year.value = nMonth.value.year;
    month.value = nMonth.value.month;
}
function goToPrevMonth() {
    year.value = pMonth.value.year;
    month.value = pMonth.value.month;
}

function daySelected(day: any) {
    selectedDate.value = new Date(day.year + '-' + (day.month) + '-' + (day.date));
    selectedDay.value = (day.date);
    selectedMonth.value = day.month;
    selectedYear.value = day.year;
    month.value = day.month; year.value = day.year;
    drop.value = false;
    emit('on-change', (selectedDate.value).toISOString());

    // this.toast.success('date: '+day.date + ' month: '+ (day.month) + ' year: ' + year.value);
}

function lastDate(y: any, m: any) {
    return new Date(y, m, 0);
}

function firstDate(y: any, m: any) {
    // console.log('year: ', y);
    // console.log('month: ', m);
    // console.log('date: ', new Date(y, m-1, 1));
    return new Date(y, m - 1, 1);
}
</script>

<style>

</style>