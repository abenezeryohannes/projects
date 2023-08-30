
import {
      ethDateTime,
    //   limits,
      converterDateTime,
    //   converterString
    } from 'ethiopian-calendar-date-converter';
import moment from 'moment';
    

class DateManager{

    constructor(vue){
        this.vue = vue;
        this.user = this.vue.$store.getters.user
        this.lang = (this.user !=null)? this.user.lang : 'en';
        this.calendar = (this.user !=null)? this.user.calendar : 'grig';
    }

    getFiscalPeriod(fiscal_month, fiscal_date){

        let today = new Date();
        let start_date = new Date( today.getFullYear(), fiscal_month-1, fiscal_date+1, 0, 0, 0 );
        let end_date = moment(start_date).add(1, 'years').subtract(1, 'days').toDate();
        if(moment(today).isBefore(start_date)){
            start_date = moment(start_date).subtract(1, 'years').toDate();
            end_date = moment(start_date).add(1, 'years').subtract(1, 'days').toDate();
        }
        return {start_date: start_date, end_date: end_date}
    }
    
    prepareDate(dateString, size){
        var string = null;
        if(dateString instanceof Date){
            string = dateString.toLocaleDateString();
        }else if( dateString instanceof ethDateTime){
            string = converterDateTime.toEuropean(dateString).toLocaleDateString();
        }else if( typeof dateString === 'string'){
            string = dateString
        }else return this.showDate(new Date().toISOString(), size);

        if(string ==='Invalid Date') string = new Date();

        return this.showDate(string, size);
    }

    showDate(dateString, size){
        var date = new Date(dateString);

        if(!this.calendar.toLowerCase().startsWith('et')){
            if(size ===null || size ==='s') return date.toDateString();
            else return date.toDateString();
        }else{
            if(size ===null || size ==='s') return converterDateTime.toEthiopian(date).dateString;
            else return converterDateTime.toEthiopian(date).dateWithDayString;
        }
    }
    
    etDate(year, month, date, hour, minute, second){
        return new ethDateTime(
            date, // day of month (in Ethioian Calendar)
            month, // month of year (second month of year, in Ethioian Calendar)
            year, // year (in Ethioian Calendar)
            hour, // hour (in Ethioian Time format)
            minute, // minute (in Ethioian Time format)
            second // second (in Ethioian Time format)
            );
    }
    getDay(dateString){
        var date = this.prepareDate(dateString, null);
        // console.log('date: ', date); 
        if(!this.calendar.toLowerCase().startsWith('et')){
            return new Date(date).getDate();
        }
        var ddd = date.replace(',', '').split(' ');
        return ddd[1];
    }


    monthAndYear(dateString){
        var date = this.prepareDate(dateString, null);
        // console.log('date: ', date);

        if(!this.calendar.toLowerCase().startsWith('et')) {
            return new Date(date).toLocaleString('default', { month: 'long' }) + ", " + new Date(date).getFullYear();
        }
        var ddd = date.replace(',', '').split(' ');
        var cd = []
        ddd.forEach(d => { cd.push(this.vue.$t(d.toLowerCase())); });

        return cd[0] +', '+ cd[2];
    }
    
    dateAndMonth(dateString){
        var date = this.prepareDate(dateString, null);
        // console.log('date: ', date);

        if(!this.calendar.toLowerCase().startsWith('et')) {
            return new Date(date).toLocaleString('default', { month: 'long' }) + ", " + new Date(date).getDate();
        }
        var ddd = date.replace(',', '').split(' ');
        var cd = []
        ddd.forEach(d => { cd.push(this.vue.$t(d.toLowerCase())); });

        return cd[0] +', '+ cd[1];
    }
    
