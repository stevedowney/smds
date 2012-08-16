class QuoteMutatorBase < MutatorBase
  class NoUserError < StandardError; end
  class SuccessCalledBeforeMutatorCalledError < StandardError; end
  
  attr_accessor :quote
  
  def find_quote(quote_id)
    collection = user.admin? ? Quote : user.quotes
    self.quote = collection.find(quote_id)
  end
  
  def qwa
    QuoteWithActivity.for(user, quote)
  end
  
end

