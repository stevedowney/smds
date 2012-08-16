class QuoteCreator < QuoteMutatorBase
  
  def create(attributes)
    save_quote(attributes)
    update_twitter
  end
  
  def save_quote(attributes)
    self.quote = user.quotes.build(attributes)
    self.success = quote.save
  end
  
  def update_twitter
    if quote.persisted?
      ManagesTwitterQuotes.create(quote.id)
    end
  end

end