data = {
        labels : ["","","","","","","","","",""],
        datasets : [
                #デフォルトで表示するグラフ（その企業の業績）
                {
                        fillColor : "rgba(0,0,0,0)",
                        strokeColor : "1a243f", # グラフの線の色
                        pointColor : "#1a243f",
                        pointStrokeColor : "#fff",
                        data : [10,20,30,40,70,100,30,40,100,20]
                },
                #業界平均のグラフ
                {
                        fillColor : "rgba(0,0,0,0)",# グラフ面積の色
                        strokeColor : "#ffd800", # グラフの線の色
                        pointColor : "#ffd800",
                        pointStrokeColor : "#fff",
                        data : [40,29,21,30,15,200,300,400,200,250]
                },
                #my_companyのグラフ
                {
                        fillColor : "rgba(0,0,0,0)",
                        strokeColor : "#ea005a", # グラフの線の色
                        pointColor : "#ea005a",
                        pointStrokeColor : "#fff",
                        data : [100,100,110,115,80,50,100,120,130,200]
                }
        ]
}
ctx = document.getElementById("DemoLineChart").getContext("2d")
hoge = new Chart(ctx).Line(data,{
        scaleOverlay : false,
        scaleOverride : true,
        scaleSteps : 3,
        scaleStepWidth : 100,
        scaleStartValue : null,
        scaleLineColor : "#ccc",
        scaleLineWidth : 1,
        scaleShowLabels : false,
        scaleLabel : "<%=value%>",
        scaleFontFamily : "'Futura', 'hiragino mincho pro'",
        scaleFontSize : 11,
        scaleFontStyle : "normal",
        scaleFontColor : "#111",
        scaleShowGridLines : false,
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
