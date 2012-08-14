require 'spec_helper'

describe ManagesTwitterQuotes do
  let(:klass) { ManagesTwitterQuotes}
  let!(:quote) { FactoryGirl.create(:quote, :who => "who", :text => "what") }
  let(:timeline) { TestTwitter.timeline }
  let(:tweet) { timeline.first}
  
  describe '.create' do
    it "posts tweet, updates twitter_id" do
      klass.create(quote.id)
      quote.reload.twitter_id.should == tweet.id
      timeline.first[:text].should start_with("who said: what")
    end
  end
  
  describe '.destroy' do
    before { klass.create(quote.id) }
    
    it "destroys tweet" do
      klass.destroy(quote.reload.twitter_id)
      timeline.should be_empty
    end
  end
  
  describe '.update' do
    before { klass.create(quote.id) }
    
    it "destroys origal tweet, creates new, updates twitter_id" do
      quote.update_attribute(:who, 'whom')
      old_twitter_id = quote.twitter_id
      klass.update(quote.id)
      quote.reload.twitter_id.should_not == old_twitter_id
      tweet.text.should start_with('whom said: what')
    end
  end
end