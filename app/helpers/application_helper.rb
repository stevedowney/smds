module ApplicationHelper

	def icon(name)
		icon_class = "icon-#{name.to_s.gsub("_", "-")}"
		content_tag(:i, nil, :class => icon_class)
	end

	def icon_edit
		icon(:pencil)
	end
	
	def icon_delete
		icon(:trash)
	end

	def icon_boolean
		icon(:ok)
	end

end
