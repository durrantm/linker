$(function(){
$("a#row_colors_on").click(function(){
$(".row_color_group_1").addClass("color_group_1");
$(".row_color_group_2").addClass("color_group_2");
$(".row_color_group_3").addClass("color_group_3");
$.get('/set_group_shading?show=true');
event.preventDefault();
});
});
$(function(){
$("a#row_colors_off").click(function(){
$(".row_color_group_1").removeClass("color_group_1");
$(".row_color_group_2").removeClass("color_group_2");
$(".row_color_group_3").removeClass("color_group_3");
$.get('/set_group_shading?show=false');
});
});

