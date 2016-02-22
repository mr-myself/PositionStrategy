$ ->
  $ctx = document.getElementById("myChart2").getContext("2d")

  data = {
    datasets : [
      #業界平均のグラフ
      {
        fillColor : "rgba(0,0,0,0)",# グラフ面積の色
        strokeColor : "#ffd800", # グラフの線の色
        pointColor : "#ffd800",
        pointStrokeColor : "#fff",
        data : []
      }
    ]
  }

  compare_data = null
  if gon.compare
    compare_data = {
      fillColor : "rgba(0,0,0,0)",
      strokeColor : "#57bede", # グラフの線の色
      pointColor : "#57bede",
      pointStrokeColor : "#fff",
      data : []
    }

  lineChartData = {
    labels : [],
    datasets : [
      {
        fillColor : "rgba(0,0,0,0)",
        strokeColor : "1a243f", # グラフの線の色
        pointColor : "#1a243f",
        pointStrokeColor : "#fff",
        data : []
      }
    ]
  }

  saleData = {
    labels : [], data: []
  }
  operatingProfitData = {
    labels : [], data: []
  }
  netIncomeData = {
    labels : [], data: []
  }

  adjustFrame = ->
    $('.js-linechart > canvas').attr('width', '825')
    $('.js-linechart > canvas').attr('height', '300')

  getAchievements = ->
    adjustFrame()
    $.getJSON(
      "/us/companies/#{PS.COMPANY_SYMBOL}/achievements",
      (values)=>
        _.each( values, (value) =>
          saleData.labels.push value.publish_day
          operatingProfitData.labels.push value.publish_day
          netIncomeData.labels.push value.publish_day

          saleData.data.push value.sale
          operatingProfitData.data.push value.operating_profit
          netIncomeData.data.push value.net_income
        )
        lineChartData.labels = saleData.labels
        lineChartData.datasets[0].data = saleData.data

        if compare_data
          lineChartData.datasets.push compare_data
        PS.graph.lineChart($ctx, lineChartData)
    )

  getAveragePeriod = (basis) ->
    $.getJSON(
      "/us/industries/#{gon.company_repository.company.sector_id}/#{basis}/each_year_averages",
      (values)=>
        data.datasets[0].data = values
    )

  getComparePeriod = (basis) ->
    compare_data.data = gon.compare_periods[basis]
    lineChartData.datasets[1] = compare_data

  order = [1]
  $(".company-line-graph button").on("click", ->
    if $(this).hasClass("on")
      $(this).removeClass("on")
      for i in [0..order.length]
        if $(".company-line-graph button").index(this) is order[i]
          lineChartData.datasets.splice(i,1)
          order.splice(i,1)
    else
      $(this).addClass("on")
      order.push $(".company-line-graph button").index(this)
      lineChartData.datasets.push data.datasets[$(".company-line-graph button").index(this)]
    adjustFrame()
    PS.graph.lineChart($ctx, lineChartData)
  )

  removeClass = ->
    $(".js-sale").removeClass("active")
    $(".js-operating_profit").removeClass("active")
    $(".js-net_income").removeClass("active")

  changeBasis = (basis) ->
    removeClass()
    $(".js-#{basis}").addClass("active")
    lineChartData.datasets.splice(1, 2)
    $(".company-line-graph button").removeClass("on")

    if gon.compare
      getComparePeriod("#{basis}")
    else
      getAveragePeriod("#{basis}")
      if gon.my_company
        getCompanyPeriod("#{basis}")

  $(".js-sale").on("click", ->
    lineChartData.labels = saleData.labels
    lineChartData.datasets[0].data = saleData.data
    changeBasis("sale")
    adjustFrame()
    PS.graph.lineChart($ctx, lineChartData)
  )

  $(".js-operating_profit").on("click", ->
    lineChartData.labels = operatingProfitData.labels
    lineChartData.datasets[0].data = operatingProfitData.data
    changeBasis("operating_profit")
    adjustFrame()
    PS.graph.lineChart($ctx, lineChartData)
  )

  $(".js-net_income").on("click", ->
    lineChartData.labels = netIncomeData.labels
    lineChartData.datasets[0].data = netIncomeData.data
    changeBasis("net_income")
    adjustFrame()
    PS.graph.lineChart($ctx, lineChartData)
  )


  if gon.compare
    getComparePeriod("sale")
  else
    getAveragePeriod("sale")
  getAchievements()
  $(".js-sale").addClass("active")
