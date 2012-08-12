// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//
//#= require jquery
//#= require focus_on_first_field

// jQueryUI Date Picker:
$(function (){
        $(".datepick").datepicker({ dateFormat: 'yy-mm-dd'});
});
$(function (){
	$('input:first').focus;
});

