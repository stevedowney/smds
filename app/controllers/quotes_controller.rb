class QuotesController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  before_filter :set_quote, :only => [:edit, :update, :destroy]


  def show
    @quote = Quote.find(params.fetch(:id))
    @comments = @quote.comments # TODO: paging, filtering
    @new_comment = Comment.new(:quote_id => @quote.id)
    @qwa = QuoteWithActivity.new(current_user, @quote)
  end

  def new
    @quote = Quote.new
  end

  def create
  	@quote = current_user.quotes.build(params.fetch(:quote))
  	if @quote.save
  		flash[:notice] = "Quote saved"
      # TODO: ajax add to top of list: where to go? newest?
  		redirect_to root_path
  	else
  		render 'new'
  	end
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
    render :js => %($('##{@quote.dom_id}').remove())
  end

  private

  def set_quote
    @quote = current_user.quotes.find(params[:id])
  end
end
