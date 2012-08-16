require 'spec_helper'

describe QuoteDestroyer do
  let(:quote) { Quote.first }
  let(:user) { FactoryGirl.create(:user) }
  let(:quote_creator) { QuoteCreator.new(user) }
  let(:quote_attributes) { {:who => 'who', :text => 'what'} }
  let(:quote_destroyer) { QuoteDestroyer.new(user) }
  let(:timeline) { TestTwitter.timeline }

  describe '#destroy' do
    before(:each) do
      quote_creator.create(quote_attributes)
    end
    
    it "destroys quote and tweet" do
      quote_destroyer.destroy(quote.id)
      Quote.count.should == 0
      timeline.size.should == 0
    end
    
    it "destroys quote if Twitter raises exception" do
      TestTwitter.should_receive(:status_destroy).with(quote.twitter_id, :trim_user => true).and_raise(Twitter::Error::NotFound)
      quote_destroyer.destroy(quote.id)
    end
  end
  
end

