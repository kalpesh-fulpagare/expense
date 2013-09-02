var months = {0: "Jan", 1: "Feb", 2: "Mar", 3: "Apr", 4: "May", 5: "June", 6: "July", 7: "Aug", 8: "Sept", 9: "Oct", 10: "Nov", 11: "Dec"}
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
  });
});
function applyFilter(){

}
function addExpenses(exp_json){
  $("#expensesTable").find("tr").not(".thHeads").remove();
  var table_data="", category_name, dt;
  $.each(exp_json, function( index, e ) {
    table_data += "<tr>";
    table_data += "<td><a href='/expenses/"+ e.id +"'></a>" + e.id + "</td>";
    table_data += "<td>" + e.title + "</td>";
    table_data += "<td>" + e.description + "</td>";
    table_data += "<td>" + categories_json[e.category_id][0].name + "</td>";
    table_data += "<td>" + users_json[e.user_id][0].first_name + " " + users_json[e.user_id][0].last_name + "</td>";
    table_data += "<td>" + e.cost + "</td>";
    dt = new Date(e.date.replace(/-/g,"/"));
    console.log(dt);
    table_data += "<td>" + dt.getDate() + " " + months[dt.getMonth()] + ", " + dt.getFullYear() + "</td>";
    table_data += "<tr>";
  });
  $("#expensesTable").append(table_data);
}