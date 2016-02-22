$ ->
  $ctx = document.getElementById("myChart").getContext("2d")

  data = {
    datasets : [
      #業界平均のグラフ
      {
        fillColor: "#ffd800",
        strokeColor: "#fff",
        data : [
          gon.average['sale'] * 100 / 1000000,
          gon.average['operating_profit'] * 100 / 1000000,
          gon.average['net_income'] * 100 / 1000000
        ]
      }
    ]
  }

  drawCompanyGraph = ->
    lastAchievementCount = gon.company_repository.achievements.length-1
    barChartData = {
      labels : ["売上高","営業利益","当期利益"],
      datasets : [
        {
          fillColor: "#1a243f",
          strokeColor: "#fff",
          data: [
            gon.company_repository.achievements[lastAchievementCount]['sale'] * 100 / 1000000,
            gon.company_repository.achievements[lastAchievementCount]['operating_profit'] * 100 / 1000000,
            gon.company_repository.achievements[lastAchievementCount]['net_income'] * 100 / 1000000
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

  drawCompanyGraph()
