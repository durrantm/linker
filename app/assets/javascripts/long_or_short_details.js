$(function(){
  $("a[data-toggle-description-length]='toggle'").click(function(event){
    event.preventDefault();
    $("span.show_hide").toggleClass("shown hidden");
    $("table").toggleClass("wide narrow");
    $.get('/toggle_full_details');
  });
});
