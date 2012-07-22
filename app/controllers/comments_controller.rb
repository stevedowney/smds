class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_comment_manager, :only => [:create, :update, :destroy]
  before_filter :set_quote
  before_filter :set_comment, :only => [:edit, :update, :destroy]

	def create
		if @comment_manager.create(@quote, params.fetch(:comment))
			flash[:notice] = 'Saved'
		else
			flash[:alert] = 'Problem'
		end
	  redirect_to quote_path(@quote)
	end

	def edit
	end

	def update
		if @comment_manager.update(@comment, params.fetch(:comment))
			redirect_to quote_path(@quote)
		else
			render 'edit'
		end
	end

	def destroy
		@comment_manager.destroy(@comment)
		redirect_to quote_path(@quote)
	end

	private

	def set_quote
		@quote = Quote.find(params[:quote_id])
	end

	def set_comment
		@comment = current_user.comments.find_by_quote_id!(@quote.id)
	end

	def set_comment_manager
		@comment_manager = ManagesComments.new(current_user)
	end

end