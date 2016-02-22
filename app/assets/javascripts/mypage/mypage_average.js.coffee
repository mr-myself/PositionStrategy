$ ->
  $ctx = null

  if gon.average
    data = {
      datasets : [
        #業界平均のグラフ
        {
          fillColor: "#ffd800",
          strokeColor: "#fff",
          data : [
            gon.average['avg_sale'],
            gon.average['avg_operating_profit'],
            gon.average['avg_ordinary_profit'],
            gon.average['avg_net_income']
          ]
        }
      ]
    }

  barChartData = {
    labels : ["売上高","営業利益","経常利益","純利益"],
    datasets : []
  }

  adjustFrame = ->
    $('.js-average-barchart > canvas').attr('width', '940')
    $('.js-average-barchart > canvas').attr('height', '300')

  if gon.my_company
    $ctx = document.getElementById("MyPageAverage").getContext("2d")
    lastAchievementCount = gon.my_company.achievements.length - 1
    adjustFrame()
    barChartData.datasets.push {
      fillColor: "#1a243f",
      strokeColor: "#fff",
      data: [
        gon.my_company.achievements[lastAchievementCount]['sale'],
        gon.my_company.achievements[lastAchievementCount]['operating_profit'],
        gon.my_company.achievements[lastAchievementCount]['ordinary_profit'],
        gon.my_company.achievements[lastAchievementCount]['net_income']
      ]
    }
    PS.graph.barChart($ctx, barChartData)

  order = [2]
  $(".company-graph button").on("click", ->
    adjustFrame()
    if($(this).hasClass("on"))
      $(this).removeClass("on")
      for i in [0..order.length]
        if $(".company-graph button").index(this) is order[i]
          barChartData.datasets.splice(i,1)
          order.splice(i,1)
    else
      $(this).addClass("on")
      order.push($(".company-graph button").index(this))
      barChartData.datasets.push data.datasets[$(".company-graph button").index(this)]
    PS.graph.barChart($ctx, barChartData)
  )
