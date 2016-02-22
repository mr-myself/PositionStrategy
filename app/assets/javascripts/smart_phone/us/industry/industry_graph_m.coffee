$ ->
  drawChart = (values, basis) ->
    scores = []
    _.each( values, (value) =>
      scores.push value["#{basis}"] * 100 / 1000000
    )
    barChartData = {
      labels: ['1', '2', '3', '4', '5'],
      datasets: [
        fillColor: "#1a243f",
        strokeColor: "#fff",
        data: scores
      ]
    }
    PS.graph.barChart(document.getElementById("Industry_#{basis}").getContext("2d"), barChartData)

  drawChart(gon.average_sale, "sale")
  drawChart(gon.average_operating_profit, "operating_profit")
  drawChart(gon.average_net_income, "net_income")
  $(".js-barchart-unit").text("（百万円）")
