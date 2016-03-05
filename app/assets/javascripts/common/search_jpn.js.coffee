$ ->
  secondSuggest = (company_names) ->
    new Suggest.Local(
      "second_suggest_form",
      "second_suggest",
      company_names,
      {dispMax: 10, interval: 500, highlight: true, dispAllKey: true}
    )

  profileSuggest = (company_names) ->
    new Suggest.Local(
      "belong_suggest_form",
      "belong_suggest",
      company_names,
      {dispMax: 10, interval: 500, highlight: true, dispAllKey: true}
    )

  startSuggest = (company_names) ->
    new Suggest.Local(
      "suggest_form",
      "suggest",
      company_names,
      {dispMax: 10, interval: 500, highlight: true, dispAllKey: true}
    )

  prepareSuggest = (company_names) ->
    startSuggest(company_names)
    secondSuggest(company_names)
    profileSuggest(company_names)

  $.get('/search/jpn_company_names', null, (data) ->
    if window.addEventListener
      window.addEventListener('load', prepareSuggest(data.resources), false)
    else
      window.attachEvent('onload', prepareSuggest(data.resources))
  )
