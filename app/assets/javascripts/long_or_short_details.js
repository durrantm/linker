$(function(){
  var updateUi = function (event) {
      event.defaultPrevented;
      $("span.show_hide").toggleClass("shown hidden");
      $("table").toggleClass("wide narrow");
      toggle_server_details_flag_silently();
  };

  $("a[data-toggle-description-length]='toggle'").click(function(event){
    updateUi(event);
  });

  $("a[data-toggle-description-length-refocus]='toggle'").click(function(event){
    updateUi(event);
  });
});
