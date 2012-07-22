require 'spec_helper'

describe QuotesListerController do
	let(:user) { FactoryGirl.create(:user) }

	context 'not logged in' do

		it '#index' do
			visit '/'
			page.should have_content('About Us')
		end

		it "#newest" do
		  visit '/'
		  click_link 'Newest'
		  page.should have_selector('h1', :text => 'Newest')
		end

		it "#user_submissions" do
		  visit user_submissions_path(user)
		  page.should have_selector('h1', :text => "Submissions by #{user.username}")
		end

	end

	context "logged in" do
	  before { @user = create_and_login_user }

	  it "#my_submissions" do
	    visit '/my_submissions'
	    should_be_on_controller('quotes_lister', 'my_submissions')
		  page.should have_selector('h1', :text => "My Submissions")
	  end

	  it "#favorites" do
	    visit '/favorites'
	    should_be_on_controller('quotes_lister', 'favorites')
		  page.should have_selector('h1', :text => "My Favorites")
	  end
	end
end