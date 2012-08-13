module ApplicationHelper

  def error_messages_for(model)
    render "form_errors", :model => model
  end
  
  def highlight(dom_id, duration = 1000)
    dom_id = normalized_dom_id(dom_id)
    %( $('#{dom_id}').effect("highlight", {}, #{duration}); ).html_safe
  end
  
	def replace_element_with_partial(dom_id, partial, locals = {})
    dom_id = "##{dom_id}" unless dom_id.starts_with?('#')
    rendered_partial = render :partial => partial, :locals => locals
		%( $('#{dom_id}').replaceWith('#{j rendered_partial}'); ).html_safe
  end

  def prepend_element_with_partial(dom_id, partial, locals = {})
    %( $('#{normalized_dom_id dom_id}').prepend("#{rendered_escaped_partial(partial, locals)}"); ).html_safe
  end
  
  def normalized_dom_id(dom_id)
    dom_id.starts_with?('#') ? dom_id : "##{dom_id}"
  end
  
  def rendered_escaped_partial(partial, locals)
    unescaped = render(:partial => partial, :locals => locals)
    escape_javascript(unescaped)
  end
  
  def update_quote_partial(qwa)
  	replace_element_with_partial(qwa.quote.dom_id, 'quotes_lister/quote', {:qwa => qwa})
  end

  def update_comment_partial(cwa)
  	replace_element_with_partial(cwa.comment.dom_id, 'comments/comment', {:cwa => cwa})
  end
  
end
