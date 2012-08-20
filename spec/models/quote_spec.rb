require 'spec_helper'

describe Quote do

	describe '#owned_by?' do
		let(:other_user) {FactoryGirl.create(:user)}
		let(:owner) {FactoryGirl.create(:user)}
		let(:quote) {FactoryGirl.create(:quote, :owner => owner)}

		it 'owned by owner' do
			quote.should be_owned_by(owner)
		end

		it "not owned by non-owner" do
		  quote.should_not be_owned_by(other_user)
		end
	end
	
	describe '#formatted' do
	  let(:quote) {FactoryGirl.build(:quote, :owner_id => nil, :who => "My father", :text => "some text")}
	  
	  it "displays who and text" do
	    quote.formatted.should == 'My father said: some text'
	  end
	  
	  it "displays context if present" do
	    quote.context = 'in the car'
	    quote.formatted.should == 'My father said: some text -- in the car'
	  end
  end
  
  describe '#formatted_previously_changed?' do
		let(:quote) {FactoryGirl.create(:quote)}

    it "false if no formatted fields change" do
      quote.update_attribute(:flag_count, 42)
      quote.formatted_previously_changed?.should be_false
    end
    
    it "true for who" do
      quote.update_attribute(:who, 'new who')
      quote.formatted_previously_changed?.should be_true
    end

    it "true for text" do
      quote.update_attribute(:text, 'new text')
      quote.formatted_previously_changed?.should be_true
    end

    it "true for context" do
      quote.update_attribute(:context, 'new context')
      quote.formatted_previously_changed?.should be_true
    end
  end
  
  describe '#twitter_id' do
    it "integer version of twitter_update_id_str" do
      quote = FactoryGirl.create(:quote, :twitter_update_id_str => "123")
      quote.twitter_id.should == 123
    end
    
    it "returns nil if twitter_update_id_str absent" do
      quote = Quote.new
      quote.twitter_id.should be_nil
    end
  end
  
  describe '#has_comments?' do
    it "true" do
      quote = FactoryGirl.build(:quote, :owner_id => nil, :comments_count => 1)
      quote.should have_comments
    end
    
    it "false" do
      quote = Quote.new
      quote.should_not have_comments
    end
  end
end
