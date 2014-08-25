$(function(){
  var updateUi = function (event) {
      event.defaultPrevented;
      $("span.show_hide").toggleClass("shown hidden");
      $("table").toggleClass("wide narrow");
      if (focus == 1) {
        $("input[type='text']:first").focus();
      }
      $.get('/toggle_full_details');
  };

  $("a[data-toggle-description-length]='toggle'").click(function(event){
    updateUi(event, focus=0);
  });

  $("a[data-toggle-description-length-refocus]='toggle'").click(function(event){
    updateUi(event, focus=1);
  });
});
