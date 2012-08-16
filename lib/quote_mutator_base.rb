class QuoteMutatorBase
  class NoUserError < StandardError; end
  class SuccessCalledBeforeMutatorCalledError < StandardError; end
  
  attr_accessor :user, :quote, :success
  
  def initialize(user)
    self.user = user.presence or raise(NoUserError, "need a user")
  end
  
  def find_quote(quote_id)
    collection = user.admin? ? Quote : user.quotes
    self.quote = collection.find(quote_id)
  end
  
  def success?
    if success.nil?
      raise SuccessCalledBeforeMutatorCalledError
    else
      success
    end
  end
  
  def qwa
    QuoteWithActivity.for(user, quote)
  end
  
  def admin?
    user.admin?
  end
  
  def not_admin?
    !admin?
  end
end

