module HtmlHelper
  
  def nbsp(number = 1)
    ('&nbsp;' * number).html_safe
  end
  
  # Display a check mark if _boolean_ is true, else &nbsp;
  def boolean_display(boolean)
    boolean ? icon_boolean : nbsp
  end

  def or_connector
    content_tag(:span, 'or', :style => 'margin: 0 1em;')
  end
end