/**
 * Created by code1912 on 16/2/22.
 */
"use strict";
var methodArray={
    updateContent:function (str)
    {
        document.getElementById("content").innerHTML=str;
        window.location.href="ios:test?abc=dsf";
        return 1;
    },
    setBackground:function (str)
    {
        //document.body.style.backgroundImage=str;
  alert( document.body.style.backgroundImage)
        return document.body.style.backgroundImage="url('"+str+"')";
    }

}
function  callFunc(funcName,arg) {
  return  methodArray[funcName] && methodArray[funcName](arg);
}
