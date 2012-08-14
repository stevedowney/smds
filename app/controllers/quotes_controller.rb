class QuotesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :show
  # before_filter :require_admin, :only => [:edit, :update]
  # before_filter :set_quote_manager, :only => [:create]

  def show
    @quote = Quote.find(params.fetch(:id))
    @cwas = FetchesComments.new(current_user, @quote).newest
    @new_comment = Comment.new(:quote_id => @quote.id)
    @qwa = QuoteWithActivity.for(current_user, @quote)
  end

  def create
    quote_manager.create(params.fetch(:new_quote))
  end

  def edit
    quote_manager.edit(params.fetch(:id))
    @quote = quote_manager.quote
  end

  def update
    quote_manager.update(params.fetch(:id), params.fetch(:edit_quote))
  end

  def destroy
    quote_manager.destroy(params.fetch(:id))
  end

  private

  def quote_manager
    @quote_manager ||= ManagesQuotes.new(current_user)
  end
  helper_method :quote_manager
end
