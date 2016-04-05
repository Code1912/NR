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

    $scope.toolbarDisplay=false;
    $scope.settingDisplay=false;
    $scope.articleStyle={top:0,fontSize:13}
    $scope.setting={
         readColor:0
        ,readClass:"color1"
        ,light:10
        ,downCount:-1
        ,readSize:13
        ,autoLight:false
    };
    $scope.backTouch=function() {
         callDevice("back");
    }
    $scope.bodyTouch=function(event) {
        // $scope.settingDisplay=!    $scope.settingDisplay;

        if ($scope.toolbarDisplay || $scope.settingDisplay) {
            hideSetting();
            return;
        }
        if (!$scope.toolbarDisplay) {
            $scope.toolbarDisplay = true;
        }
    }

    $scope.chooseColor= function (color) {
        $scope.setting.readColor=color;
        $scope.setting.readClass="color"+color;
        callDevice("property",{readColor:color});
    }

    $scope.colorTouch= function () {
        $scope.setting.autoLight=false;
    }

    $scope.autoLight= function () { 
        $scope.setting.autoLight=!$scope.setting.autoLight;
    }

    $scope.chooseDown=function(count)
    {
        $scope.setting.downCount =count;
        callDevice("property",{downCount:count});
    }

    $scope.colorClass=function(color)
    {
        return $scope.setting.readColor===color?'color-picker-box check':'color-picker-box uncheck';
    }

    $scope.downClass=function(count)
    {
      return  $scope.setting.downCount ===count?"li-20 ul-h-30 down-check":"li-20 ul-h-30 down-uncheck"
    }

    $scope.navigationTouch= function (index) {
        $scope.toolbarDisplay = false;
        if (index === 2) {
            $scope.settingDisplay = true;
        }
        else if(index==1){
            $scope.settingDisplay = true;
            callDevice("list");
        }

    }

    $scope.pageUp= function () {
        hideSetting();
        var height = $("#content").height();
        if ($scope.articleStyle.top === 0) {
            callDevice("up")
            return;
        }
        $scope.articleStyle.top += screen.height;
    }

    $scope.pageDown= function () {
        hideSetting();
        var height = $("#content").height();
        if (Math.abs($scope.articleStyle.top-screen.height)>height) {
            callDevice("next")
            return;
        }
        $scope.articleStyle.top -= screen.height;
    }
    function hideSetting() {
        $scope.toolbarDisplay = false;
        $scope.settingDisplay = false;
    }
    function  stopFunc()
    {
        if (window.event.stopPropagation) {
            window.event.stopPropagation();
        }
    }

    function  callDevice(name,params)
    {
        var array=[];
        if(params)
        {
            for(var key in params)
            {
                array.push(key+"="+params[key]);
            }
        }
        window.location.href="ios:"+name+"?"+array.join("&");
    }
}]);
var methodArray={
    updateContent:function (str)
    {
        $("#content").html(str);
    },
    setBackground:function (str)
    {

    },
    setProperty:function (str)
    {
        var args=str.split("=");
        var name=args[0];
        var value=args[1];
        if(name==="readColor") {

            $scope.setting.readColor = parseInt(str);
            $scope.setting.readClass = "color" + color;
        }

        if(name==="readSize")
        {
            $scope.setting.readSize=parseInt(str);
        }

        if(name==="downCount")
        {
            $scope.setting.downCount=parseInt(str);
        }
        return true;
    }
}

var device={height:0,width:0};
var position={x:0,y:0};

function  callFunc(funcName,arg) {
    return  methodArray[funcName] && methodArray[funcName](arg);
}