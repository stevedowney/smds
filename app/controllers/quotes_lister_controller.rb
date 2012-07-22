class QuotesListerController < ApplicationController
  before_filter :authenticate_user!, :only => [:favorites, :my_submissions]

  def index
  	# TODO: some combination of new/highly rated
  	newest
  end

  def newest
  	@qwas = quote_fetcher.newest
    @title = 'Newest'
  	render 'index'
  end

  def favorites
    @title = 'My Favorites'
    @qwas = quote_fetcher.favorites
    render 'index'
  end

  def my_submissions
    @title = 'My Submissions'
    @qwas = quote_fetcher.quotes_submitted_by(current_user)
    render 'index'
  end

  def user_submissions
    user = User.find(params[:user_id])
    @title = "Submissions by #{user.username}"
    @qwas = quote_fetcher.quotes_submitted_by(user)
    render 'index'
  end

  private

  def quote_fetcher
  	FetchesQuotes.new(current_user)
  end

end