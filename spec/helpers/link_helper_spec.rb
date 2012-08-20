require 'spec_helper'

describe LinkHelper do
  
  describe '#link_to_icon_with_text' do
    let(:icon) { helper.icon_delete }
    let(:url) { "/foo"}
    let(:link) { helper.link_to_icon_with_text(icon, 'Delete', url)}

    it '<a> tag has url' do
      link.should have_tag(:a, :href => url, :class => 'with-icon')
    end
    
    it "text is in <b> tag" do
      link.should have_tag(:b, :text => 'Delete')
    end
  end
end
