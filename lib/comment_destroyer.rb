class CommentDestroyer < CommentMutatorBase
  
  def destroy(id)
    find_comment(id)
    
    transaction do
      comment.destroy
      quote.decrement!(:comments_count)
    end
  end

end