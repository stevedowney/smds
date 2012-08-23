class QuoteCreator < QuoteMutatorBase
  
  def create(attributes)
    save_quote(attributes)
    update_twitter
  end
  
  def quick_create(text)
    attributes = QuoteParser.parse(text)
    create attributes
  end
  
  def save_quote(attributes)
    self.quote = user.quotes.build(attributes)
    self.success = quote.save
Rails.logger.debug "valid: #{quote.valid?}"
  Rails.logger.debug quote.errors.full_messages.inspect
  end
  
  def update_twitter
    if quote.persisted?
      ManagesTwitterQuotes.create(quote.id)
    end
  end

end