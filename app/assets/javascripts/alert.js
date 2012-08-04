function tbAlert(message) {
  $('#tb-alert-message').text(message);
  $('#tb-alert').modal('show');
}

$(function() {
  
  // $('.modal').on('hide', function () {
  //    flash.clear();
  // })
  
  // Hide modal windows when "Cancel" clicked
  $('#alert-ok-btn').click(function() {
    $(this).parents('.modal').modal('hide');
  });
  

})