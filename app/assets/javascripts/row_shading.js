$(function(){
  $("a[data-toggle-group-row-shading]='toggle'").click(function(){
    $(".row_color_group_1").toggleClass("color_group_1");
    $(".row_color_group_2").toggleClass("color_group_2");
    $(".row_color_group_3").toggleClass("color_group_3");
    $("span#shading_link span.show_hide").toggleClass("shown_shading_link hidden_shading_link");
    $.get('/toggle_row_shading');
  });
});
