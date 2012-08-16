class CommentMutatorBase < MutatorBase
  
  attr_accessor :comment
  
  def find_comment(id)
    collection = user.admin? ? Comment : user.comments
    self.comment = collection.find(id)
  end
  
  def quote
    comment.quote
  end
  
  def qwa
    QuoteWithActivity.for(user, quote)
  end  
  
end