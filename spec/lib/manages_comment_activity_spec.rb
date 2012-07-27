# require 'spec_helper'

# describe ManagesCommentActivity do
	
# 	describe '#favorite' do

# 		it "favorites and increments favorite count" do
# 			activity = stub('activity')
# 			activity.should_receive(:favorite!).and_return(1)
# 			comment = stub
# 			comment.should_receive(:increment!).with(:favorite_count, 1)
# 			comment_manager = ManagesCommentActivity.new(stub('User'), comment, activity)
# 			comment_manager.favorite
# 		end

# 	end

# 	describe '#unfavorite' do

# 		it "unfavorites and decrements favorite count" do
# 			activity = stub('activity')
# 			activity.should_receive(:unfavorite!).and_return(-1)
# 			comment = stub
# 			comment.should_receive(:increment!).with(:favorite_count, -1)
# 			comment_manager = ManagesCommentActivity.new(stub('User'), comment, activity)
# 			comment_manager.unfavorite
# 		end

# 	end


# end