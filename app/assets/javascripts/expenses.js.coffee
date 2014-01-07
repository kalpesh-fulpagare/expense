#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require common.js
#= require datepicker
$(".datepicker").datepicker
  format: "dd-M-yyyy"
  endDate: "+0d"
  startDate: "-30d"
  autoclose: true
  todayHighlight: true