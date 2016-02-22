$ ->
  data = {
    datasets : [
      {
        fillColor: "#ea005a",
        strokeColor: "#fff",
        data : []
      }
    ]
  }

  if gon.my_company
    lastAchievementCount = gon.my_company.achievements.length - 1
    data.datasets[0].data = [
      gon.my_company.achievements[lastAchievementCount]['sale'],
      gon.my_company.achievements[lastAchievementCount]['operating_profit'],
      gon.my_company.achievements[lastAchievementCount]['ordinary_profit'],
      gon.my_company.achievements[lastAchievementCount]['net_income']
    ]
  favoriteCompaniesData = []

  count = gon.favorite_companies.length
  for i in [1..count]
    favoriteCompaniesData.push {
      labels : ["売上高","営業利益","経常利益","純利益"],
      datasets : [
        {
          fillColor: "#1a243f",
          strokeColor: "#fff",
          data: []
        }
      ]
    }

  adjustFavoriteFrame = (number) ->
    canvasIdentify = '.js-favorite-barchart' + number + ' > canvas'
    $(canvasIdentify).attr('width', '940')
    $(canvasIdentify).attr('height', '300')

  i = 0
  _.each( gon.favorite_companies, (company) ->
    favoriteCompaniesData[i].datasets[0].data = [
      company.sale,
      company.operating_profit,
      company.ordinary_profit,
      company.net_income,
    ]
    $ctx = document.getElementById("MyPageFavorite#{i+1}").getContext("2d")
    adjustFavoriteFrame(i+1)
    PS.graph.barChart($ctx, favoriteCompaniesData[i])
    i += 1
  )

  $(".company-favorite-graph button").on("click", (target) ->
    $this_id = $(target)[0].currentTarget.value
    $ctx = document.getElementById("MyPageFavorite#{$this_id}").getContext("2d")
    if $(this).hasClass("on")
      $(this).removeClass("on")
      favoriteCompaniesData[$this_id-1].datasets.splice(1,1)
    else
      $(this).addClass("on")
      favoriteCompaniesData[$this_id-1].datasets.push data.datasets[0]
    adjustFavoriteFrame($this_id)
    PS.graph.barChart($ctx, favoriteCompaniesData[$this_id-1])
  )
