require 'spec_helper'

describe 'QuoteActivitiesController', :js => true do
  let!(:quote) {FactoryGirl.create(:quote, :text => 'quote text')}
  # let!(:comment) {FactoryGirl.create(:comment, :quote => quote, :body => 'comment body')}

  before(:each) do
    default_instance quote
    @user = create_and_login_user
    visit '/'
    page.should have_content('quote text')
  end

  describe '#toggle_vote_up' do
    it 'toggles vote_up' do
      page.should have_tag('div', :class => 'vote_count', :text => "0")
      click_on_toggle_vote_up
      page.should have_tag('div', :class => 'vote_count', :text => "1")
      QuoteActivity.find_by_quote_id(quote.id).should be_voted_up
    end
  end

  describe '#toggle_vote_down' do
    it 'toggles vote down' do
      page.should have_tag('div', :class => 'vote_count', :text => "0")
      click_on_toggle_vote_down
      page.should have_tag('div', :class => 'vote_count', :text => "-1")
      QuoteActivity.find_by_quote_id(quote.id).should be_voted_down
    end
  end

  describe '#favorite' do
    it 'favorites' do
      quote.favorite_count.should == 0
      page.should_not have_tag(:a, :id => quote.dom_id('unfavorite'))
      click_on_favorite
      page.should have_tag(:a, :id => quote.dom_id('unfavorite'))
      quote.reload.favorite_count.should == 1
    end
  end

  describe '#unfavorite' do
    it 'unfavorites' do
      FactoryGirl.create(:quote_activity, :user => @user, :quote => quote, :favorited => true)
      quote.favorite_count.should == 0
      visit '/'
      page.should_not have_tag(:a, :id => quote.dom_id('favorite'))
      click_on_unfavorite
      page.should have_tag(:a, :id => quote.dom_id('favorite'))
      quote.reload.favorite_count.should == -1
    end
  end

  describe '#flag' do
    it 'flags' do
      quote.flag_count.should == 0
      page.should_not have_tag(:a, :id => quote.dom_id('unflag'))
      click_on_flag
      page.should have_tag(:a, :id => quote.dom_id('unflag'))
      quote.reload.flag_count.should == 1
    end
  end

  describe '#unflag' do
    it 'unflags' do
      FactoryGirl.create(:quote_activity, :user => @user, :quote => quote, :flagged => true)
      quote.flag_count.should == 0
      visit '/'
      page.should_not have_tag(:a, :id => quote.dom_id('flag'))
      click_on_unflag
      page.should have_tag(:a, :id => quote.dom_id('flag'))
      quote.reload.flag_count.should == -1
    end
  end

end