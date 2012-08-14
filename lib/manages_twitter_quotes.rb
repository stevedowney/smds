class ManagesTwitterQuotes

  TWITTER = App.twitter
  
  class << self
    include UrlHelpers
    
    def create(quote_id)
      quote = Quote.find(quote_id)
      update = twitter_format_text_and_link(quote.formatted, quote_url(quote))
      twitter_response = TWITTER.update(update, :trim_user => true)
      quote.update_attribute(:twitter_update_id_str, twitter_response.id.to_s)
    rescue
    #   TODO: log error
    end
    
    def destroy(twitter_id)
      TWITTER.status_destroy(twitter_id, :trim_user => true)
    # rescue Twitter::Error::NotFound
    #   # TODO: log this condition  
    # rescue
    #   # TODO: log this condition
    end

    def update(quote_id)
      # Rails.logger.debug("Updating tweet for quote: #{quote_id}")
      quote = Quote.find(quote_id)
      destroy(quote.twitter_id)
      create(quote_id)
    # rescue
    #   TODO log error
    end
    
    def twitter_format_text_and_link(text, link)
      available_for_quote = 139 - link.length
      "#{text.truncate(available_for_quote)} #{link}"
    end
    
  end
end