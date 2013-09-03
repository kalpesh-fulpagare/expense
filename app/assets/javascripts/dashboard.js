var filters = {user_id: "int", category_id: "int", date: "string", month: "int"};
//var filters = {user_id: "int", category_id: "int", date: "string"};
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
      // if(panel.find("input[type='checkbox']").not(".all").length == panel.find("input[type='checkbox']:checked").length){
      //   panel.find("input:checkbox.all").prop('checked', true);
      //   panel.find("input:checkbox").not(".all").prop('checked', false);
      // }
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
    table_data += "<td><a href='/expenses/"+ e.id +"'>" + e.id + "</a></td>";
    table_data += "<td>" + e.title + "</td>";
    table_data += "<td>" + e.description + "</td>";
    table_data += "<td>" + categories_json[e.category_id][0].name + "</td>";
    table_data += "<td>" + users_json[e.user_id][0].first_name + " " + users_json[e.user_id][0].last_name + "</td>";
    cost += parseInt(e.cost);
    dt = new Date(e.date.replace(/-/g,"/"));
    table_data += "<td>" + dt.getDate() + " " + months[dt.getMonth()] + ", " + dt.getFullYear() + "</td>";
    table_data += "<td class='text-right'>" + e.cost + "</td>";
    table_data += "<tr>";
  });
  table_data += "<tr><td class='danger text-right' colspan='6'>Total Cost</td><td class='success text-right'>"+ cost +"</td></tr>";
  $("#expensesTable").append(table_data);
}