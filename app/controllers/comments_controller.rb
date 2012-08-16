class CommentsController < ApplicationController
  before_filter :require_admin, :only => [:edit, :update]
  before_filter :set_comment, :only => [:edit, :update]

  helper_method :comment_creator, :comment_destroyer
  
  def create
    unless comment_creator.create(params.fetch(:comment))
      render :js => %( tbAlert("Comment can't be blank");)
    end
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
    comment_destroyer.destroy
  end

  private
  
  def comment_creator
    @comment_creator ||= CreatesComments.new(current_user)
  end
  
  def comment_destroyer
    @comment_destroyer ||= DestroysComments.new(current_user, params.fetch(:id))
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
end