require 'spec_helper'

describe 'QuoteActivitiesController', :js => true do
  let!(:quote) {FactoryGirl.create(:quote, :text => 'quote text')}
  # let!(:comment) {FactoryGirl.create(:comment, :quote => quote, :body => 'comment body')}

  before(:each) do
    @user = create_and_login_user
    visit '/'
    page.should have_content('quote text')
  end

  describe '#vote_up' do
    it 'votes_up' do
      page.should have_tag('span', :class => 'score', :text => "0")
      click_on quote.dom_id('vote_up')
      page.should have_tag('span', :class => 'score', :text => "1")
      QuoteActivity.find_by_quote_id(quote.id).should be_voted_up
    end
  end

  describe '#vote_down' do
    it 'votes down' do
      page.should have_tag('span', :class => 'score', :text => "0")
      click_on quote.dom_id('vote_down')
      page.should have_tag('span', :class => 'score', :text => "-1")
      QuoteActivity.find_by_quote_id(quote.id).should be_voted_down
    end
  end

  describe '#favorite' do
    it 'favorites' do
      quote.favorite_count.should == 0
      page.should_not have_tag(:a, :id => quote.dom_id('unfavorite'))
      click_on quote.dom_id('favorite')
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
      click_on quote.dom_id('unfavorite')
      page.should have_tag(:a, :id => quote.dom_id('favorite'))
      quote.reload.favorite_count.should == -1
    end
  end

  describe '#flag' do
    it 'flags' do
      quote.flag_count.should == 0
      page.should_not have_tag(:a, :id => quote.dom_id('unflag'))
      click_on quote.dom_id('flag')
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
      click_on quote.dom_id('unflag')
      page.should have_tag(:a, :id => quote.dom_id('flag'))
      quote.reload.flag_count.should == -1
    end
  end

end