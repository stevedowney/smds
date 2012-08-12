require 'spec_helper'

describe CreatesQuotes do
  let(:user) {FactoryGirl.create(:user)}
  let(:quote_creator) {CreatesQuotes.new(user)}
  let(:quote_attributes) { {:who => 'who', :text => 'what'} }
  
  describe 'success' do
    it "saves the quote and updates Twitter" do
      quote_creator.create(quote_attributes).should be_true
      Quote.first.twitter_update_id_str.should == '1'
      TestTwitter.updates.first[:text].should match /who said: what/
    end
  end
  
  describe 'failure' do
    it "doesn't save quote, doesn't update Twitter" do
      quote_creator.create({}).should be_false
      Quote.count.should == 0
      TestTwitter.updates.should be_empty
    end
    
    it "saves quote if Twitter raise exception" do
      TestTwitter.should_receive(:update).and_raise(RuntimeError)
      quote_creator.create(quote_attributes).should be_true
      Quote.count.should == 1
      TestTwitter.updates.should be_empty
    end
  end
end