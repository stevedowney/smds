class CommentCreator < CommentMutatorBase
  
  attr_accessor :comment
  
  def create(attributes)
    self.comment = user.comments.build
    comment.quote_id = attributes.fetch(:quote_id)
    comment.body = attributes.fetch(:body)
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
    quote.comments.build #Comment.new(:quote_id => quote.id)
  end
  
  def quote
    raise "Make sure you call #create()" if comment.blank?
    comment.quote
  end
  
end