class QuotesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :show
  before_filter :require_admin, :only => [:edit, :update]
  before_filter :set_quote, :only => [:edit, :update, :destroy]

  def show
    @quote = Quote.find(params.fetch(:id))
    @cwas = FetchesComments.new(current_user, @quote).newest
    @new_comment = Comment.new(:quote_id => @quote.id)
    @qwa = QuoteWithActivity.for(current_user, @quote)
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote_creator = CreatesQuotes.new(current_user)
    @quote_creator.create(params.fetch(:quote))
  end

  def edit
  end

  def update
    @quote.attributes = params.fetch(:quote)
    if @quote.save
      flash[:notice] = "Quote updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @quote.destroy
  end

  private

  def set_quote
    collection = admin? ? Quote : current_user.quotes
    @quote = collection.find(params[:id])
  end
end
