class CreatesQuotes
  include UrlHelpers
  
  attr_accessor :user, :quote
  
  def initialize(user)
    self.user = user.presence
  end
  
  def create(attributes)
    self.quote = user.quotes.build(attributes)
    if quote.save
      tweet
      true
    end
  end
  
  def tweet
    url = quote_url(quote)
    link = url
    available_for_quote = 139 - link.length
    truncated_quote = quote.formatted.truncate(available_for_quote)
    update = "#{truncated_quote} #{url}"
    Twitter.update(update)
  rescue => e
    
  end
end