$ ->
  startSuggest = (company_names) ->
    new Suggest.Local(
      "suggest_form",
      "suggest",
      company_names,
      {dispMax: 10, interval: 500, highlight: true, dispAllKey: true}
    )

  mobileSuggest = (company_names) ->
    new Suggest.Local(
      "mobile_suggest_form",
      "mobile_suggest",
      company_names,
      {dispMax: 10, interval: 500, highlight: true, dispAllKey: true}
    )

  prepareSuggest = (company_names) ->
    startSuggest(company_names)
    mobileSuggest(company_names)

  $.get('/search/all_company_names', null, (data) ->
    if window.addEventListener
      window.addEventListener('load', prepareSuggest(data.resources), false)
    else
      window.attachEvent('onload', prepareSuggest(data.resources))
  )
