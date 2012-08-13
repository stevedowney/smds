module HtmlHelper
  
  def nbsp(number = 1)
    ('&nbsp;' * number).html_safe
  end
  
  # Display a check mark if _boolean_ is true, else &nbsp;
  def boolean_display(boolean)
    boolean ? icon_boolean : nbsp
  end

  def or_cancel
    or_span + link_to_cancel
  end
  
  def or_span
    content_tag(:span, 'or', :style => 'margin: 0 1em;')
  end
  
  def link_to_cancel
    link_to 'Cancel', root_path, :id => "cancel-to-root-path"
  end
end