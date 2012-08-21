require 'spec_helper'

describe CommentCreator do
  let(:comment_creator) { CommentCreator.new(user) }
  let(:user) { FactoryGirl.create(:user) }
  let(:quote) { FactoryGirl.create(:quote) }

  context 'invalid' do
    it "doesn't create" do
      comment_creator.create({:quote_id => quote.id, :body => ''}, nil)
      comment_creator.should_not be_success
      quote.reload.comments_count.should == 0
    end
  end

  context 'valid' do
    let(:comment) { Comment.first }

    before(:each) do
      comment_creator.create({:quote_id => quote.id, :body => 'body'}, nil)
      comment_creator.should be_success
    end

    it "#create" do
      comment.body.should == 'body'
      comment.comment_number.should == 1
      comment.parent_id.should be_nil
      comment.child_comment_count.should == 0
      quote.reload.comments_count.should == 1
    end

    it "#cwa" do
      CommentWithActivity.should_receive(:for).with(user, comment)
      comment_creator.cwa
    end

    it "#qwa" do
      QuoteWithActivity.should_receive(:for).with(user, quote)
      comment_creator.qwa
    end

    it "#new_comment" do
      comment_creator.new_comment.quote_id.should == quote.id
    end
  end

  context 'nested comment' do
    let(:parent_comment) { FactoryGirl.create(:comment) }
    let(:comment) { comment_creator.comment }
    
    before(:each) do
      comment_creator.create({:quote_id => quote.id, :body => 'body'}, parent_comment.id)
      comment_creator.should be_success
    end
    
    it "sets parent_id" do
      comment.parent_id.should == parent_comment.id
    end
    
    it "increments parent comment's child cound" do
      parent_comment.reload.child_comment_count.should == 1
    end
  end
  
end