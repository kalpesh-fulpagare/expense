var filters = {category_id: "int", date: "string", month: "int"};
$(document).ready(function(){
  addExpenses(expenses_json);
  $(".sidebar-nav input[type='checkbox']").click(function(){
    var panel = $(this).parents(".panel:first");
    if ($(this).val() == "All")
      panel.find("input[type='checkbox']").not(".all").attr("checked", false);
    else if (panel.find("input[type='checkbox']:checked").length == 0)
      panel.find("input:checkbox.all").prop('checked', true);
    else{
      panel.find("input:checkbox.all").prop('checked', false);
    }
    filtered_json = filterRecords(filters, expenses_json);
    addExpenses(filtered_json);
  });
});
function addExpenses(exp_json){
  $("#expensesTable").find("tr").not(".thHeads").remove();
  var table_data="", category_name, dt, cost=0;
  $.each(exp_json, function( index, e ) {
    table_data += "<tr>";
    table_data += "<td><a href='/personal_expenses/"+ e.id +"'>" + e.id + "</a></td>";
    table_data += "<td>" + e.title + "</td>";
    table_data += "<td>" + e.description.replace(/\r\n/g, "<br>") + "</td>";
    table_data += "<td>" + categories_json[e.category_id][0].name + "</td>";
    cost += parseInt(e.cost);
    dt = new Date(e.date.replace(/-/g,"/"));
    table_data += "<td>" + dt.getDate() + " " + months[dt.getMonth()] + " (" + days[dt.getDay()] + ")" + ", " + dt.getFullYear() + "</td>";
    if(is_admin)
      table_data += "<td>" + users_json[e.user_id][0].first_name + " " + users_json[e.user_id][0].last_name + "</td>";
    table_data += "<td class='text-right'>" + e.cost + "</td>";
    table_data += "<tr>";
  });
  table_data += "<tr><td class='warning text-right' colspan='5'>Total Cost</td><td class='success text-right' colspan='5'>"+ cost +"</td></tr>";
  $("#expenseTotal").html("Total: <strong>"+ cost +"</strong>");
  $("#expensesTable").append(table_data);
}