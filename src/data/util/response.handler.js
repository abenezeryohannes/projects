class ResponseHandler{

    handle(response){
        if(response == null) return false;
        return true;
    }

}

module.exports = new ResponseHandler();