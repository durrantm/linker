$(function() {
$( "#datepicker" ).datepicker();
});
$(function(){
var dateInput = $("#datepicker");
var format = 'mm/dd/yyyy';
dateInput.datepicker({dateFormat: format});
dateInput.datepicker('setDate', $.datepicker.parseDate(format, dateInput.val()));
});
