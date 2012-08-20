require 'spec_helper'

describe QuoteCreator do
  let(:user) {FactoryGirl.create(:user)}
  let(:quote_creator) {QuoteCreator.new(user)}
  let(:quote_attributes) { {:who => 'who', :text => 'what'} }
  let(:timeline) {TestTwitter.timeline}
  let(:tweet) {timeline.first}

  describe '#create' do
    it "saves the quote and Twitter timeline" do
      quote_creator.create(quote_attributes)
      quote_creator.should be_success
      Quote.first.twitter_id.should == tweet.id
      tweet.text.should start_with('who said: what')
    end
    
    it "saves quote if Twitter raise exception" do
      TestTwitter.should_receive(:update).and_raise(RuntimeError)
      quote_creator.create(quote_attributes)
      quote_creator.should be_success
      Quote.count.should == 1
      TestTwitter.timeline.should be_empty
    end
    
    it "when quote invalid, doesn't save quote, doesn't update Twitter" do
      quote_creator.create({})
      quote_creator.should_not be_success
      Quote.count.should == 0
      TestTwitter.timeline.should be_empty
    end
  end
  
  describe '#quick_create' do
    it "parses attributes and creates" do
      quote_creator.quick_create("who said what")
      quote_creator.should be_success
      Quote.first.twitter_id.should == tweet.id
      tweet.text.should start_with('who said: what')
    end
  end
end