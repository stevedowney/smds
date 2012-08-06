module IconsHelper

  def icon(name, options = {})
    icon_class = "icon-#{name.to_s.gsub("_", "-")}"
    options[:class] = icon_class
    content_tag(:i, nil, options)
  end

  def icon_boolean
    icon('ok')
  end

  def icon_comment
    icon('comment')
  end

  def icon_delete
    icon('trash')
  end

  def icon_edit
    icon('pencil')
  end

  def icon_favorite
    icon('star-empty')
  end

  def icon_unfavorite
    icon('star')
  end

  def icon_flag
    icon('flag', :style => "opacity: 0.4")
  end	

  def icon_unflag
    icon('flag')
  end	

  def icon_ok
    icon('ok')
  end

  def icon_vote_up
    icon('thumbs-up')
  end

  def icon_vote_down
    icon('thumbs-down')
  end

end