module HtmlHelper
  
  def nbsp(number = 1)
    ('&nbsp;' * number).html_safe
  end
  
  # Display a check mark if _boolean_ is true, else &nbsp;
  def boolean_display(boolean)
    boolean ? icon_boolean : nbsp
  end

  def or_cancel(url = root_path, options = {})
    or_span + link_to_cancel(url, options)
  end
  
  def or_span
    content_tag(:span, 'or', :style => 'margin: 0 0.5em;')
  end
  
  def link_to_cancel(url, options_in = {})
    options = options_in.reverse_merge(:id => "cancel-link")
    link_to 'Cancel', url, options
  end
end