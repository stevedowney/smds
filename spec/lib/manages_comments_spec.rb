# require 'spec_helper'

# describe ManagesComments do
# 	let(:user) { FactoryGirl.create(:user) }
# 	let(:comment_manager) { ManagesComments.new(user)}
# 	let(:quote) { FactoryGirl.create(:quote) }

# 	describe '#create' do
# 		let(:comment_attributes) { {:body => "body"} }

# 		it 'creates comment' do
# 			comment_manager.create(comment_attributes)
# 			Comment.find_by_body("body").should_not be nil
# 		end

# 		it 'increments comments counter' do
# 			expect {
# 				comment_manager.create(comment_attributes)
# 			}.to change{quote.comments_count}.by(1)
# 		end
# 	end

# 	describe '#update' do
# 		let(:comment) { FactoryGirl.create(:comment) }

# 		it 'updates and returns true' do
# 			comment_manager.update(comment, {:body => 'new_body'}).should be_true
# 			comment.reload.body.should == 'new_body'
# 		end

# 		it 'returns false when invalid' do
# 			comment_manager.update(comment, {:body => ''}).should be_false
# 		end
# 	end

# 	describe '#destroy' do
# 		let(:comment) { FactoryGirl.create(:comment, :quote => quote) }

# 		it 'destroys' do
# 			comment_manager.destroy(comment)
# 			Comment.exists?(comment.id).should be_false
# 		end

# 		it 'decrements comments count' do
# 			expect {
# 				comment_manager.destroy(comment)
# 			}.to change{quote.comments_count}.by(-1)
# 		end
# 	end

# end