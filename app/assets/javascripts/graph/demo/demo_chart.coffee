# ページ最上部のグラフ
top_data = {
  labels : ["","","","","",""],
  datasets : [
    {
      fillColor: "#1a243f",
      strokeColor: "#fff",
      data: [70,150,200,500,800,4000]
    },
    {
      fillColor: "#57bede",
      strokeColor: "#fff",
      data: [100,180,350,600,1900,5000]
    }
  ]
}
$ctx = document.getElementById("DemoChart").getContext("2d")
new Chart($ctx).Bar(top_data,{
        scaleStartValue : 0, #これでX軸のY座標を決定
        scaleOverLay : false, #棒グラフにもグリッドを表示させるか
        scaleoverride : true,
        scalesteps : 2,
        scalestepwidth : 100,
        scalelinecolor : false,
        scaleLineWidth : 0,
        scaleShowLabels : false,
        scalelabel : "<%=value%>",
        scalefontfamily : "'futura', 'hiragino mincho pro'",
        scalefontsize : 12,
        scalefontstyle : "normal",
        scalefontcolor : "#fff",
        scaleShowGridLines : true,
        scalegridlinecolor : "#fff",
        scalegridlinewidth : 10,
        barshowstroke : false,
        barstrokewidth : 1,
        barvaluespacing : 200,#グラフ間の幅の設定
        bardatasetspacing : 0,
        animation : true,
        animationsteps : 60,
        animationeasing : "easeoutquart",
        onanimationcomplete : null
})


# ページ最下部のグラフ
$ctx2 = document.getElementById("myChart").getContext("2d")
data = {
  datasets : [
    {
      fillColor: "#ffd800",
      strokeColor: "#fff",
      data: [4770,1050,2000,500]
    },
    {
      fillColor: "#ea005a",
      strokeColor: "#fff",
      data: [6100,1080,3500,2600]
    }
  ]
}
barChartData = {
  labels : ["売上高","営業利益","経常利益","純利益"],
  datasets : [
    {
      fillColor: "#1a243f",
      strokeColor: "#fff",
      data: [3770,2000,1700,700]
    }
  ]
}
PS.graph.barChart($ctx2, barChartData)


order = [2]
$(".company-bar-graph button").on("click", ->
  if $(this).hasClass("on")
    $(this).removeClass("on")
    for i in [0..order.length]
      if $(".company-bar-graph button").index(this) is order[i]
        barChartData.datasets.splice(i,1)
        order.splice(i,1)
  else
    $(this).addClass("on")
    order.push $(".company-bar-graph button").index(this)
    barChartData.datasets.push data.datasets[$(".company-bar-graph button").index(this)]
  PS.graph.barChart($ctx2, barChartData)
)
