$ ->
  $ctx = document.getElementById("myChart").getContext("2d")

  barChartData = null
  data = null

  if gon.average
    data = {
      datasets : [
        #業界平均のグラフ
        {
          fillColor: "#ffd800",
          strokeColor: "#fff",
          data : [
            gon.average['sale'],
            gon.average['operating_profit'],
            gon.average['net_income']
          ]
        }
      ]
    }

  drawCompanyGraph = ->
    achievementLastCount = gon.company_repository.achievements.length - 1
    scores = [
      gon.company_repository.achievements[achievementLastCount]['sale'],
      gon.company_repository.achievements[achievementLastCount]['operating_profit'],
      gon.company_repository.achievements[achievementLastCount]['net_income']
    ]
    barChartData = {
      labels : ["売上高","営業利益","当期利益"],
      datasets : [
        {
          fillColor: "#1a243f",
          strokeColor: "#fff",
          data: scores,
        }
      ]
    }

    if gon.compare
      barChartData.datasets.push {
        fillColor: "#57bede",
        strokeColor: "#fff",
        data : [
          gon.compare['sale'],
          gon.compare['operating_profit'],
          gon.compare['net_income']
        ]
      }
    adjustFrame()
    PS.graph.barChart($ctx, barChartData)

  adjustFrame = ->
    $('.js-barchart > canvas').attr('width', '825')
    $('.js-barchart > canvas').attr('height', '300')

  drawCompanyGraph()
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
    adjustFrame()
    PS.graph.barChart($ctx, barChartData)
  )
