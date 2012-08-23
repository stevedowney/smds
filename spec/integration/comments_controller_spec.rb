require 'spec_helper'

describe CommentsController do
  let!(:quote) {FactoryGirl.create(:quote, :text => 'quote text')}
  
  context 'not logged in' do
    let(:comment) {FactoryGirl.create(:comment, :quote => quote, :body => 'comment body')}
    
    before do
      visit quote_path(quote)
      default_instance comment
    end

    it "can't create comments" do
      page.should_not have_tag(:form, :id => 'new_comment')
      page.should have_content "To add a comment of your own you must"
    end
  end
  
  context 'logged in user' do
    let!(:user) {create_and_login_user}
    let!(:comment) {FactoryGirl.create(:comment, :quote => quote, :body => 'comment body')}
    
    before do
      visit quote_path(quote)
      default_instance comment
    end

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
        click_on "Create Comment"
        page.should have_content("Comment can't be blank")
      end
    end
    
    describe 'edit, destroy' do
      it "not allowed" do
        should_not_have_edit_link
        should_not_have_delete_link
      end
    end
  end

  context 'logged in user owns comment' do
    let!(:user) {create_and_login_user}
    let!(:comment) {FactoryGirl.create(:comment, :author => user, :quote => quote, :body => 'comment body')}

    before do
      visit quote_path(quote)
      default_instance comment
    end

    describe '#destroy', :js => true do
      it "confirm" do
        click_on_delete
        click_on_confirm_ok
        wait_until { Comment.find_by_id_and_deleted(comment.id, true) }
        page.should have_tag(:div, :id => comment.dom_id)
        page.should have_content("Deleted by author")
      end
      
      it "cancel" do
        click_on_delete
        click_on_confirm_cancel
        page.should have_tag(:div, :id => comment.dom_id)
        Comment.should exist(comment.id)
      end
    end

    describe 'edit' do
      it "not allowed" do
        should_not_have_edit_link
      end
    end
  end

  context 'admin' do
    let!(:user) {create_and_login_admin_user}
    let!(:comment) {FactoryGirl.create(:comment, :quote => quote, :body => 'comment body')}

    before do
      visit quote_path(quote)
      default_instance comment
    end

    describe '#update' do
      it "can update" do
        click_on_edit
        fill_in 'comment_body', :with => "updated body"
        click_on "Update Comment"
        comment.reload.body.should == 'updated body'
      end
      
      it "failure" do
        click_on_edit
        fill_in 'comment_body', :with => ""
        click_on "Update Comment"
        page.should have_content("can't be blank")
      end
    end
    
    describe '#destroy', :js => true do
      it "can destroy" do
        click_on_delete
        click_on_confirm_ok
        wait_until { Comment.find_by_id_and_deleted(comment.id, true) }
        page.should have_tag(:div, :id => comment.dom_id)
        page.should have_content("Deleted by admin")
        Comment.should exist(comment.id)
      end
    end
  end
  
end