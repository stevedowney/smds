class QuotesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :show
  
  def show
    @quote = Quote.find(params.fetch(:id))
    @cwas = FetchesComments.new(current_user, @quote).newest
    @new_comment = Comment.new(:quote_id => @quote.id)
    @qwa = QuoteWithActivity.for(current_user, @quote)
  end

  def new
    @quote = Quote.new(QuoteParser.parse(params.fetch(:quote)))
  end
  
  def create
    quote_creator.create(params.fetch(:new_quote))
  end

  def quick_create
    quote_creator.quick_create(params.fetch(:quote))
  end
  
  def edit
    quote_updater.edit(params.fetch(:id))
    @quote = quote_updater.quote
  end

  def update
    quote_updater.update(params.fetch(:id), params.fetch(:edit_quote))
  end

  def destroy
    quote_destroyer.destroy(params.fetch(:id))
  end

  private

  def quote_creator
    @quote_creator ||= QuoteCreator.new(current_user)
  end
  helper_method :quote_creator
  
  def quote_updater
    @quote_updater ||= QuoteUpdater.new(current_user)
  end
  helper_method :quote_updater
  
  def quote_destroyer
    @quote_destroyer ||= QuoteDestroyer.new(current_user)
  end
  helper_method :quote_destroyer
    
end
