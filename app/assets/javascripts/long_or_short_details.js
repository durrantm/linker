$(function(){
  $("a[data-toggle-description-length]='toggle'").click(function(){
    $("span.show_hide").toggleClass("shown hidden");
    $.get('/toggle_full_details');
  });
});