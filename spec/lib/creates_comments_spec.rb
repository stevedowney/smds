require 'spec_helper'

describe CreatesComments do

  let(:user) {FactoryGirl.create(:user)}
  let(:quote) {FactoryGirl.create(:quote)}

  context 'invalid' do
    it "#create() doesn't create" do
      cc = CreatesComments.new(user, {:quote_id => quote.id, :body => ''})
      cc.create.should be_false
      quote.reload.comments_count.should == 0
    end
  end

  context 'valid' do
    let(:cc) {CreatesComments.new(user, {:quote_id => quote.id, :body => 'body'})}

    before(:each) do
      result = cc.create
      result.should be_true
    end

    it "#create" do
      Comment.first.body.should == 'body'
      quote.reload.comments_count.should == 1
    end

    it "#cwa" do
      CommentWithActivity.should_receive(:for_user_and_comment).with(user, Comment.first)
      cc.cwa
    end

    it "#qwa" do
      QuoteWithActivity.should_receive(:for).with(user, quote)
      cc.qwa
    end

    it "#new_comment" do
      cc.new_comment.quote_id.should == quote.id
    end
  end
end