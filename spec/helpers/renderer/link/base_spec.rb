require 'spec_helper'

describe 'Renderer::Link::Base' do
  let(:template) do
    ActionView::Base.new.tap do |t|
      # t.stub!(:controller_name).and_return("rows")
      # t.stub!(:url_for).and_return("URL")
      # t.stub!(:link_to_new).and_return("LinkToNew")
    end
  end
  
  let(:klass) {Renderer::Link::Base}
  let(:quote) {stub('quote') }
  let(:lb_default) { klass.new(template, quote)}

  describe '#url' do
    it "returns url_in if String" do
      lb = klass.new(template, 'foo')
      lb.url.should == 'foo'
    end
    
    it "returns polymorphic path if not string" do
      ar_instance = stub('ar instance')
      template.should_receive(:polymorphic_path).with(ar_instance).and_return('ar_path')
      lb = klass.new(template, ar_instance)
      lb.url.should == 'ar_path'
    end
  end

  describe '#dom_id' do
    it "derived from url" do
      lb = klass.new(template, '/foos/42')
      lb.dom_id.should == 'base_42'
    end
    
    it "can be passed in" do
      lb = klass.new(template, '/foos/42', :id => 'myid')
      lb.dom_id.should == 'myid'
    end
  end

  describe '#dom_id_from_url' do
    it "will use ActiveRecord dom_id" do
      user = FactoryGirl.create(:user)
      lb = klass.new(template, user)
      lb.dom_id_from_url.should == user.dom_id('base')
    end
    
    it "takes last integer from url" do
      lb = klass.new(template, 'foo/42/bar/21/baz')
      lb.dom_id_from_url.should == 'base_21'
    end
  end
  
end