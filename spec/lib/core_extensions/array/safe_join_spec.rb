require 'spec_helper'

describe Array do
  
  it "#safe_join returns html_safe string" do
    ['a', 1].safe_join.should be_html_safe
  end

end