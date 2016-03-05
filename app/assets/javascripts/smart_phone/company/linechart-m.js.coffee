$ ->
  if PS.LOCALE == "ja"
    rate = 1
  else
    rate = 120

  getAchievements = (basis)->
    labels = []
    scores = []
    _.each( gon.achievement, (value) =>
      labels.push value.publish_day
      scores.push value["#{basis}"]/rate
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
    adjustFrame()
    PS.graph.lineChart(document.getElementById("Company_#{basis}").getContext("2d"), lineChartData)

  adjustFrame = ->
    $('.js-linechart > canvas').attr('width', $(document).width()+"px")
    $('.js-linechart > canvas').attr('height', $(document).width()/2+"px")

  getAchievements("sale")
  getAchievements("operating_profit")
  getAchievements("ordinary_profit")
  getAchievements("net_income")
