require 'spec_helper'

describe QuotesController do
	before(:each) do
		@user = create_and_login_user
	end

	describe 'create new quote' do
		it 'success' do
			visit '/'
			click_on 'Add Quote'
			fill_in 'quote_subject_verb', :with => 'qsv'
			fill_in 'quote_text', :with => 'qt'
			click_on 'submit'
			Quote.first.text.should == 'qt'
		end
	end

	# admin only
	# describe "update quote" do
	# 	it 'success' do
	# 	  quote = FactoryGirl.create(:quote, :owner => @user)
	# 		visit '/'
	# 		click_link quote.dom_id('edit')
	# 		fill_in 'quote_text', :with => 'new qt'
	# 		click_on 'submit'
	# 		Quote.first.text.should == 'new qt'
	# 	end
	# end

	describe "delete quote", :js => false do
		it do
			# page.driver.accept_js_confirms!
		  quote = FactoryGirl.create(:quote, :owner => @user)
			visit '/'
			Quote.find_by_id(quote.id).should_not be_nil
			click_link quote.dom_id('delete')
			# puts page.driver.browser.methods.grep( /confirm/).inspect
			# page.driver.render('spec.png')
			# page.driver.browser.switch_to.confirm.accept
			Quote.find_by_id(quote.id).should be_nil
		end
	end
end