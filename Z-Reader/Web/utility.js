/**
 * Created by code1912 on 16/2/22.
 */
"use strict";
var methodArray={
    updateContent:function (str)
    {
        document.getElementById("content").innerHTML=str;
        window.location.href="ios:test?abc=dsf";
        return  document.getElementById("content").innerHTML;
    },
    setBackground:function (str)
    {
        document.body.style.backgroundImage="url('"+str+"')";
        return document.body.style.backgroundImage
    }

}
function  callFunc(funcName,arg) {
  return  methodArray[funcName] && methodArray[funcName](arg);
}
