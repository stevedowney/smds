require 'spec_helper'

describe JsHelper do
  
  
  describe '#page_html' do
    
    it "string content" do
      result = helper.page_html('domId', 'new content')
      result.should == %($('#domId').html('new content');)
      result.should be_html_safe
    end
    
  end
  
  # dom_id = normalized_dom_id(dom_id)
  # %($('#{dom_id}').show();).html_safe

  describe '#page_show' do
    it "string content" do
      result = helper.page_show('dom-id')
      result.should == %($('#dom-id').show();)
      result.should be_html_safe
    end
  end
  
end