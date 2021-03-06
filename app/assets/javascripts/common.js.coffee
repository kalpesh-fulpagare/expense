#= require jquery.validate.min
#= require jquery.validate.additional-methods
#= require nanobar.min
root = exports ? this
flashTimer = undefined
root.months =
  0: "Jan"
  1: "Feb"
  2: "Mar"
  3: "Apr"
  4: "May"
  5: "June"
  6: "July"
  7: "Aug"
  8: "Sept"
  9: "Oct"
  10: "Nov"
  11: "Dec"

root.days =
  1: "Mon"
  2: "Tue"
  3: "Wed"
  4: "Thu"
  5: "Fri"
  6: "Sat"
  0: "Sun"
root.toggleDoms = (show, hide) ->
  show.show()
  hide.hide()

root.displayFlash = (message, type) ->
  flash = "<div class='alert fade in " + type + "'><button data-dismiss='alert' class='close'>×</button>"
  flash += message + "</div>"
  $("div.alert").remove()
  $("#contentBody").prepend flash
  hideFlash()

root.hideFlash = ->
  clearTimeout flashTimer
  flashTimer = setTimeout(->
    $(".alert").remove()  unless $(".alert").hasClass("alert-danger") or $(".alert").hasClass("alert-info")
  , 6000)

root.humanize = (txt) ->
  newText = txt.charAt(0).toUpperCase() + txt.slice(1).toLowerCase()
  newText = newText.replace(/_/g, " ")
  newText

root.displayErrors = (jsonErrorHash, resourceName) ->
  $(".errorSpan").remove()
  errors = JSON.parse(jsonErrorHash)
  $.each errors, (attr, error_array) ->
    $.each error_array, (index, error) ->
      error_array[index] = humanize(attr) + " " + error

    errorString = error_array.join(", ")
    errorDom = "<span class='errorSpan help-block'>" + errorString + "</span>"
    name = resourceName + "[" + attr + "]"
    el = $("[name^='" + name + "']")
    if el.prop("type") is "radio" or el.prop("type") is "checkbox"
      el.parents(".input-group:first").append errorDom
    else
      $(errorDom).insertAfter el
      el.addClass "hasError"

  $("html,body").animate
    scrollTop: $(".errorSpan:visible").offset().top - 50
  , "slow"

root.validateForms = ->
  $("form.validate:not([novalidate])").each ->
    formValidations =
      errorElement: "span"
      errorClass: "text-danger"
      rules: {}
      messages: {}

    $(this).find("input, select, textarea").each ->
      formValidations["rules"][$(this).attr("name")] = $(this).data("rules")  if $(this).data("rules") isnt `undefined`
      formValidations["messages"][$(this).attr("name")] = $(this).data("messages")  if $(this).data("messages") isnt `undefined`
      return

    $(this).validate formValidations
    return

  return

# Nanobar Code start
intr = null
perc = 0
nanobar = null
options =
  bg: "#3071a9"
  target: document.getElementById("nanoBarHolder")
  id: "nanoBar"

$(document).on "ready page:load", ->
  nanobar = new Nanobar(options)
  return

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
# Nanobar Code End

$(document).on "page:change", ->
  $("nav.navbar .navbar-collapse ul.nav li[rel='" + $.trim($(".activeTab").text()) + "']").addClass "active"
  hideFlash()
  validateForms()
  $("form").submit ->
    $(this).find("errorSpan").remove()
  $("form input, form select").focus ->
    if $(this).hasClass("hasError")
      $(this).removeClass "hasError"
      $(this).next(".errorSpan").hide 500
  # Datepicker Code
  if $(".datepicker").length isnt 0
    $(".datepicker").datepicker
      format: "dd-M-yyyy"
      endDate: "+0d"
      autoclose: true
      todayHighlight: true