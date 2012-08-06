require 'spec_helper'

describe IconsHelper do
  
  describe '#icon' do
    it "returns Twitter Bootstrap glyph tag" do
      icon = helper.icon('foo')
      icon.should have_tag('i', :class => 'icon-foo')
    end
    
    it "massages name: to string, dasherize" do
      icon = helper.icon(:two_parts)
      icon.should have_tag('i', :class => 'icon-two-parts')
    end
    
    it "passes options on to <i> tag" do
      icon = helper.icon(:foo, :id => 'bar')
      icon.should have_tag('i', :class => 'icon-foo', :id => 'bar')
    end
  end
  
end