class DestroysComments
  include ActiveRecordTransaction
  
  attr_accessor :user, :comment
  
  def initialize(user, comment_id)
    self.user = user
    self.comment = user.comments.find(comment_id)
  end
  
  def destroy
    transaction do
      comment.destroy
      quote.decrement!(:comments_count)
    end
  end

  def qwa
    QuoteWithActivity.for(user, quote)
  end
  
  def quote
    comment.quote
  end
  
end