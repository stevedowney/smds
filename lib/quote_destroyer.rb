class QuoteDestroyer < QuoteMutatorBase
  
  def destroy(quote_id)
    find_quote(quote_id)
    quote.destroy
    ManagesTwitterQuotes.destroy(quote.twitter_id)
  end

end