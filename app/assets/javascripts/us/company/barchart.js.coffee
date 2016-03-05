$ ->
  $ctx = document.getElementById("myChart").getContext("2d")

  barChartData = null
  data = null

  if PS.LOCALE == "ja"
    rate = 120
    labelName = ["売上高", "営業利益", "当期利益"]
  else
    rate = 1
    labelName = ["Sale", "Operating Profit", "Net Income"]

  if gon.average
    data = {
      datasets : [
        #業界平均のグラフ
        {
          fillColor: "#ffd800",
          strokeColor: "#fff",
          data : [
            gon.average['sale']/1000000*rate,
            gon.average['operating_profit']/1000000*rate,
            gon.average['net_income']/1000000*rate
          ]
        }
      ]
    }

  drawCompanyGraph = ->
    achievementLastCount = gon.company_repository.achievements.length - 1
    scores = [
      gon.company_repository.achievements[achievementLastCount]['sale']/1000000*rate,
      gon.company_repository.achievements[achievementLastCount]['operating_profit']/1000000*rate,
      gon.company_repository.achievements[achievementLastCount]['net_income']/1000000*rate
    ]
    barChartData = {
      labels : labelName,
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
          gon.compare['sale']/1000000*rate,
          gon.compare['operating_profit']/1000000*rate,
          gon.compare['net_income']/1000000*rate
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
