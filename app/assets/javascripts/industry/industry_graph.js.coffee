$ ->
  $ctx = document.getElementById("Industry").getContext("2d")

  data = {
    datasets : [
      #業界平均のグラフ
      {
        fillColor: "#ffd800",
        strokeColor: "#fff",
        data: [
          gon.industry_average['avg_sale'],
          gon.industry_average['avg_operating_profit'],
          gon.industry_average['avg_ordinary_profit'],
          gon.industry_average['avg_net_income'],
          gon.industry_average['avg_market_value'],
          gon.industry_average['avg_employee'],
          gon.industry_average['avg_annual_income'],
          gon.industry_average['avg_age']
        ]
      }
    ]
  }
  barChartData = {
    labels : [],
    datasets : [
      {
        fillColor: "#1a243f",
        strokeColor: "#fff",
        data: []
      }
    ]
  }

  shortenName = (name) ->
    if name.length > 12
      name.substr(0, 12) + '...'
    else
      name

  drawChart = (basis) ->
    $('.chart > canvas').attr('width', '940')
    $('.chart > canvas').attr('height', '400')
    $.getJSON(
      "/jpn/industries/#{PS.INDUSTRY_ID}/#{basis}/ranking",
      (values)=>
        labels = []
        scores = []
        _.each( values, (value) =>
          labels.push shortenName(value.name)
          scores.push value["#{basis}"]
        )
        barChartData = {
          labels: labels,
          datasets: [
            fillColor: "#1a243f",
            strokeColor: "#fff",
            data: scores,
          ]
        }
        adjustFrame()
        PS.graph.barChart($ctx, barChartData)
    )

  changeAverage = (basis) ->
    $(".company-graph button").removeClass("on")
    removeClass()
    $(".js-#{basis}").addClass("active")
    avg = gon.industry_average["avg_#{basis}"]
    data.datasets[0].data = [avg, avg, avg, avg, avg]

  removeClass = ->
    $(".js-sale").removeClass("active")
    $(".js-operating_profit").removeClass("active")
    $(".js-ordinary_profit").removeClass("active")
    $(".js-net_income").removeClass("active")
    $(".js-market_value").removeClass("active")
    $(".js-employee").removeClass("active")
    $(".js-annual_income").removeClass("active")
    $(".js-age").removeClass("active")

  adjustFrame = ->
    $('.js-barchart > canvas').attr('width', '825')
    $('.js-barchart > canvas').attr('height', '300')

  $(".company-graph button").on("click", ->
    if $(this).hasClass("on")
      $(this).removeClass("on")
      barChartData.datasets.splice(1,1)
    else
      $(this).addClass("on")
      barChartData.datasets.push data.datasets[0]
    adjustFrame()
    PS.graph.barChart($ctx, barChartData)
  )

  $(".js-sale").on("click", ->
    drawChart("sale")
    changeAverage("sale")
    $(".js-barchart-unit").text("（百万円）")
  )

  $(".js-operating_profit").on("click", ->
    drawChart("operating_profit")
    changeAverage("operating_profit")
    $(".js-barchart-unit").text("（百万円）")
  )

  $(".js-ordinary_profit").on("click", ->
    drawChart("ordinary_profit")
    changeAverage("ordinary_profit")
    $(".js-barchart-unit").text("（百万円）")
  )

  $(".js-net_income").on("click", ->
    drawChart("net_income")
    changeAverage("net_income")
    $(".js-barchart-unit").text("（百万円）")
  )

  $(".js-market_value").on("click", ->
    drawChart("market_value")
    changeAverage("market_value")
    $(".js-barchart-unit").text("（百万円）")
  )

  $(".js-employee").on("click", ->
    drawChart("employee")
    changeAverage("employee")
    $(".js-barchart-unit").text(" （人）")
  )

  $(".js-annual_income").on("click", ->
    drawChart("annual_income")
    changeAverage("annual_income")
    $(".js-barchart-unit").text("（千円）")
  )

  $(".js-age").on("click", ->
    drawChart("age")
    changeAverage("age")
    $(".js-barchart-unit").text("（歳）")
  )

  # 初期グラフ描画
  drawChart("sale")
  $(".js-sale").addClass("active")
  $(".js-barchart-unit").text("（百万円）")
