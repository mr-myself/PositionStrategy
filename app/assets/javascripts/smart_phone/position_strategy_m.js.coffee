class PositionStrategyMobile
  @util = {
  }

  @graph = {
    barChart: (ctx, data) ->
      new Chart(ctx).Bar(data,{
        scalestartvalue : 0,
        scaleoverlay : false,
        scaleoverride : true,
        scalesteps : 2,
        scalestepwidth : 100,
        scalelinecolor : "rgba(0,0,0,.1)",
        scalelinewidth : 1,
        scaleshowlabels : true,
        scalelabel : "<%=parseInt(value).toLocaleString()%>",
        scalefontsize : 6,
        scalefontstyle : "normal",
        scalefontcolor : "#000",
        scaleshowgridlines : false,
        scalegridlinecolor : "#fff",
        scalegridlinewidth : 1,
        barshowstroke : true,
        barstrokewidth : 1,
        barvaluespacing : 100,#グラフ間の幅の設定
        bardatasetspacing : 0,
        animation : true,
        animationsteps : 60,
        animationeasing : "easeoutquart",
        onanimationcomplete : null
      })

    lineChart: (ctx, data) ->
      new Chart(ctx).Line(data,{
        scaleStartValue : 0,
        scaleoverlay : false,
        scaleoverride : true,
        scaleSteps : 3,
        scaleStepWidth : 100,
        scaleStartValue : 0,
        scaleLineColor : "#ccc",
        scaleLineWidth : 1,
        scaleShowLabels : true,
        scaleLabel : "<%=parseInt(value).toLocaleString()%>",
        scaleFontSize : 11,
        scaleFontStyle : "normal",
        scaleShowGridLines : true,
        scaleGridLineColor : "#ddd",
        scaleGridLineWidth : 1,
        bezierCurve : false,
        pointDot : true,
        pointDotRadius : 6,
        pointDotStrokeWidth : 0,
        datasetStroke : true,
        datasetStrokeWidth : 3,
        datasetFill : true,
        animation : true,
        animationSteps : 60,
        animationEasing : "easeOutQuart",
        onAnimationComplete : null
      })
  }

@PSM = PositionStrategyMobile
