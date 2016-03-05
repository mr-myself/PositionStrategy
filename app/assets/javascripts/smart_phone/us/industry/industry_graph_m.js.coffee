$ ->
  if PS.LOCALE == "ja"
    rate = 120
    million = "（百万円）"
  else
    rate = 1
    million = "(million)"

  drawChart = (values, basis) ->
    scores = []
    _.each( values, (value) =>
      scores.push value["#{basis}"]/1000000*rate
    )
    barChartData = {
      labels: ['1', '2', '3', '4', '5'],
      datasets: [
        fillColor: "#1a243f",
        strokeColor: "#fff",
        data: scores
      ]
    }
    adjustFrame()
    PS.graph.barChart(document.getElementById("Industry_#{basis}").getContext("2d"), barChartData)

  adjustFrame = ->
    $('.js-barchart > canvas').attr('width', $(document).width()+"px")
    $('.js-barchart > canvas').attr('height', $(document).width()/2+"px")
    $('.company-graph .graph-grid').attr('style', 'height:'+($(document).width()/2 + 85) + "px")
    $('.company-graph .graph-grid-top').attr('style', 'height:'+($(document).width()/2 + 40) + "px")

  drawChart(gon.average_sale, "sale")
  drawChart(gon.average_operating_profit, "operating_profit")
  drawChart(gon.average_net_income, "net_income")
  $(".js-barchart-unit").text(million)
