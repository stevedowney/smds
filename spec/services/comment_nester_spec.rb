require 'spec_helper'

describe CommentNester do
  
  describe '.nest' do
    let!(:quote) { FactoryGirl.create(:quote) }
    let!(:parent_comment) { FactoryGirl.create(:comment, :quote => quote) }
    let!(:child_comment) { FactoryGirl.create(:comment, :quote => quote, :parent_id => parent_comment.id) }

    it "nests" do
      cwas = CommentNester.nest(FetchesComments.new(nil, quote).newest)
      cwas.length.should == 1

      parent_cwa = cwas.first
      parent_cwa.comment.should == parent_comment
      
      parent_cwa.child_comments.length.should == 1
      parent_cwa.child_comments.first.comment.should == child_comment
    end
  end

end