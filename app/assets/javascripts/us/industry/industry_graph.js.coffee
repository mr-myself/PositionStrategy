$ ->
  $ctx = document.getElementById("Industry").getContext("2d")
  if PS.LOCALE == "ja"
    rate = 120
    million = "（百万円）"
  else
    rate = 1
    million = "(million)"

  data = {
    datasets : [
      #業界平均のグラフ
      {
        fillColor: "#ffd800",
        strokeColor: "#fff",
        data: [
          gon.industry_average['sale']/1000000*rate,
          gon.industry_average['sale']/1000000*rate,
          gon.industry_average['sale']/1000000*rate,
          gon.industry_average['sale']/1000000*rate,
          gon.industry_average['sale']/1000000*rate,
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
          scores.push value["#{basis}"]/1000000*rate
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
    avg = gon.industry_average["#{basis}"]/1000000*rate
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
    $(".js-barchart-unit").text(million)
  )

  $(".js-operating_profit").on("click", ->
    drawChart("operating_profit")
    changeAverage("operating_profit")
    $(".js-barchart-unit").text(million)
  )

  $(".js-net_income").on("click", ->
    drawChart("net_income")
    changeAverage("net_income")
    $(".js-barchart-unit").text(million)
  )

  # 初期グラフ描画
  drawChart("sale")
  $(".js-sale").addClass("active")
  $(".js-barchart-unit").text(million)
