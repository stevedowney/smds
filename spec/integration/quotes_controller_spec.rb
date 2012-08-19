require 'spec_helper'

describe QuotesController, :js => true do
  let(:timeline) { TestTwitter.timeline }
  def tweet
    timeline.first
  end
  
  before { visit '/' }

  def verify_quick_success
    fill_in 'quote', :with => 'bob said hello'
    click_on "Quote"
    
    quote = nil
    wait_until { quote = Quote.find_by_who_and_text('bob', 'hello') }
    
    should_have_tr(quote)

    timeline.should have(1).item
    quote.twitter_id.should == tweet.id
  end
  
  def verify_create_quote_success
    click_on 'Add Quote'
    
    fill_in 'new_quote_who', :with => 'a'
    fill_in 'new_quote_text', :with => 'b'
    fill_in 'new_quote_context', :with => 'c'

    click_on 'Create Quote'

    quote = nil
    wait_until { quote = Quote.find_by_who_and_text_and_context('a', 'b', 'c') }
    
    should_have_tr(quote)

    timeline.should have(1).item
    quote.twitter_id.should == tweet.id
  end
  
  def verify_create_quote_failure
    visit '/'
    click_on 'Add Quote'
    click_on 'submit'
    page.should have_content("can't be blank")
    Quote.first.should be_nil
    timeline.should have(:no).items
  end
  
  def insert_quote(quote_owner = nil)
    quote_owner ||= FactoryGirl.create(:user)
    quote_creator = QuoteCreator.new(quote_owner)
    quote_creator.create(FactoryGirl.attributes_for(:quote))
    timeline.should have(1).item
    tweet.id.should == Quote.first.twitter_id
  end

  def verify_update_quote_success(quote_owner = nil)
    insert_quote(quote_owner)
    visit '/'
    quote = Quote.first
    original_twitter_id = quote.twitter_id

    click_on quote.dom_id('edit')
    fill_in "edit_quote_who", :with => 'new who'
    fill_in "edit_quote_text", :with => 'new text'
    fill_in "edit_quote_context", :with => 'new context'
    click_on 'Update Quote'
    
    wait_until { quote = Quote.find_by_who_and_text_and_context('new who', 'new text', 'new context') }
    page.should have_content('new who')
    
    timeline.should have(1).item
    quote.twitter_id.should == tweet.id
    quote.twitter_id.should_not == original_twitter_id
  end
  
  def verify_update_quote_failure(quote_owner = nil)
    insert_quote(quote_owner)
    visit '/'
    quote = Quote.first
    click_on quote.dom_id('edit')
    
    fill_in 'edit_quote_text', :with => ''
    click_on 'Update Quote'
    wait_until { page.has_content?("can't be blank")}
  end

  def destroy_quote_confirm(quote_owner = nil)
    insert_quote(quote_owner)
    visit '/'
    quote = Quote.first
    default_instance quote
    
    click_on_delete
    click_on_confirm_ok
    
    wait_until { Quote.find_by_id(quote.id).nil? }
    should_not_have_tr
    timeline.should have(:no).items
  end
  
  def destroy_quote_cancel(quote_owner = nil)
    insert_quote(quote_owner)
    visit '/'
    quote = Quote.first
    default_instance quote
    
    click_on_delete
    click_on_confirm_cancel
    
    Quote.should exist(quote.id)
    should_have_tr
    timeline.should have(1).item
    tweet.id.should == quote.reload.twitter_id
  end

  context 'admin user' do
    let!(:admin) {create_and_login_admin_user}
    
    describe '#quick_create' do
      it "success" do
        verify_quick_success
      end
    end
    
    describe '#create' do
      it "success" do
        # verify_create_quote_success
      end
      
      it "failure" do
        verify_create_quote_failure
      end
    end
    
    describe '#update' do
      it 'success' do
        verify_update_quote_success
      end
      
      it 'failure' do
        verify_update_quote_failure
      end
    end

    describe '#destroy' do
      it "confirmed" do
        destroy_quote_confirm
      end
      
      it "canceled" do
        destroy_quote_cancel
      end
    end
  end
  
  context 'non-admin user' do
    let!(:user) {create_and_login_user}

    describe 'create' do
      it "success" do
        verify_create_quote_success
      end
      
      it "failure" do
        verify_create_quote_failure
      end
    end
    
    describe "update" do
      it 'success' do
        verify_update_quote_success(user)
      end

      it "failure" do
        verify_update_quote_failure(user)
      end
    end

    describe '#destroy' do
      it "confirmed" do
        destroy_quote_confirm(user)
      end
      
      it "canceled" do
        destroy_quote_cancel(user)
      end
    end

  end
  
  context 'not logged in' do
    describe '#create' do
      it "message to non-logged in user" do
        click_on 'Add Quote'
        page.should have_content("must be logged in")
      end
    end
    
    describe '#update' do
      it "no edit link" do
        insert_quote
        visit '/'
        quote = Quote.first
        should_have_tr(quote)
        should_not_have_edit_link(quote)
      end
    end
    
    describe '#destroy' do
      it "no delete link" do
        insert_quote
        visit '/'
        quote = Quote.first
        should_have_tr(quote)
        should_not_have_delete_link(quote)
      end
    end
    
  end
  
end