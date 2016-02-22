$ ->

  _.each( ['sale', 'operating_profit', 'net_income'], (basis) =>
    labels = []
    scores = []
    _.each( gon.company_repository.achievements, (value) =>
      labels.push value.publish_day
      scores.push value["#{basis}"] * 100 / 1000000
    )
    lineChartData = {
      labels : labels,
      datasets : [
        {
          fillColor : "rgba(0,0,0,0)",
          strokeColor : "1a243f", # グラフの線の色
          pointColor : "#1a243f",
          pointStrokeColor : "#fff",
          data : scores
        }
      ]
    }
    PS.graph.lineChart(document.getElementById("Company_#{basis}").getContext("2d"), lineChartData)
  )
