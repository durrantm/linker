$(function(){
  $( "#sortable" ).sortable({
    axis: 'y',
    dropOnEmpty: false,
    cursor: 'crosshair',
    items: 'li',
    opacity: 0.8,
    scroll: true,
    update: function(){
      $.ajax({
        url: '/groups/order_links',
        type: 'post',
        data: $('#sortable').sortable('serialize'),
        dataType: 'script'
      });
    }
  });
  $( "#sortable" ).disableSelection();
});
