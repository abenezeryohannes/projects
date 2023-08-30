
class HelperUtil{

    generateCombinations(args) {
        if(args==null) return [];
        var r = [], max = args.length-1;
        function helper(arr, i) {
            if(args[i]!=null)
            for (var j=0, l=args[i].length; j<l; j++) {
                var a = arr.slice(0); // clone arr
                a.push(args[i][j]);
                if (i===max)
                    r.push({combinations: a});
                else
                    helper(a, i+1);
            }
        }
        helper([], 0);
        return r;
    }
    generateCombinationsWithName(args, product) {
        if(args==null) return [];
        var r = [], max = args.length-1;
        function helper(arr, i) {
            if(args[i]!=null)
                for (var j=0, l=args[i].length; j<l; j++) {
                    var a = arr.slice(0); // clone arr
                    a.push(args[i][j]);
                    if (i===max) {
                        // console.log('aaa:', a[0].variation)
                        let names = [];
                        a.forEach(x => names.push(x.variation));
                        // for(let iii=0;i<a.length;iii++){
                        //    name += a[0].variation
                        // }
                        // console.log('names : ',names.join(', '))
                        r.push({combinations: a, name: names.join(', '), sku: product.sku, price: product.price, cost: product.cost});
                    }else
                        helper(a, i+1);
                }
        }
        helper([], 0);
        return r;
    }

    CombinationName(args){

        let response = []; let index = 0;

        args.forEach(variant => {
            response.push({name: ''});
            variant.combinations.forEach(variation => {
                response[index].name += ( variation.variation);
                if(variant.combinations.indexOf(variation) < variant.length-1) response[index].name+=', ';
            } )
            index++;
        })
        return response;
    }
}
module.exports = new HelperUtil();