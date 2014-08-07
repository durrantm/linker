$(function(){
  $("a[data-verifying-link]='yes'").click(function(event){
    event.preventDefault();
    // spinner here
    a=$(this).parent();
    a.html('verifying...');
    var id= $(this).data("id");
    var row = $(this).data("tableRow");
    $.ajax({
      url: "/verify_link/"+id+"&table_row="+row,
       type: 'GET',
       success: function(r) {
                $("span#verify_link_"+row).html('<span class="done">Verified</span>');
             },
       error: function(r) {
           $("span#verify_link_"+row).html('<span class="undone">Unverified</span>');
        }
    });
  });
});
