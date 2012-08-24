function showLess() {
  $('#less-email-share-quote').show();
  $('#more-email-share-quote').hide();
}

function showMore() {
  $('#less-email-share-quote').hide();
  $('#more-email-share-quote').show();
}

function showEmailQuoteModal() {
  showLess();
  $('#email-quote-modal').modal('show');
}

function hideEmailQuoteModal() {
  $('#email-quote-modal').hide();
  $('.modal-backdrop').hide();
}

$(function() {
	
	// email link clicked
	$('.email-quote').live('click', function(e) {
	  // put quote_id in hidden field
    var quoteId = $(this).data('quote-id');
    $('.quote-id').each(function(item, element) {
      $(element).val(quoteId);
    })
    
    showEmailQuoteModal();
    showLess();
    $('#quote_sharer_by_email_to_email').focus();
    return false; 
  });
  
  $('#show-more').click(function() {
    var emailSelector = '#quote_sharer_by_email_to_email';
    $('#more-form #quote_sharer_by_email_to_email').val( $('#less-form #quote_sharer_by_email_to_email').val() );
    showMore();
  });
  
  $('#show-less').click(function() {
    $('#less-form #quote_sharer_by_email_to_email').val( $('#more-form #quote_sharer_by_email_to_email').val() );
    showLess();
  });

  // when modal closes
  $('#email-quote-modal').on('hide', function () {
    // clear form fields
     $('#email-quote-modal form').each(function(i, e) {
       e.reset();
     })
     
  })
  
})