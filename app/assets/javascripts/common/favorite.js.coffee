$ ->

  $(".favorite").on("click", ->
    $success = $(".favorite_message > .success")
    $error = $(".favorite_message > .error")
    $add = $(".favorite.add")
    $heart = $(".js-heart")
    $remove = $(".favorite.remove")

    $.ajax(
      url: "/jpn/companies/favorite",
      method: "POST",
      data: { "company_number": $(".favorite").attr("data-id") },
      success: (data) ->
        if data.success
          if data.success is "add"
            $add.hide()
            $remove.show()
            $heart.show()
            $success.show().text("お気に入りに追加しました")
          else
            $remove.hide()
            $add.show()
            $heart.hide()
            $success.show().text("お気に入りから削除しました")
        else
          $error.show().text("お気に入りは5社までとなっております")

      error:(data) =>
        $error.show().text("Internal Server Error")
    )
  )
