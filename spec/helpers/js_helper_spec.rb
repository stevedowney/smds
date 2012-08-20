require 'spec_helper'

describe JsHelper do
  
  
  describe '#page_html' do
    
    it "string content" do
      result = helper.page_html('domId', 'new content')
      result.should == %($('#domId').html('new content');)
    end
    
  end
  
end