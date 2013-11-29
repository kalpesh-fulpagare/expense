// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
var flashTimer;
var months = {0: "Jan", 1: "Feb", 2: "Mar", 3: "Apr", 4: "May", 5: "June", 6: "July", 7: "Aug", 8: "Sept", 9: "Oct", 10: "Nov", 11: "Dec"}
var days = {1: "Mon", 2: "Tue", 3: "Wed", 4: "Thu", 5: "Fri", 6: "Sat", 0: "Sun"}
$(document).ready(function(){
  $("nav.navbar .navbar-collapse ul.nav li[rel='" + $(".activeTab").text() + "']").addClass("active");
  hideFlash();
  $("form").submit(function(){
    $(this).find("errorSpan").remove();
  });
  $("form input, form select").focus(function(){
    if($(this).hasClass("hasError")){
      $(this).removeClass("hasError");
      $(this).next(".errorSpan").remove();
    }
  });
});
function toggleDoms(show, hide){
  show.show();
  hide.hide();
}
function displayFlash(message, type){
  var flash = "<div class='alert fade in " + type + "'><button data-dismiss='alert' class='close'>×</button>"
  flash += message + "</div>";
  $("div.alert").remove();
  $('#contentBody').prepend(flash);
  hideFlash();
}
function hideFlash(){
  clearTimeout(flashTimer);
  flashTimer = setTimeout(function() {
    if ( !($(".alert").hasClass("alert-danger") || $(".alert").hasClass("alert-info")) )
      $(".alert").remove();
  }, 6000);
}
function filterRecords(filters, record_json){
  $.each(filters, function( name , type ) {
    var tmp_json = [], filter_values = [];
    $(".sidebar-nav input:checkbox[filter_name='"+ name +"']:checked").each(function(){
      if($(this).val() == "All")
        filter_values.push("all");
      else
        filter_values.push(type == 'int' ? parseInt($(this).val()) : $(this).val());
    });
    if(filter_values.length == 1 && filter_values[0] == 'all'){
      filter_values = [];
      $(".sidebar-nav input:checkbox[filter_name='"+ name +"']").not('.all').each(function(){
        filter_values.push(type == 'int' ? parseInt($(this).val()) : $(this).val());
      });
    }
    $.each(record_json, function( index, record ) {
       if(filter_values.indexOf(eval("record."+ name)) != -1)
         tmp_json.push(record);
    });
    record_json = tmp_json;
  });
  return record_json;
}
function capitalise(txt) {
  return txt.charAt(0).toUpperCase() + txt.slice(1).toLowerCase();
}
function displayErrors(jsonErrorHash, resourceName){
  $(".errorSpan").remove();
  errors = JSON.parse(jsonErrorHash);
  $.each(errors, function(attr, error_array) {
    $.each(error_array, function(index, error){
      error_array[index] = capitalise(attr) + " " + error;
    });
    var errorString = error_array.join(", ");
    errorDom = "<span class='errorSpan help-block'>" + errorString + "</span>";
    var name = resourceName + "[" + attr + "]";
    var el = $("[name^='" + name + "']");
    if (el.prop("type") === "radio" || el.prop("type") === "checkbox") {
      el.parents(".input-group:first").append(errorDom);
    } else {
      $(errorDom).insertAfter(el);
      el.addClass("hasError");
    }
  });
  $('html,body').animate({scrollTop: $(".errorSpan:visible").offset().top-50},'slow');
}