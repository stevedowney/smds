class QuoteUpdater < QuoteMutatorBase
  
  attr_accessor :has_comments
  
  def edit(quote_id)
    find_quote(quote_id)
  end
  
  def update(quote_id, attributes)
    find_quote(quote_id)
    admin_or_no_comments or return
    save_quote(attributes) or return
    update_twitter
  end
  
  def save_quote(attributes)
    quote.attributes = attributes
    self.success = quote.save
  end
  
  def update_twitter
    if quote.formatted_previously_changed?
      ManagesTwitterQuotes.update(quote.id) 
    end
  end
  
  def admin_or_no_comments
    if has_comments? && not_admin?
      self.success = false
      false
    else
      true
    end
  end
  
  def has_comments?
    quote.has_comments?
  end
end