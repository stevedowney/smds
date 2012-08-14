module JsHelper

  def close_delete_confirmation
    %(
      $('#tb-confirm').modal('hide');
    )
  end

  def highlight_and_remove(dom_id)
    duration = App.test? ? 0 : 1000
duration = 1
    %(
      $('##{dom_id}').effect("highlight", {}, #{duration}, function() {
      	$('##{dom_id}').remove();
      });
    ).html_safe
  end
end