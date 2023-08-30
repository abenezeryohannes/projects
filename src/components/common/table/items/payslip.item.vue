<template>
  <section>
      <div class="relative w-full flex justify-center  px-12 ">
        
        <transition class="slide-fade" v-if="loading" >
                <div class="custom_small_loader w-8 h-8 my-5"/> 
        </transition>
        <transition v-else name="slide-fade" >
             <div class="grid grid-cols-2  w-full md:px-12 gap-x-10 gap-y-2 py-4">

            
                        <div class="  " v-if="show_benefits || editing">
                                <benefits-component :wage="temp_slip.wage" :hide_wage="true"
                                    @on-wage-change="$set(temp_slip, 'wage', $event)"
                                    :benefitstring="JSON.stringify(temp_benefits)" 
                                    :benefit="(temp_benefits)" :editing="editing" 
                                    :errors="errors" @on-change="onBenefitChange" />
                            </div>

                        <div class="  "  v-if="show_deductions || editing" >
                                <deductions-component :hide_tax="true"
                                    :Tax="temp_slip.Tax" :wage="temp_slip.wage" :benefits="temp_benefits"
                                    @on-tax-change="$set(temp_slip, 'Tax', $event); $set(temp_slip, 'tax_id', $event.id)"
                                    :deductionstring="JSON.stringify(temp_deductions)" :overtimes="temp_overtimes"
                                    :deduction="(temp_deductions)" :editing="editing" 
                                  :errors="errors" @on-change="onDeductionChange" />
                            </div>

                        <div   class=" "  v-if=" temp_overtimes.length>0||editing">
                              <overtimes-component :wage="temp_slip.wage" 
                                  :work_schedule_id="employee_work_schedule_id"
                                  @on-wage-change="$set(temp_slip, 'wage', $event)"
                                  :overtimestring="JSON.stringify(temp_overtimes)" 
                                  :overtime="(temp_overtimes)" :editing="editing" 
                                  :errors="errors" @on-change="onOvertimeChange" /> 
                          </div>



            </div>
        </transition>

      
      <edit-fab v-if="false" class=" absolute bottom-5 right-5" :editing="editing" :size="6"
      :errors="errors" :loading="loading" @edit="edit" @save="save" @cancel="cancel" />
 

      </div>
  </section>
</template>

<script>
import errorHandlerUtil from '../../../../modules/util/error.handler.util';
import { get, postForm } from '../../../../modules/util/request.handler';
import EditFab from '../../../../components/common/edit.fab';

import benefitsComponent from '../../../../modules/employee/pages/payroll/components/benefits.component.vue'
import overtimesComponent from '../../../../modules/employee/pages/payroll/components/overtimes.component.vue'
import deductionsComponent from '../../../../modules/employee/pages/payroll/components/deductions.component.vue' 

export default {
  components: { benefitsComponent, EditFab, overtimesComponent, deductionsComponent  },
    props: ['index', 'data', 'headers', 'editing', 'error'],
    data(){
      return {
        loading: false,
        employee_work_schedule_id: null,
        errors: null,
        show_benefits: true,
        show_deductions: true,
        temp_slip: { Employee: { CompanyUser: {}, EmployeePrivateInformation: {}}, EmployeeContract: {}, Tax: {} },
        slip: { Employee: { CompanyUser: {}, EmployeePrivateInformation: {}}, EmployeeContract: {}, Tax: {} },
        temp_benefits: [], temp_deductions: [ ], temp_fringe_benefits: [], temp_overtimes: [],temp_deleted_overtimes: [],
        // editing: false, 
      }
    },
    async mounted(){ await this.load(true);}, 
    methods: {
        cancel(){
          this.copy();
          this.errors = null; this.loading = false;
        },
        copy(){
                this.temp_slip = JSON.parse(JSON.stringify(this.slip));
                this.temp_benefits = JSON.parse(JSON.stringify(this.temp_slip.EmployeeBenefits))
                this.temp_deductions = JSON.parse(JSON.stringify(this.temp_slip.EmployeeDeductions))
                this.temp_fringe_benefits = JSON.parse(JSON.stringify(this.temp_slip.EmployeeFringeBenefits))
                this.temp_overtimes = JSON.parse(JSON.stringify(this.temp_slip.EmployeeOvertimes))
                this.employee_work_schedule_id = this.temp_slip.EmployeeContract.employee_work_schedule_id; 
                this.show_beneifts = false; this.show_deductions = false;

                this.temp_benefits.forEach(element => {
                    if(element.enabled) { //console.log('element: ', element);
                     this.show_benefits = true; 
                     }
                });

                this.temp_deductions.forEach(element => {
                  if(element.enabled) this.show_deductions = true;
                });

                // console.log('gest', this.temp_benefits)
        },

        async load(show_loading){
            try{
              if(show_loading) this.loading = true;
                var res = await get('employee/payments/show/' +  this.data.payment_id);
                console.log('load: ', res.data);
                this.slip = res.data.data;
                this.copy();
            } catch( e ) { this.errors =  errorHandlerUtil.handle(e, this);  }finally{this.loading = false;}
        },
        getRequest(){
            var request = {};//JSON.parse(JSON.stringify(this.temp_slip)); 
            delete request.EmployeeBenefits;  
            delete request.EmployeeDeductions;  
            delete request.EmployeeOvertimes;  
            delete request.deleted_EmployeeOvertimes;  

            request.EmployeeBenefits = JSON.stringify(this.temp_benefits); 
            request.EmployeeDeductions = JSON.stringify(this.temp_deductions);   
            request.EmployeeOvertimes = JSON.stringify(this.temp_overtimes);   
            request.deleted_EmployeeOvertimes = JSON.stringify(this.temp_deleted_overtimes);  
            // console.log('sending....: ', request); 
            return JSON.stringify(request);
        },
        async save(){
            try{
                this.loading = true; 

                var request = this.getRequest();
                console.log('request: ', request);
                var res = await postForm('employee/payments/update/' +  this.data.payment_id, request,
                                                []);
                console.log('save: ', res.data); 
                await this.load(true);
            } catch( e ) { this.errors =  errorHandlerUtil.handle(e, this);  }finally{this.loading = false;}
        }, 
        onDeductionChange(deduction){ this.temp_deductions = deduction;   },
        onBenefitChange(benefits){  this.temp_benefits = benefits;   },
        onOvertimeChange(event){ 
          this.temp_overtimes = event.EmployeeOvertimes; 
          this.temp_deleted_overtimes = event.deleted_EmployeeOvertimes; 
        },


    },
    watch: { 


    },
}
</script>

<style>

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}


/* Enter and leave animations can use different */
/* durations and timing functions.              */
.slide-fade-enter-active {
  transition: all 0.7s ease-out;
}

.slide-fade-leave-active {
  transition: all 0.3s ease-in-out;
}

.slide-fade-enter-from,
.slide-fade-leave-to {
  transform: translateY(-20px);
  opacity: 0;
}
</style>