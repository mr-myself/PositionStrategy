$ ->

  if PS.LOCALE == "ja"
    rate = 120
  else
    rate = 1

  adjustFrame = ->
    $('.js-linechart > canvas').attr('width', $(document).width()+"px")
    $('.js-linechart > canvas').attr('height', $(document).width()/2+"px")

  _.each( ['sale', 'operating_profit', 'net_income'], (basis) =>
    labels = []
    scores = []
    _.each( gon.company_repository.achievements, (value) =>
      labels.push value.publish_day
      scores.push value["#{basis}"]/1000000*rate
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
  )
