require 'spec_helper'

describe CommentMutatorBase do
  let(:comment) { FactoryGirl.create(:comment)}
  let(:comment_by_user) { FactoryGirl.create(:comment, :author => user)}
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user)}
  let(:cm_user) { CommentMutatorBase.new(user)}
  let(:cm_admin) { CommentMutatorBase.new(admin) }
  
  describe '#find_comment' do
    it "admin" do
      cm_admin.find_comment(comment.id)
      cm_admin.comment = comment
    end
    
    it "non_admin" do
      cm_user.find_comment(comment_by_user.id)
      cm_user.comment.should == comment_by_user
    end
    
    it "error if not owner or admin" do
      expect { cm_user.find_comment(comment.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
  
end