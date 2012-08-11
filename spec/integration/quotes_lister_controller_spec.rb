require 'spec_helper'

describe QuotesListerController do
	let(:user) { FactoryGirl.create(:user) }

	context 'not logged in' do
	  def should_see_comment
			page.should have_content('the text')
	  end
	  
  	let!(:quote) { FactoryGirl.create(:quote, :owner => user, :text => 'the text') }
  	
		it '#index' do
			visit '/'
			should_see_comment
		end

		it "#newest" do
		  visit '/'
		  click_link 'Newest'
		  page.should have_tag('h1', :text => 'Newest')
			should_see_comment
		end

		it "#user_submissions" do
		  visit user_submissions_path(user)
		  page.should have_tag('h1', :text => "Submissions by #{user.username}")
			should_see_comment
		end

	end

	context "logged in" do
	  let!(:logged_in_user) {create_and_login_user}

	  it "#my_submissions" do
      FactoryGirl.create(:quote, :owner => logged_in_user, :text => 'my sub')
	    visit '/my_submissions'
	    should_be_on_controller('quotes_lister', 'my_submissions')
		  page.should have_tag('h1', :text => "My Submissions")
		  page.should have_content('my sub')
	  end

	  it "#favorites" do
	    fav_quote = FactoryGirl.create(:quote, :text => 'my fav')
	    qwa = QuoteWithActivity.for(logged_in_user, fav_quote)
	    qwa.favorite
	    visit '/favorites'
	    should_be_on_controller('quotes_lister', 'favorites')
		  page.should have_tag('h1', :text => "My Favorites")
		  page.should have_content('my fav')
	  end
	end
end