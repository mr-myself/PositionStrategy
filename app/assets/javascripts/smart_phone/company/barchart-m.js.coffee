$ ->
  $ctx = document.getElementById("myChart").getContext("2d")
  if PS.LOCALE == "ja"
    rate = 1
    labelName = ["売上高", "営業利益", "経常利益", "当期利益"]
  else
    rate = 120
    labelName = ["Sale", "Operating", "Ordinary", "NetIncome"]

  data = null
  lastCount = (gon.achievement.length) - 1

  drawCompanyGraph = ->
    barChartData = {
      labels : labelName,
      datasets : [
        {
          fillColor: "#1a243f",
          strokeColor: "#fff",
          data: [
            gon.achievement[lastCount]['sale']/rate,
            gon.achievement[lastCount]['operating_profit']/rate,
            gon.achievement[lastCount]['ordinary_profit']/rate,
            gon.achievement[lastCount]['net_income']/rate
          ]
        },
        {
          fillColor: "#ffd800",
          strokeColor: "#fff",
          data: data.datasets[0].data
        }
      ]
    }
    PS.graph.barChart($ctx, barChartData)

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
    adjustFrame()
    drawCompanyGraph()
  )

  adjustFrame = ->
    $('.js-barchart > canvas').attr('width', $(document).width()+"px")
    $('.js-barchart > canvas').attr('height', $(document).width()/2+"px")
