class CreatesComments
  include ActiveRecordTransaction
  
  attr_accessor :user, :attributes, :comment
  
  def initialize(user, attributes)
    self.user = user
    self.attributes = attributes
  end
  
  def create
    self.comment = user.comments.build(attributes)
    transaction do
      comment.save
      quote.increment!(:comments_count) if comment.persisted?
    end
    comment.persisted?
  end
  
  def cwa
    CommentWithActivity.for_user_and_comment(user, comment)
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