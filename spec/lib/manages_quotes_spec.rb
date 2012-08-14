require 'spec_helper'

describe ManagesQuotes do
  let(:user) {FactoryGirl.create(:user)}
  let(:quote_manager) {ManagesQuotes.new(user)}
  let(:quote_attributes) { {:who => 'who', :text => 'what'} }
  let(:timeline) {TestTwitter.timeline}
  let(:tweet) {timeline.first}
  
  describe '.initialize' do
    it "sets user" do
      quote_manager.user.should == user
    end
    
    it "raise error if no user passed" do
      expect { ManagesQuotes.new('') }.to raise_error(ManagesQuotes::NoUserError)
    end
  end
  
  describe '#success?' do
    it "true" do
      quote_manager.success = true
      quote_manager.should be_success
    end
    
    it "false" do
      quote_manager.success = false
      quote_manager.should_not be_success
    end
    
    it "error" do
      expect { quote_manager.success? }.to raise_error(ManagesQuotes::SuccessCalledBeforeMutatorCalledError)
    end
  end
  
  describe '#create' do
    it "saves the quote and Twitter timeline" do
      quote_manager.create(quote_attributes)
      quote_manager.should be_success
      Quote.first.twitter_id.should == tweet.id
      tweet.text.should start_with('who said: what')
    end
    
    it "saves quote if Twitter raise exception" do
      TestTwitter.should_receive(:update).and_raise(RuntimeError)
      quote_manager.create(quote_attributes)
      quote_manager.should be_success
      Quote.count.should == 1
      TestTwitter.timeline.should be_empty
    end
    
    it "when quote invalid, doesn't save quote, doesn't update Twitter" do
      quote_manager.create({})
      quote_manager.should_not be_success
      Quote.count.should == 0
      TestTwitter.timeline.should be_empty
    end
  end
  
  describe '#update' do
    let(:qm2) {ManagesQuotes.new(user)}
    
    before(:each) do
      quote_manager.create(quote_attributes)
    end

    it "updates quote and Twitter timeline" do
      quote = Quote.first
      qm2.update(quote.id, :who => 'new who')
      qm2.should be_success
      Quote.first.who.should == 'new who'
      timeline.first.text.should start_with('new who said: what')
    end
    
    it "doesn't update Twitter timeline if quote didn't change" do
      quote = Quote.first
      original_twitter_id = quote.twitter_id
      qm2.update(quote.id, :who => quote.who)
      qm2.should be_success
      quote.reload.twitter_id.should == original_twitter_id
    end
  end
  
  describe '#destroy' do
    it "destroys quote and tweet" do
      quote_manager.create(quote_attributes)
      timeline.size.should == 1
      quote_manager.destroy(Quote.first.id)
      Quote.count.should == 0
      timeline.size.should == 0
    end
  end
  
  describe '#qwa' do
    it "has quote" do
      quote_manager.create(quote_attributes)
      quote_manager.quote.should == Quote.first
    end
  end
end