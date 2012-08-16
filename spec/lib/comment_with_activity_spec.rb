require 'spec_helper'

describe CommentWithActivity do
  let(:user) {stub('user')}
  let(:comment) {stub('comment')}
  let(:activity) {stub('activity')}
  let(:vote_response) {stub('vote_response')}
  let(:cwa) {CommentWithActivity.new(user, comment, activity)}
  
  it '#toggle_vote_up' do
    activity.should_receive(:toggle_vote_up!).and_return(vote_response)    
    comment.should_receive(:update_votes!).with(vote_response)
    cwa.toggle_vote_up
  end

  it '#toggle_vote_down' do
    activity.should_receive(:toggle_vote_down!).and_return(vote_response)    
    comment.should_receive(:update_votes!).with(vote_response)
    cwa.toggle_vote_down
  end

  describe '#favorite' do
    it "favorites" do
      activity.stub!(:favorited?).and_return(false)
      activity.should_receive(:update_attribute).with(:favorited, true)
      comment.should_receive(:increment!).with(:favorite_count, 1)
      cwa.favorite
    end
    
    it "does nothing if already favorited" do
      activity.stub!(:favorited?).and_return(true)
      activity.should_not_receive(:update_attribute)
      comment.should_not_receive(:decrement!)
      cwa.favorite
    end
  end
  
  describe '#unfavorite' do
    it "unfavorites" do
      activity.stub!(:favorited?).and_return(true)
      activity.should_receive(:update_attribute).with(:favorited, false)
      comment.should_receive(:decrement!).with(:favorite_count, 1)
      cwa.unfavorite
    end
    
    it "does nothing if not favorited" do
      activity.stub!(:favorited?).and_return(false)
      activity.should_not_receive(:update_attribute)
      comment.should_not_receive(:increment!)
      cwa.unfavorite
    end
  end

  describe '#flag' do
    it "flags" do
      activity.stub!(:flagged?).and_return(false)
      activity.should_receive(:update_attribute).with(:flagged, true)
      comment.should_receive(:increment!).with(:flag_count, 1)
      cwa.flag
    end
    
    it "does nothing if already flagged" do
      activity.stub!(:flagged?).and_return(true)
      activity.should_not_receive(:update_attribute)
      comment.should_not_receive(:decrement!)
      cwa.flag
    end
  end
  
  describe '#unflag' do
    it "unflags" do
      activity.stub!(:flagged?).and_return(true)
      activity.should_receive(:update_attribute).with(:flagged, false)
      comment.should_receive(:decrement!).with(:flag_count, 1)
      cwa.unflag
    end
    
    it "does nothing if not flagged" do
      activity.stub!(:flagged?).and_return(false)
      activity.should_not_receive(:update_attribute)
      comment.should_not_receive(:decrement!)
      cwa.unflag
    end
  end
  
  describe '#editable?' do
    it "true for admin" do
      user.stub!(:admin?).and_return(true)
      cwa.should be_editable
    end

    it "false for non-amin" do
      user.stub!(:admin?).and_return(false)
      cwa.should_not be_editable
    end
  end
  
  describe '#deletable?' do
    it "true if authored by user" do
      user.stub!(:admin?).and_return(false)
      comment.should_receive(:authored_by?).with(user).and_return(true)
      cwa.should be_deletable
    end
    
    it "false if not authored by user" do
      user.stub!(:admin?).and_return(false)
      comment.should_receive(:authored_by?).with(user).and_return(false)
      cwa.should_not be_deletable
    end
    
    it "true if admin user" do
      comment.should_receive(:authored_by?).with(user).and_return(false)
      user.stub!(:admin?).and_return(true)
      cwa.should be_deletable
    end
  end
  
  describe '.for' do
    let(:comment) { stub('comment') }
    
    it "user present, delegates to user" do
      activity = stub('activity')
      user = stub('user', :present? => true)
      user.should_receive(:comment_activity_for).with(comment).and_return(activity)
      CommentWithActivity.should_receive(:new).with(user, comment, activity)
      CommentWithActivity.for(user, comment)
    end
  
    it "user nil, returns new QuoteActivity" do
      new_activity = mock('new activity')
      QuoteActivity.should_receive(:new).and_return(new_activity)
      CommentWithActivity.should_receive(:new).with(nil, comment, new_activity)
      CommentWithActivity.for(nil, comment)
    end
  end
    
end