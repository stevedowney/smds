require 'spec_helper'

describe CreatesQuotes do
  let(:user) {FactoryGirl.create(:user)}
  let(:quote_creator) {CreatesQuotes.new(user)}
  
  describe 'success' do
    let(:quote_attributes) { {:who => 'who', :text => 'what'} }
    
    it "saves the quote and updates Twitter" do
      Twitter.should_receive(:update)
      quote_creator.create(quote_attributes).should be_true
      Quote.count.should == 1
    end
  end
  
  describe 'failure' do
    it "doesn't save quote, doesn't update Twitter" do
      Twitter.should_not_receive(:update)
      quote_creator.create({}).should be_false
      Quote.count.should == 0
    end
  end
end