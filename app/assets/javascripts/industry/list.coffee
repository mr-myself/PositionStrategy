$ ->
  do ->
    $(document).ready( ->
      $('#next-rank').BlocksIt({
        numOfCol: 2,
        offsetX: 0,
        offsetY: 12,
        blockElement: '.grid'
      })
    )

    currentWidth = 940
    $(window).resize( ->
      winWidth = $(window).width()
      conWidth = null
      if winWidth < 940
        conWidth = 700
        col = 1
      else
        conWidth = 940
        col = 2

      if conWidth != currentWidth
        currentWidth = conWidth
        $('#next-rank').width(conWidth)
        $('#next-rank').BlocksIt({
          numOfCol: col,
          offsetX: 0,
          offsetY: 12
        })
    )

    $(document).ready( ->
      $('#list-wrapping').BlocksIt({
        numOfCol: 4,
        offsetX: 0,
        offsetY: 12,
        blockElement: '.grid'
      })
    )

    currentWidth = 940
    $(window).resize( ->
      winWidth = $(window).width()
      conWidth = null
      if winWidth < 940
        conWidth = 700
        col = 2
      else
        conWidth = 940
        col = 4

      if conWidth != currentWidth
        currentWidth = conWidth
        $('#list-wrapping').width(conWidth)
        $('#list-wrapping').BlocksIt({
          numOfCol: col,
          offsetX: 0,
          offsetY: 12
        })
    )
