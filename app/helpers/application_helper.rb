module ApplicationHelper

	def icon(name, options = {})
		icon_class = "icon-#{name.to_s.gsub("_", "-")}"
		options[:class] = icon_class
		content_tag(:i, nil, options)
	end

	def icon_boolean
		icon(:ok)
	end

	def icon_delete
		icon(:trash)
	end

	def icon_edit
		icon(:pencil)
	end

	def icon_favorite
		icon('star-empty')
	end

	def icon_unfavorite
		icon('star')
	end

	def icon_flag
		icon(:flag, :style => "opacity: 0.4")
	end	

	def icon_unflag
		icon(:flag)
	end	

	def icon_vote_up
		icon('thumbs-up')
	end

	def icon_vote_down
		icon('thumbs-down')
	end
	
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
