// import Dinero from 'dinero.js'

const currency = require('currency.js')

class SalaryComputer {

    netPayment(salary, benefits, deductions, overtimes, tax){
        //net payment = (wage + benefit) - total_deduction - total_tax;

        var taxable_and_non_taxbale = this.divideTaxable(salary, overtimes, benefits);
 
        var total_taxable = taxable_and_non_taxbale.total_taxable; 

        // var total_overtime = this.compute_total_overtime(salary, overtimes);

        var total_tax = this.total_tax((total_taxable), tax);

        var total_deduciton = this.total_deduction(salary, deductions);


        return currency(salary).add(benefits).subtract(total_deduciton).subtract(total_tax).value;

    }
 

    //overtime -> company_id + payment_id + hour + value + enabled + type  

    total_deduction(salary, deductions){
        var total_deductions = 0;
        if(deductions!=null)
        deductions.forEach(d => {
            if(d.enabled){
                var ded = currency(d.amount).add( currency(d.percent/100).multiply(salary) ).value;
                total_deductions += (ded);
            } 
        });  
        return total_deductions
    }
    
    total_tax(total_taxable, tax){
        var total_tax = 0;
        if(tax!=null&&tax.rate!=null){
            total_tax = currency(total_taxable).multiply(Number(tax.rate)/100).subtract(tax.deduction).value;
        }
        return total_tax;
    }

    divideTaxable(salary, overtimes, benefits){
        var total_benefits = 0;
        var total_taxable_benefits = 0;
        if(benefits!=null)
        benefits.forEach(b => {
            if(b.enabled){

                var ben = currency(b.amount).add( currency(salary).multiply(b.percent/100).value ).value;
                
                total_benefits += ben;

                if(b.EmployeeBenefitType.taxable){
                    if(Number(ben ) > Number(b.EmployeeBenefitType.min_non_taxable_amount)){

                        total_taxable_benefits += currency(ben).subtract(b.EmployeeBenefitType.min_non_taxable_amount).value;

                    }else if(Number(b.percent) > Number(b.EmployeeBenefitType.min_non_taxable_percent)){
                        total_taxable_benefits += currency(salary).multiply(
                                                    (Number(b.percent) - Number(b.EmployeeBenefitType.min_non_taxable_percent))/100
                                                ).value; 
                    }
                }
            }

        }); 
        var total_non_taxable_benefits = currency(total_benefits).subtract(total_taxable_benefits).value; 
        var total_overtime = this.compute_total_overtime(salary, overtimes);
        return {
            total_non_taxable: total_non_taxable_benefits,
            total_taxable: currency(total_taxable_benefits).add(Number(salary)).add(total_overtime).value,
            total_benefits: total_benefits,
            total_taxable_benefits: total_taxable_benefits,
            total_non_taxable_benefits: total_non_taxable_benefits
        }
    }




    compute_total_overtime(salary, overtimes){
        var total = currency(0);
        
        if(overtimes!=null && Array.isArray(overtimes)) 
        overtimes.forEach(ot => {

            total = total.add(Number(ot.day) * Number(ot.hour) 
            * Number(ot.EmployeeOvertimeType.rate_per_hour) 
            *
            (  Number(salary) / Number(ot.EmployeeOvertimeType.total_hour)  )
            );
        console.log('total: ', 'day: ' + ot.day + ' * hour: '+ot.hour);
        console.log('total: ', total.value)

        });  
        console.log('total: ', total.value)

        return total.value
    }




