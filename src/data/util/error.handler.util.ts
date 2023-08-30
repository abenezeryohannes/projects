import { EventBus} from "vue-toastification";

class ErrorHandlerUtil{

    showError(error: any, toast: any){
      toast.error(error, {timeout: 5000});
    }

    handle(error: any, toast: any, router: any){
        if(error.response == null){
          console.log(error.toString());
          console.log(error.response.data.toString());
          this.showError(error.toString(), toast)
        }
        else if(error.response.status === 400){
          //error with message
            toast.error(error.response.data.message,{timeout: 5000,});
        }else if(error.response.status === 409){
            //conflict or runtime error or operation not succeed
            //show alert
            toast.error(error.response.data.message,{timeout: 5000,});
        }else if(error.response.status === 500){
            //programming server error
            //show long array to show the backend error
            toast(error.response.data.message);
        }else if(error.response.status === 422){
            //validation error
            // console.log('validation-error', error.response.data)
            return ((error.response.data));
        }else if(error.response.status === 401){
            //un-authorized
            router.push({name:'login'});
        }
        return null;
    }
     

    parse(errors: any, name: string){
        let error: any = null;
        if(errors!=null && errors.errors!=null){
          (errors.errors as any[]).forEach(e => {
              // console.log('forEach: ', e, name);
            if(Object.prototype.hasOwnProperty.call(e, name)){
              if(error==null) {
                  // console.log(' hasOwnProperty: ', name);
                  error = e[name];
              }
            } 
          });
        }
        // console.log('returning error: ', error);
        return error;
    }



}
export default new ErrorHandlerUtil();