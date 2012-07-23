module HtmlHelper
  
  def nbsp(number = 1)
    ('&nbsp;' * number).html_safe
  end
  
  # Display a check mark if _boolean_ is true, else &nbsp;
  def boolean_display(boolean)
    boolean ? icon_boolean : nbsp
  end

end