class CommentCreator < CommentMutatorBase
  
  class NullParentComment
    def id; nil; end
    def depth; -1; end
    def increment!(count); end
    def dom_id(*args); nil; end
    def blank?; true; end
  end
  
  attr_accessor :comment, :parent_comment
  
  def create(attributes, parent_comment_id)
    set_parent_comment(parent_comment_id)
    set_comment(attributes)
    
    transaction do
      self.success = comment.save
      if success?
        parent_comment.increment!(:child_comment_count)
        quote.increment!(:comments_count)
      end
    end
  end
  
  def cwa
    CommentWithActivity.for(user, comment)
  end
  
  def qwa
    QuoteWithActivity.for(user, quote)    
  end
  
  def new_comment
    @new_comment ||= quote.comments.build
  end
  
  def quote
    raise "Make sure you call #create()" if comment.blank?
    comment.quote
  end
  
  private
  
  def set_parent_comment(parent_comment_id)
    self.parent_comment = Comment.find_by_id(parent_comment_id) || NullParentComment.new
  end
  
  def set_comment(attributes)
    self.comment = user.comments.build
    comment.parent_id = parent_comment.id
    comment.depth = parent_comment.depth + 1
    comment.quote_id = attributes.fetch(:quote_id)
    comment.body = attributes.fetch(:body)
    comment.comment_number = quote.comments_count + 1
  end
end