require 'spec_helper'

describe CommentsController do
  let!(:quote) {FactoryGirl.create(:quote, :text => 'quote text')}

  context 'logged in user' do
    let!(:user) {create_and_login_user}
    let!(:comment) {FactoryGirl.create(:comment, :quote => quote, :body => 'comment body')}
    before {visit quote_path(quote)}

    describe 'detail page' do
      it 'shows quote and comments' do
        page.should have_content('quote text')
        page.should have_content('comment body')
      end
    end

    describe '#create', :js => true do

      it "success" do
        fill_in 'comment_body', :with => "new comment"
        click_on 'Create Comment'
        page.should have_content('new comment')
        Comment.find_by_quote_id_and_body(quote.id, 'new comment').should_not be_nil
      end

      it "failure" do
        pending 'handle empty comment'
      end
    end
  end

  context 'own comment' do
    let!(:user) {create_and_login_user}
    let!(:comment) {FactoryGirl.create(:comment, :author => user, :quote => quote, :body => 'comment body')}
    before {visit quote_path(quote)}

    describe '#destroy', :js => true do

      it "success" do
        pending 'js confirm'
        click_on comment.dom_id('delete')
        Comment.should_not exist(comment.id)
      end

    end
  end

  context 'admin' do
    let!(:user) {create_and_login_admin_user}
    let!(:comment) {FactoryGirl.create(:comment, :quote => quote, :body => 'comment body')}
    before {visit quote_path(quote)}

    describe '#destroy', :js => true do
      it "success" do
        pending 'js confirm'
        click_on comment.dom_id('delete')
        Comment.should_not exist(comment.id)
      end
    end
  end
  
end