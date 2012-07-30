require 'spec_helper'

describe User do
  let(:user) {FactoryGirl.create(:user)}
  let(:quote) {FactoryGirl.create(:quote)}
  
  describe '#quote_activity_for' do
    
    it "returns activity if found" do
      quote_activity = FactoryGirl.create(:quote_activity, :quote => quote, :user => user)
      user.quote_activity_for(quote).should == quote_activity
    end
    
    it "returns new activity if none found" do
      quote_activity = user.quote_activity_for(quote)
      quote_activity.should_not be_persisted
    end

  end
  
  describe '#comment_activity_for' do
    let(:comment) {FactoryGirl.create(:comment, :quote => quote, :author => user)}
    
    it "returns activity if found" do
      comment_activity = FactoryGirl.create(:comment_activity, :user => user, :quote => quote, :comment => comment)
      user.comment_activity_for(comment).should == comment_activity
    end
    
    it "returns new activity if none found" do
      comment_activity = user.comment_activity_for(comment)
      comment_activity.should_not be_persisted
    end
  end
  
end
