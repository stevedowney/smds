class TestTwitter
  
  class << self

    def update(text)
      raise "Text is > 140" if text.length > 140
      id = updates.size + 1
      updates << {:id => id, :text => text}
      Struct.new(:id).new(id)
    end

    def updates
      @updates ||= []
    end
    
  end
end