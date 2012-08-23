module JsHelper

  def js_void
    @js_void ||= 'javascript:void(0)'
  end
  
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
  
  def page_html(dom_id, new_content = nil, options = {})
    dom_id = normalized_dom_id(dom_id)
    content = if new_content
      j new_content
    else
      rendered_escaped_partial(options.fetch(:partial), options[:locals])
    end
    %($('#{dom_id}').html('#{content}');).html_safe
  end
  
  def page_show(dom_id)
    dom_id = normalized_dom_id(dom_id)
    %($('#{dom_id}').show();).html_safe
  end
  
end