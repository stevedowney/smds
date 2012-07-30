require 'spec_helper'

describe DestroysComments do
  let(:user) {FactoryGirl.create(:user)}
  let(:quote) {FactoryGirl.create(:quote, :comments_count => 1)}
  let(:comment) {FactoryGirl.create(:comment, :author => user, :quote => quote)}
  let(:comment_destroyer) {DestroysComments.new(user, comment.id)}
  
  before { comment_destroyer.destroy }
  
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