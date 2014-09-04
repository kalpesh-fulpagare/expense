#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require common.js
#= require filter.js
#= require turbolinks
#= require datepicker
#= require nanobar.min
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

addExpenses = (exp_json) ->
  console.log("called")
  $("#expensesTable").find("tr").not(".thHeads").remove()
  table_data = ""
  category_name = undefined
  dt = undefined
  cost = 0
  resource = $(".pageData")
  $.each exp_json, (index, e) ->
    table_data += "<tr>"
    table_data += "<td><a href='/#{resource.data('page')}/" + e.id + "'>" + e.id + "</a></td>"
    table_data += "<td>" + e.title + "</td>"
    table_data += "<td>" + e.description.replace(/\r\n/g, "<br>") + "</td>"
    table_data += "<td>" + categories_json[e.category_id][0].name + "</td>"
    cost += parseInt(e.cost)
    dt = new Date(e.date.replace(/-/g, "/"))
    table_data += "<td>" + dt.getDate() + " " + months[dt.getMonth()] + ", " + dt.getFullYear() + "</td>"
    if resource.data('page') is "expenses" or resource.data('user') is "true"
      table_data += "<td>" + users_json[e.user_id][0].first_name + " " + users_json[e.user_id][0].last_name + "</td>"
    table_data += "<td class='text-right'>" + e.cost + "</td>"
    if resource.data('user') isnt undefined
      table_data += "<td><a class='btn btn-default' href='/#{resource.data('page')}/#{e.id}/edit'>Edit</a></td>"
    table_data += "<tr>"
  if resource.data('user') is undefined
    table_data += "<tr><td class='warning text-right' colspan='#{if resource.data('page') is 'expenses' then 6 else 5}'>Total Cost</td><td class='success text-right'>" + cost + "</td></tr>"
  $("#expenseTotal").html "Total: <strong>" + cost + "</strong>"
  $("#expensesTable").append table_data

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
      startDate: "-30d"
      autoclose: true
      todayHighlight: true

  # Expense JS
  if $("#expensesTable").length isnt 0
    addExpenses expenses_json
    $(".sidebar-nav input[type='checkbox']").click ->
      panel = $(this).parents(".panel:first")
      if $(this).val() is "All"
        panel.find("input[type='checkbox']").not(".all").attr "checked", false
      else panel.find("input:checkbox.all").prop "checked", false  unless panel.find("input[type='checkbox']:checked").length is 0
      filtered_json = filterRecords(expenses_json)
      addExpenses filtered_json
