export  function convertKey(keyArr,obj){
    keyArr.forEach(item => {
        if(item.indexOf('-')!=-1){
           let newKey=newKeyEvent(item)
            modifyJosnKey(obj,item,newKey)
        }
    });
    Object.keys(obj).forEach(key=>{
        if(Object.prototype.toString.call(obj[key])==='[object Object]' || Object.prototype.toString.call(obj[key])==='[object Array]'){
            let keysArr=Object.keys(obj[key])
            if(keysArr.length!=0 && typeof obj[key]!='string' ){
                convertKey(keysArr,obj[key])
            }
        }
    })
//  出现多个 - 时的处理办法
    function newKeyEvent(key){
        let newKey=key.replace('-','_')
        if(newKey.indexOf('-')!=-1){
           return newKeyEvent(newKey)
        }else{
           return newKey
        }
     }
    //  调整key
    function modifyJosnKey(json,oddkey,newkey){
        let val=json[oddkey];
        delete json[oddkey];
        json[newkey]=val;
    }
}