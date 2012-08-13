require 'spec_helper'

describe CreatesQuotes do
  let(:user) {FactoryGirl.create(:user)}
  let(:quote_creator) {CreatesQuotes.new(user)}
  let(:quote_attributes) { {:who => 'who', :text => 'what'} }
  
  it "raises error if success? called before create" do
    expect { quote_creator.success? }.to raise_error(CreatesQuotes::CreateNotCalledError)
  end
  
  describe 'create quote success' do
    it "saves the quote and updates Twitter" do
      quote_creator.create(quote_attributes)
      quote_creator.should be_success
      Quote.first.twitter_update_id_str.should == '1'
      TestTwitter.updates.first[:text].should match /who said: what/
    end
    
    it "saves quote if Twitter raise exception" do
      TestTwitter.should_receive(:update).and_raise(RuntimeError)
      quote_creator.create(quote_attributes)
      quote_creator.should be_success
      Quote.count.should == 1
      TestTwitter.updates.should be_empty
    end    
  end
  
  describe 'create quote failure' do
    it "doesn't save quote, doesn't update Twitter" do
      quote_creator.create({})
      quote_creator.should_not be_success
      Quote.count.should == 0
      TestTwitter.updates.should be_empty
    end
  end
end