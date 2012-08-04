require 'spec_helper'

describe CommentWithActivity do
  let(:user) {stub('user')}
  let(:comment) {stub('comment')}
  let(:activity) {stub('activity')}
  let(:vote_response) {stub('vote_response')}
  let(:cwa) {CommentWithActivity.new(user, comment, activity)}
  
  it '#vote_up' do
    activity.should_receive(:vote_up!).and_return(vote_response)    
    comment.should_receive(:update_votes!).with(vote_response)
    cwa.vote_up
  end

  it '#vote_down' do
    activity.should_receive(:vote_down!).and_return(vote_response)    
    comment.should_receive(:update_votes!).with(vote_response)
    cwa.vote_down
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
  
  describe '.for_user_and_comment' do
    it "returns CommentWithActivity with correct activity" do
      activity = FactoryGirl.create(:comment_activity)
      user = activity.user
      comment = activity.comment
      cwa = CommentWithActivity.for_user_and_comment(user, comment)
      cwa.should == CommentWithActivity.new(user, comment, activity)
    end
  end
    
end