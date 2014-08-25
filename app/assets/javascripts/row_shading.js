$(function(){
  $("a[data-toggle-group-row-shading]='toggle'").click(function(event){
    color_groups(event, focus = 0);
  });

  $("a[data-toggle-group-row-shading-refocus]='toggle'").click(function(event){
    color_groups(event, focus = 1);
  });

  var color_groups = function(event) {
    event.preventDefault();
    $(".row_color_group_1").toggleClass("color_group_1");
    $(".row_color_group_2").toggleClass("color_group_2");
    $(".row_color_group_3").toggleClass("color_group_3");
    $("span#shading_link span.show_hide").toggleClass("shown_shading_link hidden_shading_link");
    $.get('/toggle_row_shading');
    if (focus == 1) {
      $("input[type='text']:first").focus();
    }
  }

});
