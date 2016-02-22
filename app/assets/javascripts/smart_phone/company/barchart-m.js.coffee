$ ->
  $ctx = document.getElementById("myChart").getContext("2d")

  data = null
  lastCount = (gon.achievement.length) - 1

  drawCompanyGraph = ->
    barChartData = {
      labels : ["売上高","営業利益","経常利益","当期利益"],
      datasets : [
        {
          fillColor: "#1a243f",
          strokeColor: "#fff",
          data: [
            gon.achievement[lastCount]['sale'],
            gon.achievement[lastCount]['operating_profit'],
            gon.achievement[lastCount]['ordinary_profit'],
            gon.achievement[lastCount]['net_income']
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
            result.resources['avg_sale'],
            result.resources['avg_operating_profit'],
            result.resources['avg_ordinary_profit'],
            result.resources['avg_net_income']
          ]
        }
      ]
    }
    drawCompanyGraph()
  )