    diff(vue, start, end){

        if(!this.calendar.toLowerCase().startsWith('et')){
            var grigStart = new Date(start); var grigEnd = new Date(end); 
            var months= ['sunday', 'monday', 'tuesday', 'wednsday', 'thursday', 'friday', 'saterday']
            // console.log(grigStart) 
            
            if(grigStart.getFullYear() === grigEnd.getFullYear() && grigStart.getMonth() === grigEnd.getMonth() &&
                grigStart.getDate() === grigEnd.getDate()){
                return vue.$t('for_day', {day: months[grigStart.getDay()] } );
            }
            else if(grigStart.getFullYear() ===grigEnd.getFullYear() && grigStart.getMonth() ===grigEnd.getMonth()){
                if(grigEnd.getDate() - grigStart.getDate() > 27)
                    return vue.$t('for_month', {month: grigStart.getMonth()} );
                else  return vue.$t('fromto', {from: this.dateAndMonth(start), to: this.dateAndMonth(end)} );
            }else if(grigStart.getFullYear() ===grigEnd.getFullYear()){
                return vue.$t('fromto', {from: this.dateAndMonth(start), to: this.dateAndMonth(end)} );
            }else return vue.$t('fromto', {from: this.dd(start), to: this.dd(end)} );
        }else{
            var etStart = this.convertToEt(start); var etEnd = this.convertToEt(end); 
                
            // console.log(etStart) 
            
            if(etStart.year === etEnd.year && etStart.month === etEnd.month && etStart.date === etEnd.date){
                return vue.$t('for_day', {day: etStart.getDay()} );
            }
            else if(etStart.year === etEnd.year && etStart.month === etEnd.month){
                if(etEnd.date - etStart.date > 27)
                    return vue.$t('for_month', {month: vue.$t((etStart.dateString.split(' ')[0]).toLowerCase()), year: etStart.year} );
                else  return vue.$t('fromto', {from: this.dateAndMonth(start), to: this.dateAndMonth(end)} );
                
            }else if(etStart.year === etEnd.year){
                return vue.$t('fromto', {from: this.dateAndMonth(start), to: this.dateAndMonth(end)} );
            }else return vue.$t('fromto', {from: this.dd(start), to: this.dd(end)} );
        }

 
    }
   
    dd(dateString, size){
        var date = this.prepareDate(dateString, size); 
        // console.log('date: ', date); // console.log('calendar: ', this.calendar);

        // if(!this.calendar.toLowerCase().startsWith('et')) 
        //  return date; 

        var ddd = date.replace(',', '').split(' ');
        var cd = []
        ddd.forEach(d => { (isNaN(d)? cd.push(this.vue.$t(d.toLowerCase())) : cd.push(d)); });
        // // console.log('cd: ', cd);
        return cd.join().replace(',', ' ')
    }



    convertToEt(dateString){
        return converterDateTime.toEthiopian(new Date(dateString));
    }
    
    
    convertToGrig(ethDate){
        return converterDateTime.toEuropean(ethDate);
    }

    number(number){
        return new Intl.NumberFormat().format(Number(number))
    }

    toMySql(date, now){
        if(date === null && now) return (new Date()).toISOString().slice(0, 19).replace('T', ' ');
        else if(typeof date === 'string' ) return (new Date(date)).toISOString().slice(0, 19).replace('T', ' ');
        return date.toISOString().slice(0, 19).replace('T', ' ');
    }


    fM(amount, decimalCount = 2, decimal = ".", thousands = ",") {
        try {
            //
          decimalCount = Math.abs(decimalCount);
          decimalCount = isNaN(decimalCount) ? 2 : decimalCount;
      
          const negativeSign = amount < 0 ? "-" : "";
      
          let i = parseInt(amount = Math.abs(Number(amount) || 0).toFixed(decimalCount)).toString();
          let j = (i.length > 3) ? i.length % 3 : 0;
      
          return negativeSign + (j ? i.substr(0, j) + thousands : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousands) + (decimalCount ? decimal + Math.abs(amount - i).toFixed(decimalCount).slice(2) : "") + ' ETB';
        } catch (e) {
          console.log(e)
        }
      }

}

export default DateManager;