$(function() {

  var authToken = $('meta[name="csrf-token"]').attr('content');
  
  function ajaxPost(url) {
    $.ajax({
      url: url,
      type: 'post',
      dataType: 'script',
      data: { '_method': 'delete' }
    });
  }
  
  function htmlPost(url) {
    $('<form method="post" action="' + url + '" />')
      .append('<input type="hidden" name="_method" value="delete" />')
      .append('<input type="hidden" name="authenticity_token" value="' + authToken + '" />')
      .appendTo('body')
      .submit();
  }
  
  function performDelete(url, format) {
    if (format == 'js') {
      ajaxPost(url);
    } else {
      htmlPost(url);
    }
  }
  
  $('a.delete-link').live('click', function(event) {
    var link = $(this);
    link.parents('.btn-group').removeClass('open');
    var url = link.attr('href');//data('url');
    var rowId = link.data('row-id');
    var confirmation = link.data('confirmation');
    var format = link.data('format');

    if (confirmation == '_none_') {
      performDelete(url, format);
    } else {
      $('#' + rowId).addClass('delete-selected');
      tbConfirmDelete({
        message : "Delete this row?  This is not reversible.",
        onConfirm : function() { performDelete(url, format) }
      }).show();
    }
    return false;
  });

  $('#delete-cancel').click(function() {
    $('#myModal').modal('hide');
  });
  
  $('#delete-confirm').click(function(event) {
    var url = $(event.target).data('url');
    var format = $(event.target).data('format');
    performDelete(url, format);
  });
  
  $('#tb-confirm').on('hidden', function () {
    $('.delete-selected').removeClass('delete-selected');
  })
  
});
