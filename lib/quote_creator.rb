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
  end
  
  def update_twitter
    if quote.persisted?
      ManagesTwitterQuotes.create(quote.id)
    end
  end

  def who_text_context_from(quote)
    parts = quote.split('said')
    who, text, context = nil, nil, nil
    if parts.size == 1
      who = "Someone"
      text = quote
    else
      who = parts[0]
      text = parts[1]
    end
    
    {
      :who => who,
      :text => text,
      :context => nil
    }
  end
end