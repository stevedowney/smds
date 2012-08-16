require 'spec_helper'

describe QuoteDestroyer do
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
      quote_destroyer.destroy(Quote.first.id)
      Quote.count.should == 0
      timeline.size.should == 0
    end
  end
  
end

