#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require common
#= require datepicker
#= require turbolinks
#= require nanobar.min

intr = null
perc = 0
nanobar = null
options =
  bg: "#3071a9"
  # leave target blank for global nanobar
  target: document.getElementById("nanoBarHolder")
  # id for new nanobar
  id: "nanoBar"

$(document).on "ready page:load", ->
  nanobar = new Nanobar(options)
  return

$(document).on "page:change", ->
  # Page Reload JS
  $(document).off "page:fetch"
  $(document).on "page:fetch", ->
    clearInterval intr
    intr = setInterval(->
      if perc == 100
        $(".pageSpinner").show()
      else
        perc += 5
        nanobar.go perc
      return
    , 70)
  $(document).on "page:receive", ->
    clearInterval intr
    $(".pageSpinner").hide()
    nanobar.go 100
    perc = 0

  # Datepicker Code
  if $(".datepicker").length isnt 0
    $(".datepicker").datepicker
      format: "dd-M-yyyy"
      endDate: "+0d"
      autoclose: true
      todayHighlight: true