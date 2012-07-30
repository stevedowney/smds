module ApplicationHelper


	def replace_element_with_partial(dom_id, partial, locals = {})
    dom_id = "##{dom_id}" unless dom_id.starts_with?('#')
    rendered_partial = render :partial => partial, :locals => locals
		%( $('#{dom_id}').replaceWith('#{j rendered_partial}')).html_safe
  end

  def update_quote_partial(qwa)
  	replace_element_with_partial(qwa.quote.dom_id, 'quotes_lister/quote', {:qwa => qwa})
  end

  def update_comment_partial(cwa)
  	replace_element_with_partial(cwa.comment.dom_id, 'comments/comment', {:cwa => cwa})
  end
  
end
