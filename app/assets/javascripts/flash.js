// Display a message to the user
//   use: flash.notice("Saved")
//        flash.error("Invalid Request")
var flash = function() {
  function message(m) {
    var flash_element = $('div.flash-modal').filter(':visible').last();
    show_flash(flash_element, m);
    // setTimeout(function() { hide_flash(flash_element); }, 5000);
  }
  
  function error(m) {
    m = '<div class="flash_error">'+m+'</div>';
    message(m);
  }
  
  function notice(m) {
    m = '<div class="flash_notice">'+m+'</div>';
    message(m);
  }
  
  function alert(m) {
    m = '<div class="flash_alert">'+m+'</div>';
    message(m);
  }
  
  function warning(m) {
    m = '<div class="flash_warning">'+m+'</div>';
    message(m);
  }

  function show_flash(el, m) {
    el.css('height', 'auto');
    el.html(m);
    el.slideDown(50);
  }
  
  // function hide_flash(el) {
  //   // animate height to 1px because 0px makes the element :hidden
  //   el.animate({height: '1'}, 500, function() {
  //     el.html('');
  //   });
  // }

  function clear() {
    message('');
    // var flash_element = $('.flash').last();
    // flash_element.html('');
  }

  return { notice: notice, error: error, alert: alert, warning: warning, clear: clear };
}();
