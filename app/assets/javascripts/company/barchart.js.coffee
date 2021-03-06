$ ->
  $ctx = document.getElementById("myChart").getContext("2d")
  if PS.LOCALE == "ja"
    rate = 1
    labelName = ["売上高", "営業利益", "経常利益", "当期利益"]
  else
    rate = 120
    labelName = ["Sale", "Operating Profit", "Ordinary Profit", "Net Income"]

  barChartData = null
  data = null

  if !gon.compare
    $.get('/jpn/industries/' + PS.INDUSTRY_ID + '/annual_average', null, (result) ->
      data = {
        datasets : [
          #業界平均のグラフ
          {
            fillColor: "#ffd800",
            strokeColor: "#fff",
            data : [
              result.resources['avg_sale']/rate,
              result.resources['avg_operating_profit']/rate,
              result.resources['avg_ordinary_profit']/rate,
              result.resources['avg_net_income']/rate
            ]
          }
        ]
      }
      if gon.my_company
        lastCount = (gon.my_company.length)-1
        data.datasets.push {
          fillColor: "#ea005a",
          strokeColor: "#fff",
          data: [
            gon.my_company[lastCount]['sale']/rate,
            gon.my_company[lastCount]['operating_profit']/rate,
            gon.my_company[lastCount]['ordinary_profit']/rate,
            gon.my_company[lastCount]['net_income']/rate
          ]
        }
    )


  adjustFrame = ->
    $('.js-barchart > canvas').attr('width', '825')
    $('.js-barchart > canvas').attr('height', '300')

  drawCompanyGraph = ->
    lastCount = (gon.achievement.length)-1
    scores = [
      gon.achievement[lastCount]['sale']/rate,
      gon.achievement[lastCount]['operating_profit']/rate,
      gon.achievement[lastCount]['ordinary_profit']/rate,
      gon.achievement[lastCount]['net_income']/rate
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
          gon.compare['sale']/rate,
          gon.compare['operating_profit']/rate,
          gon.compare['ordinary_profit']/rate,
          gon.compare['net_income']/rate
        ]
      }

    adjustFrame()
    PS.graph.barChart($ctx, barChartData)

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
