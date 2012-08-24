require 'spec_helper'

describe UrlValidator do
  
  it "valid" do
    quote = Quote.new(:url => 'http://example.com')
    quote.should have(:no).errors_on(:url)
  end
  
  it "ip valid" do
    quote = Quote.new(:url => 'http://1.2.3.4')
    quote.should have(:no).errors_on(:url)
  end
  
  it "blank valid" do
    quote = Quote.new(:url => '')
    quote.should have(:no).errors_on(:url)
  end

  it "invalid" do
    quote = Quote.new(:url => 'bogus')
    quote.should have(1).errors_on(:url)
  end
end