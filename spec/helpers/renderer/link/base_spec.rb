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
  let(:lb) {klass.new(template, '/url')}
  let(:lb_default) { klass.new(template, quote)}

  describe '#html' do
    it "has label" do
      lb.html.should have_tag(:a, :text => '/url')
    end
    
    it "has url" do
      lb.html.should have_tag(:a, :href => '/url')
    end
  end
  
  describe '#label' do
    it "text only" do
      lb.label.should == '/url'
    end
    
    it "w/icon" do
      lb.stub!(:link_icon).and_return('<i>'.html_safe)
      lb.label.should == '<i> /url'
    end
  end
  
  describe '#link_icon' do
    it "should be nil" do
      lb.link_icon.should be_nil
    end
  end
  
  describe '#link_text' do
    it "defaults to url" do
      lb.link_text.should == '/url'
    end
    
    it "can be overridden" do
      lb = klass.new(template, 'foo', :label => 'myLabel')
      lb.link_text.should == 'myLabel'
    end
  end
  
  describe '#url' do
    it "returns url_in if String" do
      lb.url.should == '/url'
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
  
  describe '#title' do
    it "defaults to nil" do
      lb.title.should be_nil
    end
    
    context ':title set' do
      let(:lb) {klass.new(template, '/url', :title => 'Title')}
      
      it "can be set" do
        lb.title.should == 'Title'
      end
    
      it "appears in link" do
        lb.html.should have_tag(:a, :title => 'Title')
      end
    end
  end
  
end