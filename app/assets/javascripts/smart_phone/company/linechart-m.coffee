$ ->
  getAchievements = (basis)->
    labels = []
    scores = []
    _.each( gon.achievement, (value) =>
      labels.push value.publish_day
      scores.push value["#{basis}"]
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
  getAchievements("sale")
  getAchievements("operating_profit")
  getAchievements("ordinary_profit")
  getAchievements("net_income")
