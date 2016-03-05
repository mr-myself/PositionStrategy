$ ->
  $ctx = document.getElementById("myChart").getContext("2d")
  if PS.LOCALE == "ja"
    rate = 120
  else
    rate = 1

  data = {
    datasets : [
      #業界平均のグラフ
      {
        fillColor: "#ffd800",
        strokeColor: "#fff",
        data : [
          gon.average['sale']/1000000*rate,
          gon.average['operating_profit']/1000000*rate,
          gon.average['net_income']/1000000*rate
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
            gon.company_repository.achievements[lastAchievementCount]['sale']/1000000*rate,
            gon.company_repository.achievements[lastAchievementCount]['operating_profit']/1000000*rate,
            gon.company_repository.achievements[lastAchievementCount]['net_income']/1000000*rate
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

  adjustFrame = ->
    $('.js-barchart > canvas').attr('width', $(document).width()+"px")
    $('.js-barchart > canvas').attr('height', $(document).width()/2+"px")

  adjustFrame()
  drawCompanyGraph()
