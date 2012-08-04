module JsHelper

  def close_delete_confirmation
    %(
      $('#tb-confirm').modal('hide');
    )
  end

  def highlight_and_remove(dom_id)
    %(
      $('##{dom_id}').effect("highlight", {}, 1000, function() {
      	$('##{dom_id}').remove();
      });
    ).html_safe
  end
end