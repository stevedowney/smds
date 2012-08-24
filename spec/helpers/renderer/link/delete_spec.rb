# require 'spec_helper'
# 
# describe 'Renderer::Link::Delete' do
#   let(:template) do
#     ActionView::Base.new.tap do |t|
#       # t.stub!(:controller_name).and_return("rows")
#       # t.stub!(:url_for).and_return("URL")
#       # t.stub!(:link_to_new).and_return("LinkToNew")
#     end
#   end
#   
#   let(:klass) {Renderer::Link::Delete}
#   let(:quote) {stub('quote') }
#   let(:dh_default) { klass.new(template, quote)}
# 
#   describe '#link_text' do
#     it "defaults to 'Delete'" do
#       dh_default.link_text.should be_nil
#     end
#     
#     it "can be set" do
#       dh = klass.new(template, quote, :link_text => 'Remove')
#       dh.link_text.should == 'Remove'
#     end
#   end
#   
#   describe '#confirmation' do
#     it "defaults to 'Confirm the delete'" do
#       dh_default.confirmation.should == 'Confirm the delete.'
#     end
#     
#     it "can be overridden" do
#       dh = klass.new(template, quote, :confirm => 'Sure?')
#       dh.confirmation.should == 'Sure?'
#     end
#     
#     it "can be suppressed" do
#       dh = klass.new(template, quote, :confirm => '')
#       dh.confirmation.should == '_none_'
#     end
#   end
#   
# end