#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require common
#= require datepicker
#= require turbolinks

$(document).on "page:change", ->
  # Page Reload JS
  $(document).off "page:fetch"
  $(document).on "page:fetch", ->
    $(".pageSpinner").show()
  $(document).on "page:receive", ->
    $(".pageSpinner").hide()

  # Datepicker Code
  if $(".datepicker").length isnt 0
    $(".datepicker").datepicker
      format: "dd-M-yyyy"
      endDate: "+0d"
      autoclose: true
      todayHighlight: true