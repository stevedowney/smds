require 'spec_helper'

describe QuoteUpdater do
  let(:user) { FactoryGirl.create(:user) }
  let(:quote) { Quote.first }
  let(:quote_creator) { QuoteCreator.new(user) }
  let(:quote_updater) { QuoteUpdater.new(user) }
  let(:quote_attributes) { {:who => 'who', :text => 'what'} }
  let(:timeline) {TestTwitter.timeline}
  let(:tweet) {timeline.first}
  
  describe '#update' do
    
    before(:each) do
      quote_creator.create(quote_attributes)
    end

    context 'valid quote' do
      it "updates quote and Twitter timeline" do
        quote_updater.update(quote.id, :who => 'new who')
        quote_updater.should be_success
        quote.reload.who.should == 'new who'
        tweet.text.should start_with('new who said: what')
      end
    
      it "doesn't update Twitter timeline if quote didn't change" do
        original_twitter_id = quote.twitter_id
        quote_updater.update(quote.id, :who => quote.who)
        quote_updater.should be_success
        quote.reload.twitter_id.should == original_twitter_id
      end      
    end
    
    context 'invalid quote' do
      it "doesn't update" do
        ManagesTwitterQuotes.should_not_receive(:update)
        quote_updater.update(quote.id, :who => '')
        quote_updater.should_not be_success
      end
    end
    
    context 'has comments' do
      before { quote.update_attribute(:comments_count, 1) }
      
      it "can't update" do
        quote_updater.update(quote.id, :who => 'new who')
        quote_updater.should_not be_success
      end

      it "can update if admin" do
        user.admin = true
        quote_updater.update(quote.id, :who => 'new who')
        quote_updater.should be_success
      end
    end
  end
  
  
end
