/**
 * Created by code1912 on 16/2/22.
 */
"use strict";
var app=angular.module("reader",
    []
);
app.directive("bodyTouch",function($parse){
    return {
        restrict: 'AE',
        replace: true,
        compile:function(element, attr)
        {
            var fn = $parse(attr["ngTouch"]);
            return function($scope, $element, $attr) {
                $element.on("touchstart",function (event) {
                    if($(this).attr("data-tag")===1) {
                        $scope.$apply(function () {
                            fn($scope, {$event: event});
                        });
                    }

                })
            };
        }
    };
});
app.directive("ngTouch",function($parse){
    return {
        restrict: 'AE',
        replace: true,
        compile:function(element, attr)
        {
            var fn = $parse(attr["ngTouch"]);
            return function($scope, $element, $attr) {
                $element.on("touchstart",function (event) {
                    if($(this).attr("no-bubble")&&event.target!==this)
                    {
                        return;
                    }
                    $scope.$apply(function () {
                        fn($scope, {$event: event});
                    });
                })
            };
        }
    };
});
app.directive("ngTouchEnd",function($parse){
    return {
        restrict: 'AE',
        replace: true,
        compile:function(element, attr)
        {
            var fn = $parse(attr["ngTouchEnd"]);
            return function($scope, $element, $attr) {
                $element.on("touchend",function (event) {

                    $scope.$apply(function () {
                        fn($scope, {$event: event});
                    });
                })
            };
        }
    };
});
app.directive("ngHoverBg",function($parse){
    return {
        restrict: 'AE',
        replace: true,
        compile:function(element, attr)
        { 
            return function($scope, $element, $attr) {
                $element.on("touchstart  touchend ",function (event) {

                    var obj=$(this);
                    var bg=obj.css("background-color");
                    obj.css("background-color",obj.attr("ng-hover-bg"))
                    obj.attr("ng-hover-bg",bg);
                });
            };
        }
    };
});
app.controller("HomeCtrl",["$scope", function ($scope) {

    $scope.footerDisplay=false;
    $scope.settingDisplay=false;
    $scope.articleStyle={top:0}
    $scope.setting={
        color:1
        ,read_class:"color1"
        ,light:10
        ,down_count:-1
        ,auto_light:false 
    };

    $scope.bodyTouch=function(event) {
        // $scope.settingDisplay=!    $scope.settingDisplay;

        if ($scope.footerDisplay || $scope.settingDisplay) {
            $scope.footerDisplay = false;
            $scope.settingDisplay = false;
            return;
        }
        if (!$scope.footerDisplay) {
            $scope.footerDisplay = true;
        }
    }

    $scope.chooseColor= function (color) {
        $scope.setting.color=color;
        $scope.setting.read_class="color"+color; 
    }
    $scope.colorTouch= function () {
        $scope.setting.auto_light=false;
    }

    $scope.autoLight= function () { 
        $scope.setting.auto_light=!$scope.setting.auto_light;
    }

    $scope.chooseDown=function(count)
    {
        $scope.setting.down_count =count;
    }

    $scope.colorClass=function(color)
    {
        return $scope.setting.color===color?'color-picker-box check':'color-picker-box uncheck';
    }

    $scope.downClass=function(count)
    {
      return  $scope.setting.down_count ===count?"li-20 ul-h-30 down-check":"li-20 ul-h-30 down-uncheck"
    }

    $scope.navigationTouch= function (index) {
        $scope.footerDisplay = false;
        if (index === 2) {
            $scope.settingDisplay = true;
        }
    }

    $scope.pageUp= function () {
        var height = $("#content").height();
        if ($scope.articleStyle.top === 0) {
            return;
        }
        $scope.articleStyle.top += screen.height;
    }

    $scope.pageDown= function () {
        var height = $("#content").height();
        if (Math.abs($scope.articleStyle.top-screen.height)>height) {
            return;
        }
        $scope.articleStyle.top -= screen.height;
    }
    function  stopFunc()
    {
        if (window.event.stopPropagation) {
            window.event.stopPropagation();
        }
    }

    function  callDevice(name,params)
    {
        window.location.href="ios:"+name+"?"+params;
    }
}]);
var methodArray={
    updateContent:function (str)
    {
        $("#content").html(str);
        window.location.href="ios:test?abc=dsf";
       // return  document.getElementById("content").innerHTML;
    },
    setBackground:function (str)
    {
        //$("body").css({"background":"url('"+str+"') no-repeat"});
        //$("body").css({"background-size":"100% 100%"});
        //return document.body.style.backgroundImage
    }

}

var device={height:0,width:0};
var position={x:0,y:0};

function  callFunc(funcName,arg) {
    return  methodArray[funcName] && methodArray[funcName](arg);
}
$(document).ready(function()
{
    //$(".font-setting>div").on("mousedown touchstart",function(){
     //   $(this).attr("class","btn-touch");


   // }).on("mouseup touchend",function(){
     //   $(this).attr("class","btn");

   // });

    //$(".setting").hide();
})