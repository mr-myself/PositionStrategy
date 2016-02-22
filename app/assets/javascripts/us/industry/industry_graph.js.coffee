$ ->
  $ctx = document.getElementById("Industry").getContext("2d")

  data = {
    datasets : [
      #業界平均のグラフ
      {
        fillColor: "#ffd800",
        strokeColor: "#fff",
        data: [
          gon.industry_average['sale'] * 100 / 1000000,
          gon.industry_average['sale'] * 100 / 1000000,
          gon.industry_average['sale'] * 100 / 1000000,
          gon.industry_average['sale'] * 100 / 1000000,
          gon.industry_average['sale'] * 100 / 1000000,
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
    if name.length > 16
      name.substr(0, 16) + '...'
    else
      name

  adjustFrame = ->
    $('.chart > canvas').attr('width', '1140')
    $('.chart > canvas').attr('height', '300')

  drawChart = (basis) ->
    adjustFrame()
    $.getJSON("/us/industries/#{PS.INDUSTRY_ID}/#{basis}/ranking",
      (values)=>
        labels = []
        scores = []
        _.each( values, (value) =>
          labels.push shortenName(value.name)
          scores.push value["#{basis}"] * 100 / 1000000
        )
        barChartData = {
          labels: labels,
          datasets: [
            fillColor: "#1a243f",
            strokeColor: "#fff",
            data: scores,
          ]
        }
        PS.graph.barChart($ctx, barChartData)
    )

  changeAverage = (basis) ->
    $(".company-graph button").removeClass("on")
    removeClass()
    $(".js-#{basis}").addClass("active")
    avg = gon.industry_average["#{basis}"] * 100 / 1000000
    data.datasets[0].data = [avg, avg, avg, avg, avg]

  removeClass = ->
    $(".js-sale").removeClass("active")
    $(".js-operating_profit").removeClass("active")
    $(".js-net_income").removeClass("active")
    $(".js-market_value").removeClass("active")

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
