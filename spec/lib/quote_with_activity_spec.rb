require 'spec_helper'

describe QuoteWithActivity do
	let(:user) { FactoryGirl.create(:user) }
	let(:quote_owner) { FactoryGirl.create(:user) }
	let(:quote) { FactoryGirl.create(:quote, :owner => quote_owner) }
	let(:activity) { user.quote_activity_for(quote) }
	let(:vote_response) {stub('vote_response')}
	let(:qwa) {QuoteWithActivity.new(user, quote, activity)}
	let(:qwa_no_user) {QuoteWithActivity.new(nil, quote, activity)}
  

	describe '.initialize()' do

		it 'sets user' do
			qwa.user.should == user
		end

		it 'sets quote' do
			qwa.quote.should == quote
		end

		it 'sets activity' do
			qwa.activity.should == activity
		end
	end
	
	describe 'voting' do
	  it '#vote_up' do
      activity.should_receive(:toggle_vote_up!).and_return(vote_response)    
      quote.should_receive(:update_votes!).with(vote_response)
      qwa.toggle_vote_up
    end

    it '#vote_down' do
      activity.should_receive(:toggle_vote_down!).and_return(vote_response)    
      quote.should_receive(:update_votes!).with(vote_response)
      qwa.toggle_vote_down
    end
  end
  
  describe '#favorite' do
    it "favorites" do
      activity.stub!(:favorited?).and_return(false)
      activity.should_receive(:update_attribute).with(:favorited, true)
      quote.should_receive(:increment!).with(:favorite_count, 1)
      qwa.favorite
    end
    
    it "does nothing if already favorited" do
      activity.stub!(:favorited?).and_return(true)
      activity.should_not_receive(:update_attribute)
      quote.should_not_receive(:decrement!)
      qwa.favorite
    end
  end
  
  describe '#unfavorite' do
    it "unfavorites" do
      activity.stub!(:favorited?).and_return(true)
      activity.should_receive(:update_attribute).with(:favorited, false)
      quote.should_receive(:decrement!).with(:favorite_count, 1)
      qwa.unfavorite
    end
    
    it "does nothing if not favorited" do
      activity.stub!(:favorited?).and_return(false)
      activity.should_not_receive(:update_attribute)
      quote.should_not_receive(:increment!)
      qwa.unfavorite
    end
  end

  describe '#flag' do
    it "flags" do
      activity.stub!(:flagged?).and_return(false)
      activity.should_receive(:update_attribute).with(:flagged, true)
      quote.should_receive(:increment!).with(:flag_count, 1)
      qwa.flag
    end
    
    it "does nothing if already flagged" do
      activity.stub!(:flagged?).and_return(true)
      activity.should_not_receive(:update_attribute)
      quote.should_not_receive(:decrement!)
      qwa.flag
    end
  end
  
  describe '#unflag' do
    it "unflags" do
      activity.stub!(:flagged?).and_return(true)
      activity.should_receive(:update_attribute).with(:flagged, false)
      quote.should_receive(:decrement!).with(:flag_count, 1)
      qwa.unflag
    end
    
    it "does nothing if not flagged" do
      activity.stub!(:flagged?).and_return(false)
      activity.should_not_receive(:update_attribute)
      quote.should_not_receive(:decrement!)
      qwa.unflag
    end
  end
  
  describe '#destroy' do
    it "destroys" do
      qwa.stub!(:deletable?).and_return(true)
      quote.should_receive(:destroy)
      qwa.destroy
    end
    
    it "does not destroy if not deletable?" do
      qwa.stub!(:deletable?).and_return(false)
      quote.should_not_receive(:destroy)
      qwa.destroy
    end
  end
  
  describe '#owned_by_user?' do
    it "true when user owns quote" do
      qwa.user = quote_owner
      qwa.should be_owned_by_user
    end
    
    it "false when user does not own quote" do
      qwa.should_not be_owned_by_user
      
    end
  end
  
  describe '#editable?' do
    it "editable by admin" do
      user.admin = true
      qwa.should be_editable
    end
    
    it "not editable by non-admin" do
      user.admin = false
      qwa.should_not be_editable
    end
    
    it "not editable when not logged in (no user)" do
      qwa_no_user.should_not be_editable
    end
  end

  describe '#deletable?' do
    it "deletable by owner" do
      qwa.user = quote_owner
      qwa.should be_deletable
    end
    
    it "deletable by admin" do
      user.admin = true
      qwa.should be_deletable
    end
    
    it "not deletable by non-owner / non-admin" do
      user.admin = false
      qwa.should_not be_deletable
    end
    
    it "note deletable when not logged in (no user)" do
      qwa_no_user.should_not be_deletable
    end
  end
	
  describe '.for' do
    it "returns QuoteWithActivity with QuoteActivity for user" do
      qwa = QuoteWithActivity.for(user, quote)
      qwa.user.should == user
      qwa.quote.should == quote
      qwa.activity.user_id.should == user.id
    end
    
    it "returns QuoteWithActivity with QuoteActivity with no user" do
      qwa = QuoteWithActivity.for('', quote)
      qwa.user.should be_nil
      qwa.quote.should == quote
      qwa.activity.user_id.should be_nil
    end
  end
  
end