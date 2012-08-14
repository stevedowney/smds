require 'spec_helper'

describe QuotesController do
  let(:timeline) { TestTwitter.timeline }
  let(:tweet) { timeline.first }
  
  context 'admin user' do
    let!(:admin) {create_and_login_admin_user}
    
    describe 'update', :js => true do
      let(:quote) { Quote.first }

      before(:each) do
        qm = ManagesQuotes.new(admin)
        qm.create(FactoryGirl.attributes_for(:quote))
        visit '/'
      end
      
      it 'success' do
        click_on 'Add Quote'
        click_on quote.dom_id('edit')
        fill_in "edit_quote_who", :with => 'bob'
        click_on 'Update Quote'
        wait_until { Quote.find_by_who('bob').present?}
        page.should have_content('bob said')
      end
      
      it 'failure' do
        click_on quote.dom_id('edit')
        fill_in 'edit_quote_text', :with => ''
        click_on 'submit'
        wait_until { page.has_content?("can't be blank")}
      end
      
    end
  end
  
  context 'non-admin user' do
    let!(:user) {create_and_login_user}

    describe 'create new quote', :js => true do
      it 'success' do
        visit '/'
        click_on 'Add Quote'
        fill_in 'new_quote_who', :with => 'who'
        fill_in 'new_quote_text', :with => 'what'

        click_on 'submit'

        page.should have_tag(:tr, :class => 'quote') # wait for Ajax refresh
        quote = Quote.first
        should_have_tr(quote)
        quote.text.should == 'what'
        quote.twitter_id.should == tweet.id
        timeline.should have(1).item
      end

      it "failure" do
        visit '/'
        click_on 'Add Quote'
        click_on 'submit'
        page.should have_content("can't be blank")
        Quote.first.should be_nil
      end
    end

    describe "update quote" do
      it 'does not work for non-admin' do
        quote = FactoryGirl.create(:quote, :owner => user)
        visit '/'
        page.should_not have_tag(:a, :id => quote.dom_id('edit'))
        visit edit_quote_path(quote)
        should_require_admin
      end
    end

    describe "delete quote", :js => true do
      let(:quote) { Quote.first }
      let(:admin) {create_and_login_admin_user}
      

      before(:each) do
        qm = ManagesQuotes.new(admin)
        qm.create(FactoryGirl.attributes_for(:quote))
        visit '/'
      end
      
      it 'confirmed' do
        click_link quote.dom_id('delete')
        click_on_confirm_ok
        page.should_not have_tag(:a, :id => quote.dom_id('delete'))
        Quote.should_not exist(quote.id)
      end

      it 'canceled' do
        click_link quote.dom_id('delete')
        click_on_confirm_cancel
        page.should have_tag(:a, :id => quote.dom_id('delete'))
        Quote.should exist(quote.id)
      end
    end
  end
  
end