    partitionSalary(salary, benefits, deductions, fringeBenefits, overtimes, tax){
        // console.log('benefits: ', benefits);
        // console.log('deductions: ', deductions);
        // console.log('fringe benefits: ', fringeBenefits);
        // console.log('salary: ', salary);
        // console.log('tax: ', tax);

        //benefit
    
        var total_benefits = 0;
        var total_taxable_benefits = 0;
        if(benefits!=null)
        benefits.forEach(b => {
            if(b.enabled){

                var ben = currency(b.amount).add( currency(salary).multiply(b.percent/100).value ).value;
                            //  (Number(b.amount) + ((Number(b.percent)*Number(salary))/100));
                total_benefits += ben;
                                //Number(ben); 

                if(b.EmployeeBenefitType.taxable){
                    if((ben ) > Number(b.EmployeeBenefitType.min_non_taxable_amount)){
                        total_taxable_benefits += currency(ben).subtract(b.EmployeeBenefitType.min_non_taxable_amount).value;
                            // Number(ben) - Number(b.EmployeeBenefitType.min_non_taxable_amount);
                    }else if(Number(b.percent) > Number(b.EmployeeBenefitType.min_non_taxable_percent)){
                        total_taxable_benefits += currency(currency(b.percent).subtract(b.EmployeeBenefitType.min_non_taxable_percent).value)
                                                        .multiply(salary).divide(100).value;
                    }
                }
            }

        }); 
        var total_non_taxable_benefits = currency(total_benefits).subtract(total_taxable_benefits).value; 
                // total_benefits - total_taxable_benefits;


        // console.log('total_benefits: ', total_benefits);
        // console.log('total_taxable_benefits: ', total_taxable_benefits);
        // console.log('total_non_taxable_benefits: ', total_non_taxable_benefits);
   
        //fringebenefit
        
        var total_fringebenefits = 0;
        var total_taxable_fringebenefits = 0;
        if(fringeBenefits!=null)
        fringeBenefits.forEach(fb => {
            if(fb.enabled){

                var ben = currency(fb.amount).add( currency(fb.percent).multiply(salary).divide(100).value).value;
                        // (Number(fb.amount) + ((Number(fb.percent)*Number(salary))/100));
                total_fringebenefits += ben;
                                // Number(ben); 

                if(fb.EmployeeFringeBenefitType.taxable){
                    if(Number(ben ) > Number(fb.EmployeeFringeBenefitType.min_non_taxable_amount)){
                        total_taxable_fringebenefits += currency(ben).subtract(fb.EmployeeFringeBenefitType.min_non_taxable_amount).value;
                    }else if(Number(fb.percent) > Number(fb.EmployeeFringeBenefitType.min_non_taxable_percent)){
                        total_taxable_fringebenefits += currency(currency(fb.percent).subtract(fb.EmployeeFringeBenefitType.min_non_taxable_percent).value)
                                                        .multiply(salary).divide(100).value;
                    } 
                }
            } 
        }); 
        var total_non_taxable_fringebenefits = currency(total_fringebenefits).subtract(total_taxable_fringebenefits).value;

        
        // console.log('total_fringebenefits: ', total_fringebenefits);
        // console.log('total_taxable_fringebenefits: ', total_taxable_fringebenefits);
        // console.log('total_non_taxable_fringebenefits: ', total_non_taxable_fringebenefits); 


        // total_overtime
        ///////////////////////////////////////////////
        /////////////////////////////////////////////////
        var total_overtime = new SalaryComputer().compute_total_overtime(salary, overtimes);

        /////////////////////////////////////////////////
        ////////////////////////////////////////////////
        // tax
        var total_taxable = currency(total_overtime).add(total_taxable_benefits).add(salary).value;

        var total_tax = 0;
        if(tax!=null&&tax.rate!=null){
            total_tax = currency(total_taxable).multiply(Number(tax.rate)/100)
                        .subtract(tax.deduction).value;
            // (( (Number(total_taxable_benefits) + 
            //              Number(salary)) * Number(tax.rate/100)) + Number(tax.deduction));
        }
        // console.log('total_tax: ', total_tax)

        var total_fringetax = 0;
        if(tax!=null&&tax.rate!=null){
            total_fringetax =  currency(total_taxable_fringebenefits).multiply(Number(tax.rate)/100).value;
            // (Number(total_taxable_fringebenefits)) * Number(tax.rate/100);
        }
        // console.log('total_fringetax: ', total_fringetax)




        //deduction

        var total_deductions = 0;
        if(deductions!=null)
        deductions.forEach(b => {
            if(b.enabled){
                var ded = currency(b.amount).add( currency(b.percent).multiply(salary/100).value ).value;
                // (Number(b.amount) + ((Number(b.percent)*Number(salary))/100));
                total_deductions += (ded);
            } 
        });  
        // console.log('total_deductions: ', total_deductions);



        var net_payment = currency(salary).add(total_benefits).subtract(total_tax).subtract(total_deductions).value;
                    //  (salary + total_benefits) -(total_tax + total_deductions);
        // console.log('net_payment: ', net_payment);

        return {
            total_expense: currency(total_benefits).add(salary).add(total_fringebenefits).value,
            gross_payment: currency(total_taxable).add(total_non_taxable_benefits).value,
            // (total_benefits + salary),
            net_payment: net_payment,
            total_fringe_benefits: total_fringebenefits,
            total_deductions: total_deductions,
            total_benefits: total_benefits,
            total_overtimes: total_overtime,
            total_tax: total_tax,

            total_fringetax: total_fringetax,
            total_taxable: total_taxable,
            total_non_taxable: total_non_taxable_benefits,
            total_non_taxable_fringebenefits: total_non_taxable_fringebenefits,
        }

    }

 
    partitionCheckpoint(checkpoints, tax){
        // console.log('checkpoints: ', checkpoints); 
        // var totals = [];
        // var wages = [];
        // var taxes = [];
        // var benefits = [];
        // var values = [];
        var total = 0; var total_wages = 0; var total_benefits = 0;
        if(checkpoints!=null)
        checkpoints.forEach(ch => {
            var temp = currency(ch.wage).add(ch.benefit).value;
            total += temp;
            // totals.push(temp); 
            // wages.push(ch.wage); 
            // benefits.push(ch.benefit);
            // var tax = (tax==null||tax.rate==null)?0 : currency(temp).multiply(Number(tax.rate)/100).subtract(tax.deduction).value ;
            // taxes.push(tax);
            total_benefits += Number(ch.benefit);
            total_wages += Number(ch.wage);
            // values.push(currency(temp).subtract(taxes).value);
        });

        var tax_deduction = 0;
        if(tax != null&&tax.rate!=null){
            tax_deduction += currency(total).multiply(Number(tax.rate)/100).subtract(tax.deduction).value;
            //(((total*Number(tax.rate)))+Number(tax.deduction));
        }

        // console.log('total: ', total);
        // console.log('net: ', total - tax_deduction);
        // console.log('tax_deduction: ', tax_deduction);

        return {
            total_payments: total,
            net_payment: currency(total).subtract(tax_deduction).value,  
            total_tax: tax_deduction,
            // taxes: taxes,
            // values: values,
            // totals: totals,
            // benefits: benefits,
            // wages: wages,
            total_wages: total_wages,
            total_benefits: total_benefits

        }
    }

    
    computeCheckpoint(checkpoint, tax){
        // console.log('checkpoints: ', checkpoints); 
        // var total = 0; var total_wages = 0; var total_benefits = 0;  
        if(checkpoint==null) return {
            total_payments: 0, net_payment: 0,  
            total_tax: 0, total_wages: 0, total_benefits: 0
        } 

        var total = currency(checkpoint.wage).add(checkpoint.benefit).value; 
        var tax_deduction = (tax==null||tax.rate==null)? 
                0 : currency(total).multiply(Number(tax.rate)/100).subtract(tax.deduction).value ;

        // console.log('total: ', total);
        // console.log('net: ', total - tax_deduction);
        // console.log('tax_deduction: ', tax_deduction);

        return {
            total_payments: total,
            net_payment: currency(total).subtract(tax_deduction).value,  
            total_tax: tax_deduction, 
            total_wages: Number(checkpoint.wage),
            total_benefits: Number(checkpoint.benefit) 
        }
    }



    v = function(x){
        if(x == null) return 0;
        return x*1;
    }
}
module.exports = new SalaryComputer();