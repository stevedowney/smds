require 'spec_helper'

describe CommentDestroyer do
  let(:user) {FactoryGirl.create(:user)}
  let(:quote) {FactoryGirl.create(:quote, :comments_count => 1)}
  let(:comment) {FactoryGirl.create(:comment, :author => user, :quote => quote)}
  
  context 'comment owner' do
    let(:comment_destroyer) {CommentDestroyer.new(user)}
    before { comment_destroyer.destroy(comment.id) }
      
    it "destroys" do
      Comment.should_not exist(comment.id)
    end
      
    it "decrements comment counter on quote" do
      quote.reload.comments_count.should == 0
    end
      
    it "exposes qwa" do
      qwa = comment_destroyer.qwa
      qwa.quote.should == quote
      qwa.user.should == user
    end
  end
  
  context 'non-owner' do
    let(:non_owner) {FactoryGirl.create(:user)}
    
    it "comment not found" do
      comment_destroyer = CommentDestroyer.new(non_owner)
      expect{ comment_destroyer.destroy(comment.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'admin user' do
    let(:admin_user) {FactoryGirl.create(:admin_user)}
    let(:comment_destroyer) {CommentDestroyer.new(admin_user)}
    before { comment_destroyer.destroy(comment.id) }
    
    it "destroys" do
      Comment.should_not exist(comment.id)
    end
  end

end