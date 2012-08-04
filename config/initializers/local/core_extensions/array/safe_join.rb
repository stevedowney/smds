# http://api.rubyonrails.org/classes/ActionView/Helpers/OutputSafetyHelper.html#method-i-safe_join

class Array
  include ActionView::Helpers::OutputSafetyHelper
  
  def safe_join(sep=$,)
    super(self, sep)
  end
end