class Memo{
    name?: string;
    path: string;
    type: string;
    size?: any;
    originalname?: any;

    constructor(name: string | undefined, path: string, type: string, size?: any | undefined) {
        this.name = name;
        this.path = path;
        this.type = type;
        this.size = size; 
      }

    static decode(val: any){
        return JSON.parse(val);
    }

    static encode(val: any){
        return JSON.stringify(val);
    }

    static compare(memo1: Memo, memo2: Memo){
        return ((memo1!=null && memo2!=null) && 
                ((memo1.name == memo2.name) ) 
                && (memo1.size == memo2.size));
    }

    static includes(memos: Memo[], memo: Memo){
        for(var i = 0 ; i<memos.length; i++){
            if(memos[i]!=null && this.compare(memos[i], memo)) return i;
        }
        return -1;
    }



    static memfication(previos: Memo[]|string, new_memo: Memo[]|string, delete_memo: Memo[]|string){
        //initiate the response
        let memos: Memo[] = [];let  dm: Memo[]= [];  let nm: Memo[] = [];
        // start with previos memo
        if(previos!=null && typeof previos === 'string') memos = Memo.decode(previos);
        else if(previos!=null && Array.isArray(previos)) memos = previos;
        // console.log('previous memo', memos)
        //populate nm with new memo=
        if(new_memo!=null && typeof new_memo === 'string') nm = Memo.decode(new_memo);
        else if(new_memo!=null && Array.isArray(new_memo)) nm = new_memo;
        // console.log('new memos', nm)
        //add new memos if not included in memos
        if(nm!=null){
             nm.forEach(newm => { 
                 if(this.includes(memos, newm) == -1){
                    console.log('memos contain new memo false for: ', newm, )
                    memos.push(new Memo(newm.name==null? newm.originalname : newm.name, newm.path, newm.type, newm.size))
                }
            });
        }
        // console.log('after adding new to prev', memos);

        
        //populate dm with delete memo=
        if(delete_memo!=null && typeof delete_memo === 'string') dm = Memo.decode(delete_memo);
        else if(delete_memo!=null && Array.isArray(delete_memo)) dm = delete_memo;
        console.log('deleted memos', dm);

        //remove memos if included in memos
        if(dm!=null){
            for(var i = 0;i<dm.length; i++){
                const index = this.includes(memos, dm[i])
                if( index!=-1) memos.splice(index, 1);
            }
        }
        console.log('after deleting removed memos finally', memos);
// 

        return Memo.encode(memos);
    }

}

export default Memo;