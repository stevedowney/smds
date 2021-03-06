class CommentActivitiesController < ApplicationController
  before_filter :set_comment_with_activity
  before_filter :set_quote_with_activity

  def favorite
    @cwa.favorite
    update_comment_partial
  end

  def unfavorite
    @cwa.unfavorite
    update_comment_partial
  end

  # def flag
  #   @cwa.flag
  #   update_comment_partial
  # end
  # 
  # def unflag
  #   @cwa.unflag
  #   update_comment_partial
  # end

  def toggle_vote_up
    @cwa.toggle_vote_up
    update_comment_partial
  end

  def toggle_vote_down
    @cwa.toggle_vote_down
    update_comment_partial
  end

  private

  def set_comment_with_activity
    @comment = Comment.find(params[:id])
    @cwa = CommentWithActivity.for(current_user, @comment)
  end

  def set_quote_with_activity
    @quote = @comment.quote
    @qwa = QuoteWithActivity.for(current_user, @quote)
  end

  def update_comment_partial
    render 'update_comment'
  end
end
