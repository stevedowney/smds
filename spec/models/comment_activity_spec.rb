require 'spec_helper'

describe CommentActivity do

  describe '.for_user_and_comments' do
    
    it "fetches activity for user and comments" do
      user = stub(:id => 1)
      comments = [stub(:id => 2)]
      CommentActivity.should_receive(:find_all_by_user_id_and_comment_id).with(1, [2])
      CommentActivity.for_user_and_comments(user, comments)
    end
    
  end
  
end
