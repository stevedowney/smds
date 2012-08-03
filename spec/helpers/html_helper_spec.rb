require 'spec_helper'

describe HtmlHelper do
  
  describe '#nbsp' do
    it "returns &nbsp;" do
      helper.nbsp.should == '&nbsp;'
    end
    
    it "is html_safe" do
      helper.nbsp.should be_html_safe
    end
    
    it "can return more than 1 nbsp" do
      helper.nbsp(2).should == helper.nbsp * 2
    end
  end
  
  describe '#boolean_display' do
    it "returns check mark if true" do
      helper.boolean_display(true).should have_tag('i', :class => 'icon-ok')
    end
    
    it "returns &nbsp; if false" do
      helper.boolean_display(false).should == "&nbsp;"
    end
  end

end