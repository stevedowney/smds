require 'spec_helper'

describe CommentCreator do
  let(:comment_creator) { CommentCreator.new(user) }
  let(:user) { FactoryGirl.create(:user) }
  let(:quote) { FactoryGirl.create(:quote) }

  context 'invalid' do
    it "doesn't create" do
      comment_creator.create(:quote_id => quote.id, :body => '')
      comment_creator.should_not be_success
      quote.reload.comments_count.should == 0
    end
  end

  context 'valid' do
    let(:comment) { Comment.first }

    before(:each) do
      comment_creator.create(:quote_id => quote.id, :body => 'body')
      comment_creator.should be_success
    end

    it "#create" do
      comment.body.should == 'body'
      comment.comment_number.should == 1
      quote.reload.comments_count.should == 1
    end

    it "#cwa" do
      CommentWithActivity.should_receive(:for_user_and_comment).with(user, comment)
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
end