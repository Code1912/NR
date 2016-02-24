/**
 * Created by code1912 on 16/2/22.
 */
"use strict";
var methodArray={
    updateContent:function (str)
    {
        $("#content").html(str);
        window.location.href="ios:test?abc=dsf";
       // return  document.getElementById("content").innerHTML;
    },
    setBackground:function (str)
    {
        $("body").css({"background-image":"url('"+str+"')"});
        //return document.body.style.backgroundImage
    }

}

var device={height:0,width:0};
var position={x:0,y:0};

function  callFunc(funcName,arg) {
    return  methodArray[funcName] && methodArray[funcName](arg);
}

function onTouchStart(x,y)
{

}

function onTouchEnd(x,y)
{

}

$(document).ready(function()
{
    $(".font-setting>div").on("mousedown touchstart",function(){
        $(this).attr("class","btn-touch");


    }).on("mouseup touchend",function(){
        $(this).attr("class","btn");

    });
    $("#chapterList").bind("touchstart",function(event)
    {
        if(!window.event.touches||window.event.touches.length==0)
        {
            return;
        }
        alert(window.event.touches[0].clientX);
    })
    $("#changeSource").bind("touchstart",function(event)
    {
        if(!window.event.touches||window.event.touches.length==0)
        {
            return;
        }
        alert(window.event.touches[0].clientX);
    })
    $("#font").bind("touchstart",function(event)
    {
        if(!window.event.touches||window.event.touches.length==0)
        {
            return;
        }
        alert(window.event.touches[0].clientX);
    })
    $("#light").bind("touchstart",function(event)
    {
        if(!window.event.touches||window.event.touches.length==0)
        {
            return;
        }
        alert(window.event.touches[0].clientX);
    })
    //$(".setting").hide();
})