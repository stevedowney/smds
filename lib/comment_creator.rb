class CommentCreator < CommentMutatorBase
  
  attr_accessor :comment
  
  def create(attributes)
    self.comment = user.comments.build(attributes)
    comment.comment_number = quote.comments_count + 1

    transaction do
      self.success = comment.save
      quote.increment!(:comments_count) if success?
    end
  end
  
  def cwa
    CommentWithActivity.for(user, comment)
  end
  
  def qwa
    QuoteWithActivity.for(user, quote)    
  end
  
  def new_comment
    Comment.new(:quote_id => quote.id)
  end
  
  def quote
    raise "Make sure you call #create()" if comment.blank?
    comment.quote
  end
  
end