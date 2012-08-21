$(function() {

  $('.comment-reply').live('click', function() {
    var formID = '#' + $(this).data('form');
    var textAreaSelector = formID + " textarea"
    $(formID).show();
    $(textAreaSelector).focus();
  });
    
});
