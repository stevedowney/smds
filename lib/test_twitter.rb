class TestTwitter
  TestTweet = Struct.new(:id, :text)
  
  class << self

    def update(text, options = {})
      Rails.logger.debug "TestTweet.update(#{text.inspect})"
      raise(Twitter::Error::Forbidden, 'Status is over 140 characters.') if text.length > 140
      
      id = Time.now.usec
      TestTweet.new(id, text).tap do |tweet|
        timeline << tweet
      end
    end

    def status_destroy(tweet_id, options = {})
      tweet = timeline.detect { |t| t.id == tweet_id }
      timeline.delete(tweet) or raise(Twitter::Error::NotFound, "couldn't find Tweet w/id: #{tweet_id.inspect}")
    end
    
    def timeline
      @timeline ||= []
    end
    
    # called before/after each sped
    def reset
      timeline.clear
    end
  end
end

