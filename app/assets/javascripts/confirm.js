function TwitterBootstrapConfirm(options) {
  var settings = $.extend( {
    dialog : this,
    autoHide : false,
    title : 'Confirmation',
    confirmLabel : "<i class='icon-ok icon-white'></i> OK",
    confirmBtnClass : 'btn btn-primary',
    cancelLabel : "<i class='icon-remove'></i> Cancel",
    message : 'Click "OK" to confirm.',
    }, options);
        
  this.hide = function() {
    $('#tb-confirm').modal('hide');
  }
  
  this.show = function() {
    $('#tb-confirm-title').text(settings.title);
    $('#tb-confirm-message').text(settings.message);
    $('#tb-confirm-ok-btn').html(settings.confirmLabel);
    $('#tb-confirm-ok-btn').attr('class', settings.confirmBtnClass);
    $('#tb-confirm-cancel-btn').html(settings.cancelLabel);
    
    $('#cancel').unbind('click').click(settings.onCancel);
    
    $('#tb-confirm-ok-btn').unbind('click').click(function() {
      settings.onConfirm();
      if (settings.autoHide) { settings.dialog.hide() }
    })
    
    $('#tb-confirm').modal('show');
  }
  
}

function tbConfirm(options) {
  return new TwitterBootstrapConfirm(options);
}

function tbConfirmDelete(options) {
  var settings = $.extend( {
    title : 'Delete Confirmation',
    confirmLabel : "<i class='icon-trash icon-white'></i> Delete",
    confirmBtnClass : 'btn btn-danger',
    message : 'Click "Delete" to confirm.  This is an irreversible action.',
    }, options);
    
    return new TwitterBootstrapConfirm(settings);
}