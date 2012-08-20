require 'spec_helper'

describe CommentDestroyer do
  let(:admin_user) {FactoryGirl.create(:admin_user)}
  let(:user) {FactoryGirl.create(:user)}
  let(:quote) {FactoryGirl.create(:quote, :comments_count => 1)}
  let(:comment) {FactoryGirl.create(:comment, :author => user, :quote => quote)}

  describe '.destroy' do
    
    def check_deleted(id)
      comment = Comment.find(id)
      comment.should be_deleted
    end
  
    context 'comment owner' do
      let(:comment_destroyer) {CommentDestroyer.new(user)}
      before { comment_destroyer.destroy(comment.id) }
      
      it "destroys" do
        check_deleted(comment.id)
      end
      
      it "does not decrement comment counter on quote" do
        quote.reload.comments_count.should == 1
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
      let(:comment_destroyer) {CommentDestroyer.new(admin_user)}
      before { comment_destroyer.destroy(comment.id) }
    
      it "destroys" do
        check_deleted(comment.id)
      end
    end
  end
  
  describe '.admin_or_author' do
    
    it "author" do
      cd = CommentDestroyer.new(user)
      cd.comment = comment
      cd.admin_or_author.should == 'author'
    end
    
    it "admin" do
      cd = CommentDestroyer.new(admin_user)
      cd.comment = comment
      cd.admin_or_author.should == 'admin'
    end
    
    it "raises error if note admin or author" do
      cd = CommentDestroyer.new(stub('user', :admin? => false, :id => -1))
      cd.comment = comment
      expect { cd.admin_or_author }.to raise_error(CommentDestroyer::InvalidDestroyerError)
    end
  end
  
end