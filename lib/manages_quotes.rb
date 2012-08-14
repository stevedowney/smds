class ManagesQuotes
  class NoUserError < StandardError; end
  class SuccessCalledBeforeMutatorCalledError < StandardError; end
  
  attr_accessor :user, :quote, :success, :twitter_response
  
  def initialize(user)
    self.user = user.presence or raise(NoUserError, "need a user")
  end
  
  def create(attributes)
    self.quote = user.quotes.build(attributes)
    if quote.save
      ManagesTwitterQuotes.create(quote.id)
      self.success = true
    else
      self.success = false
    end
  end
  
  def edit(quote_id)
    find_quote(quote_id)
  end
  
  def update(quote_id, attributes)
    find_quote(quote_id)
    quote.attributes = attributes
    if quote.save
      ManagesTwitterQuotes.update(quote_id) if quote.formatted_previously_changed?
      self.success = true
    else
      self.success = false
    end
  end
  
  def destroy(quote_id)
    find_quote(quote_id)
    quote.destroy
    ManagesTwitterQuotes.destroy(quote.twitter_id)
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
  
  def find_quote(quote_id)
    collection = user.admin? ? Quote : user.quotes
    self.quote = collection.find(quote_id)
  end
end