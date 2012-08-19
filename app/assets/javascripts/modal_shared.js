$(function() {
  
  $('.modal').on('hide', function () {
     flash.clear();
  })
  
  // Hide modal windows when "Cancel" clicked
  $('.modal-cancel').click(function() {
    $(this).parents('.modal').modal('hide');
  });
  

})
