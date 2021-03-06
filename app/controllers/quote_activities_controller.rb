class QuoteActivitiesController < ApplicationController
  before_filter :set_qwa

  def toggle_vote_up
    @qwa.toggle_vote_up
    update_quote
  end

  def toggle_vote_down
    @qwa.toggle_vote_down
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

  # def flag
  #   @qwa.flag
  #   update_quote
  # end
  # 
  # def unflag
  #   @qwa.unflag
  #   update_quote
  # end

  private

  def set_qwa
    quote = Quote.find(params.fetch(:id))
    @qwa = QuoteWithActivity.for(current_user, quote)
  end

  def update_quote
    render 'update_quote'
  end
end
