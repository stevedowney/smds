class QuotesActivityController < ApplicationController
  before_filter :set_qwa

  def vote_up
    @qwa.vote_up
    update_quote
  end

  def vote_down
    @qwa.vote_down
    update_quote
  end

  def favorite
    @qwa.favorite
    update_quote
  end

  def unfavorite
    @qwa.unfavorite
    update_quote
  end

  def flag
    @qwa.flag
    update_quote
  end

  def unflag
    @qwa.unflag
    update_quote
  end

  private

  def set_qwa
    quote = Quote.find(params.fetch(:id))
    @qwa = QuoteWithActivity.for(current_user, quote)
  end

  def update_quote
    render 'update_quote'
  end
end
