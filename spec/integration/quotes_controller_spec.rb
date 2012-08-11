require 'spec_helper'

describe QuotesController do
  context 'admin user' do
    let!(:admin) {create_and_login_admin_user}
    
    describe 'update' do
      let!(:quote) {FactoryGirl.create(:quote)}
      before {visit '/'}
      
      it 'success' do
        click_on quote.dom_id('edit')
        fill_in 'quote_text', :with => 'new text'
        click_on 'submit'
        should_be_on_controller 'quotes_lister', 'index'
        Quote.first.text.should == 'new text'
      end
      
      it 'failure' do
        click_on quote.dom_id('edit')
        fill_in 'quote_text', :with => ''
        click_on 'submit'
        should_be_on_controller 'quotes', 'update'
        page.should have_content("can't be blank")
      end
      
    end
  end
  
  context 'non-admin user' do
    let!(:user) {create_and_login_user}

    describe 'create new quote' do
      it 'success' do
        visit '/'
        click_on 'Add Quote'
        fill_in 'quote_who', :with => 'qsv'
        fill_in 'quote_text', :with => 'qt'
        click_on 'submit'
        # should_be_on_controller 'quotes', 'index'
        Quote.first.text.should == 'qt'
      end

      it "failure" do
        visit '/'
        click_on 'Add Quote'
        click_on 'submit'
        should_be_on_controller 'quotes', 'create'
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
      let!(:quote) {FactoryGirl.create(:quote, :owner => user)}
      before {visit '/'}
      
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