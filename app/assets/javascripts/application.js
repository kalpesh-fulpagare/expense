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
$(document).ready(function(){
  $(".back-to-top").hide();
  $('.dropdown-toggle').dropdown();
  $("nav.navbar .navbar-collapse ul.nav li[rel='" + $(".activeTab").text() + "']").addClass("active");
  console.log("nav.navbar .navbar-collapse ul.nav li[rel='" + $(".activeTab").text() + "']");
  var offset = 280, duration = 500;
  $(window).scroll(function() {
    $(this).scrollTop() > offset ? $('.back-to-top').fadeIn(duration) : $('.back-to-top').fadeOut(duration);
  });
  $('.back-to-top').click(function(event) {
    $('html, body').animate({scrollTop: 0}, duration);
  });
  hideFlash();
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
    if (! $(".alert").hasClass("alert-error"))
      $(".alert").remove();
  }, 6000);
}