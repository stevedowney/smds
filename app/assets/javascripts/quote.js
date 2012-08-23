$(function() {
  
  $('.comments-link').live('click', function() {
    var quoteId = $(this).data('quote-id');
    
    $.ajax({
      url: '/quotes/' + quoteId + '/top_comments',
      type: 'get',
      dataType: 'script',
    });
  });
  
  $('.top-comments-hide-link').live('click', function() {
    $(this).closest('.top_comments').hide();
  });
});