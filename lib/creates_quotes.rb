class CreatesQuotes
  class CreateNotCalledError < StandardError; end
  
  include UrlHelpers
  
  attr_accessor :user, :quote, :success, :twitter_response
  
  def initialize(user)
    self.user = user.presence
  end
  
  def create(attributes)
    self.quote = user.quotes.build(attributes)
    if quote.save
      self.success = true
      if twitter_update
        quote.update_attribute(:twitter_update_id_str, twitter_response.id.to_s)
      end
    else
      self.success = false
    end
  end
  
  def success?
    if success.nil?
      raise CreateNotCalledError
    else
      success
    end
  end
  
  def qwa
    QuoteWithActivity.for(user, quote)
  end
  
  def twitter_update
    update = twitter_format_text_and_link(quote.formatted, quote_url(quote))
    self.twitter_response = TwitterProxy.update(update)
    true
  rescue => e
    Rails.logger.error e.inspect
    false
  end
  
  def twitter_format_text_and_link(text, link)
    available_for_quote = 139 - link.length
    "#{text.truncate(available_for_quote)} #{link}"
  end
  
end