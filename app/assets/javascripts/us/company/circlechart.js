$(function() {
  var lastAchievementCount = gon.company_repository.achievements.length - 1
  var operating_profit_margin_data = [
    {
      value: gon.company_repository.achievements[lastAchievementCount]['operating_profit_margin'],
      color:"#1a243f"
    },
    {
      // grayの部分
      value : 100 - gon.company_repository.achievements[lastAchievementCount]['operating_profit_margin'],
      color : "#eee"
    }
  ];
  var ctx = document.getElementById("canvas--operating-profit-margin").getContext("2d");
  new Chart(ctx).Doughnut(operating_profit_margin_data,{
    segmentShowStroke : false,
    segmentStrokeColor : "#fff",
    segmentStrokeWidth : 1,
    percentageInnerCutout : 80, // **** Border width
    animation : true,
    animationSteps : 100,
    animationEasing : "easeOutBounce",
    animateRotate : true,
    animateScale : false,
    onAnimationComplete : null
  });
});

$(function() {
  var lastAchievementCount = gon.company_repository.achievements.length - 1
  var roe_data = [
    {
      value: gon.company_repository.achievements[lastAchievementCount]['roe'],
      color:"#1a243f"
    },
    {
      // grayの部分
      value : 100 - gon.company_repository.achievements[lastAchievementCount]['roe'],
      color : "#eee"
    }
  ];
  var ctx = document.getElementById("canvas--roe").getContext("2d");
  new Chart(ctx).Doughnut(roe_data,{
    segmentShowStroke : false,
    segmentStrokeColor : "#fff",
    segmentStrokeWidth : 1,
    percentageInnerCutout : 80, // **** Border width
    animation : true,
    animationSteps : 100,
    animationEasing : "easeOutBounce",
    animateRotate : true,
    animateScale : false,
    onAnimationComplete : null
  });
});

$(function() {
  var lastAchievementCount = gon.company_repository.achievements.length - 1
  var roa_data = [
    {
      value: gon.company_repository.achievements[lastAchievementCount]['roa'],
      color:"#1a243f"
    },
    {
      // grayの部分
      value : 100 - gon.company_repository.achievements[lastAchievementCount]['roa'],
      color : "#eee"
    }
  ];
  var ctx = document.getElementById("canvas--roa").getContext("2d");
  new Chart(ctx).Doughnut(roa_data,{
    segmentShowStroke : false,
    segmentStrokeColor : "#fff",
    segmentStrokeWidth : 1,
    percentageInnerCutout : 80, // **** Border width
    animation : true,
    animationSteps : 100,
    animationEasing : "easeOutBounce",
    animateRotate : true,
    animateScale : false,
    onAnimationComplete : null
  });
});

if (gon.compare) {
  $(function() {
    var roa_data = [
      {
        value: gon.compare['roa'],
        color:"#57bede"
      },
      {
        // grayの部分
        value : 100 - gon.compare['roa'],
        color : "#eee"
      }
    ];
    var ctx = document.getElementById("canvas--roa__compare").getContext("2d");
    new Chart(ctx).Doughnut(roa_data,{
      segmentShowStroke : false,
      segmentStrokeColor : "#fff",
      segmentStrokeWidth : 1,
      percentageInnerCutout : 80, // **** Border width
      animation : true,
      animationSteps : 100,
      animationEasing : "easeOutBounce",
      animateRotate : true,
      animateScale : false,
      onAnimationComplete : null
    });
  });

  $(function() {
    var roa_data = [
      {
        value: gon.compare['roe'],
        color:"#57bede"
      },
      {
        // grayの部分
        value : 100 - gon.compare['roe'],
        color : "#eee"
      }
    ];
    var ctx = document.getElementById("canvas--roe__compare").getContext("2d");
    new Chart(ctx).Doughnut(roa_data,{
      segmentShowStroke : false,
      segmentStrokeColor : "#fff",
      segmentStrokeWidth : 1,
      percentageInnerCutout : 80, // **** Border width
      animation : true,
      animationSteps : 100,
      animationEasing : "easeOutBounce",
      animateRotate : true,
      animateScale : false,
      onAnimationComplete : null
    });
  });

  $(function() {
    var roa_data = [
      {
        value: gon.compare['operating_profit_margin'],
        color:"#57bede"
      },
      {
        // grayの部分
        value : 100 - gon.compare['operating_profit_margin'],
        color : "#eee"
      }
    ];
    var ctx = document.getElementById("canvas--operating-profit-margin__compare").getContext("2d");
    new Chart(ctx).Doughnut(roa_data,{
      segmentShowStroke : false,
      segmentStrokeColor : "#fff",
      segmentStrokeWidth : 1,
      percentageInnerCutout : 80, // **** Border width
      animation : true,
      animationSteps : 100,
      animationEasing : "easeOutBounce",
      animateRotate : true,
      animateScale : false,
      onAnimationComplete : null
    });
  });
}
