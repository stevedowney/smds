class QuoteParser
  attr_accessor :string
  
  def initialize(string)
    self.string = string.to_s
  end
  
  def parse
    {
      :who => who,
      :text => text,
      :context => context,
    }
  end
  
  def who
    if parts.size == 0
      nil
    elsif parts.size == 1
      'Someone'
    else
      parts[0].strip
    end
  end
  
  def text
    t = if parts.size == 0
      nil
    elsif parts.size == 1
      parts[0]
    else
      parts[1]
    end.to_s
    
    t = t.gsub(/^[\s:]+/, '')  # remove leading space(s), colon
    t = t.sub(/^["']/, '')     # remove leading quotes
    t = t.sub(/["']$/, '')     # remove trailing quotes
  end
  
  def context
    nil
  end

  # parse #who' by looking for 'said' within first 35 chars
  def parts
    @parts ||= begin
      ary = string.split(/said/i, 2)
      if ary.size == 2 && ary[0].size > 31
        [string]
      else
        ary
      end
    end
  end
  
  class << self
    
    def parse(text)
      new(text).parse
    end
  end
end