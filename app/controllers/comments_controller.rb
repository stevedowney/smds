class CommentsController < ApplicationController
  helper_method :comment_creator, :comment_destroyer

  def create
    unless comment_creator.create
      render :js => %( alert("Comment can't be blank");)
    end
  end

  def destroy
    comment_destroyer.destroy
  end

  private
  
  def comment_creator
    @comment_creator ||= CreatesComments.new(current_user, params.fetch(:comment))
  end
  
  def comment_destroyer
    @comment_destroyer ||= DestroysComments.new(current_user, params.fetch(:id))
  end
  
end