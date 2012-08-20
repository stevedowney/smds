class CommentDestroyer < CommentMutatorBase
  
  class InvalidDestroyerError < StandardError; end
    
  def destroy(id)
    find_comment(id)
    comment.delete_content(admin_or_author)
  end

  def admin_or_author
    return 'admin' if admin?
    return 'author' if comment.authored_by?(user)
    raise InvalidDestroyerError  # shouldn't get here, ActiveRecord::RecordNotFound instead
  end
end