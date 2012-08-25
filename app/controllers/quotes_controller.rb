class QuotesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :show
  
  def show
    @quote = Quote.find(params.fetch(:id))
    @cwas = FetchesComments.new(current_user, @quote).newest
    @new_comment = @quote.comments.build
    @qwa = QuoteWithActivity.for(current_user, @quote)
  end

  def new
    @quote = Quote.new
  end
  
  def create
    quote_creator.create(params.fetch(:quote))
    if request.xhr?
      render 'create'
      return
    end
    
    if quote_creator.success
      redirect_to newest_path, :notice => "Created quote"
    else
      @quote = quote_creator.quote
      render 'new'
    end
  end

  def quick_create
    quote_creator.quick_create(params.fetch(:quote))
  end
  
  def edit
    quote_updater.edit(params.fetch(:id))
    @quote = quote_updater.quote
  end

  def update
    quote_updater.update(params.fetch(:id), params.fetch(:quote))
  end

  def destroy
    quote_destroyer.destroy(params.fetch(:id))
  end

  # def top_comments
  #   @quote = Quote.find(params.fetch(:id))
  #   @comments = @quote.comments.order("created_at desc").limit(10)
  # end
  
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
