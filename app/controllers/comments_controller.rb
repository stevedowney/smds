class CommentsController < ApplicationController

	def create
		@comment = current_user.comments.create!(params.fetch(:comment))
		@comment.save
		@cwa = CommentWithActivity.for_user_and_comment(current_user, @comment)
    @new_comment = Comment.new(:quote_id => @comment.quote.id)
		@qwa = QuoteWithActivity.for(current_user, @comment.quote)
	end

	def destroy
		@comment = current_user.comments.find(params[:id])
		@comment.destroy
		@qwa = QuoteWithActivity.for(current_user, @comment.quote)
	end

end