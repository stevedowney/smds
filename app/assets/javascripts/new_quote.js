var quoteQuickAdd = function() {
  
  function hideControls() {
    $('#new-quote-controls').hide();
  }

  function reset() {
    $('#quote').val('').attr('placeholder', gon.quote_placeholder).attr('rows', 1);
    hideControls();
  }
  
  return { 
    reset: reset
  };
  
}();


$(function() {
  
  function quoteElement() { return $('#quote') }
  function quoteValue() { return quoteElement().val() }
  
  function isQuoteEmpty() {
    return $('#quote').val() == ''
  }
  
  function showControls() {
    $('#new-quote-controls').show();
  }
  
  function hideControls() {
    $('#new-quote-controls').hide();
  }

  function resetQuickAddForm() {
    $('#quote').val('');
    hideControls();
  }
  
  $('#quote').focus(function() {
    $(this).attr('rows', 3).attr('placeholder', '')
    showControls();
  });
  
  $('#quote').blur(function() {
    if (isQuoteEmpty()) {
      quoteQuickAdd.reset();
    }
  });
  
  $('#quote-more').click(function() {
    var url = $('#quote-more').data('url');
    var quote = quoteValue();
    
    $.ajax({
      url: url,
      type: 'get',
      dataType: 'script',
      data: { 'quote': quote }
    });
  })
  
  $('#quote').keyup(function(e) {
    if (e.keyCode == 27) {
      $('#quote').blur();
      return
    }
    var pattern = /^\s+$/
    var quoteValue = $(this).val();
    if (quoteValue == '' || pattern.test(quoteValue)) {
      $('#quote-submit').attr('disabled', true);
    } else {
      $('#quote-submit').removeAttr('disabled');
    }
  });
})