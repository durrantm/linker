$(function() {
$( "#datepicker" ).datepicker();
});
$(function(){
var dateInput = $("#datepicker");
var format = 'yy-mm-dd';
dateInput.datepicker({dateFormat: format});
dateInput.datepicker('setDate', $.datepicker.parseDate(format, dateInput.val()));
});
