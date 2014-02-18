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

$(document).ready ->
  $("nav.navbar .navbar-collapse ul.nav li[rel='" + $.trim($(".activeTab").text()) + "']").addClass "active"
  hideFlash()
  $("form").submit ->
    $(this).find("errorSpan").remove()
  $("form input, form select").focus ->
    if $(this).hasClass("hasError")
      $(this).removeClass "hasError"
      $(this).next(".errorSpan").hide 500