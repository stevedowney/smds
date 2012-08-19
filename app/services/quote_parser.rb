class QuoteParser
  attr_accessor :string
  
  def initialize(string)
    self.string = string
  end
  
  def parse
    {
      :who => who,
      :text => text,
      :context => context,
    }
  end
  
  def who
    if parts.size == 1
      'Someone'
    else
      parts[0].strip
    end
  end
  
  def text
    t = if parts.size == 1
      parts[0]
    else
      parts[1]
    end
    
    t = t.gsub(/^[\s:]+/, '')  # remove leading space(s), colon
    t = t.sub(/^["']/, '')     # remove leading quotes
    t = t.sub(/["']$/, '')     # remove trailing quotes
  end
  
  def context
    nil
  end
  
  def parts
    @parts ||= string.split(/said/i, 2)
  end
  
  class << self
    
    def parse(text)
      new(text).parse
    end
  end
end