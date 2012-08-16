class CommentsController < ApplicationController
  before_filter :require_admin, :only => [:edit, :update]
  before_filter :set_comment, :only => [:edit, :update]

  helper_method :comment_creator, :comment_destroyer
  
  def create
    comment_creator.create(params.fetch(:comment))
  end

  def edit
  end
  
  def update
    @comment.attributes = params.fetch(:comment)
    if @comment.save
      flash[:notice] = "Comment updated"
      redirect_to quote_path(@comment.quote)
    else
      render 'edit'
    end
  end
  
  def destroy
    comment_destroyer.destroy(params.fetch(:id))
  end

  private
  
  def comment_creator
    @comment_creator ||= CommentCreator.new(current_user)
  end
  
  def comment_destroyer
    @comment_destroyer ||= CommentDestroyer.new(current_user)
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
end