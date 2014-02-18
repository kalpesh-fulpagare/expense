#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require common.js
#= require filter.js
addExpenses = (exp_json) ->
  $("#expensesTable").find("tr").not(".thHeads").remove()
  table_data = ""
  category_name = undefined
  dt = undefined
  cost = 0
  $.each exp_json, (index, e) ->
    table_data += "<tr>"
    table_data += "<td><a href='/expenses/" + e.id + "'>" + e.id + "</a></td>"
    table_data += "<td>" + e.title + "</td>"
    table_data += "<td>" + e.description.replace(/\r\n/g, "<br>") + "</td>"
    table_data += "<td>" + categories_json[e.category_id][0].name + "</td>"
    table_data += "<td>" + users_json[e.user_id][0].first_name + " " + users_json[e.user_id][0].last_name + "</td>"
    cost += parseInt(e.cost)
    dt = new Date(e.date.replace(/-/g, "/"))
    table_data += "<td>" + dt.getDate() + " " + months[dt.getMonth()] + " (" + days[dt.getDay()] + ")" + ", " + dt.getFullYear() + "</td>"
    table_data += "<td class='text-right'>" + e.cost + "</td>"
    table_data += "<tr>"

  table_data += "<tr><td class='warning text-right' colspan='6'>Total Cost</td><td class='success text-right'>" + cost + "</td></tr>"
  $("#expenseTotal").html "Total: <strong>" + cost + "</strong>"
  $("#expensesTable").append table_data

$(document).ready ->
  addExpenses expenses_json
  $(".sidebar-nav input[type='checkbox']").click ->
    panel = $(this).parents(".panel:first")
    if $(this).val() is "All"
      panel.find("input[type='checkbox']").not(".all").attr "checked", false
    else panel.find("input:checkbox.all").prop "checked", false  unless panel.find("input[type='checkbox']:checked").length is 0
    filtered_json = filterRecords(expenses_json)
    addExpenses filtered_json

