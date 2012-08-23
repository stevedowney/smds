require 'spec_helper'

describe QuoteParser do
  let(:klass) {QuoteParser}
  
  it "handles nil" do
    klass.parse(nil)
  end
  
  it 'no "said"' do
    result = klass.parse("some words")
    check result, 'Someone', 'some words'
  end
  
  it 'splits on "said"' do
    result = klass.parse("joe said something")
    check result, 'joe', 'something'
  end
  
  it 'splits on "said", case-insensitive' do
    result = klass.parse("joe SaId something")
    check result, 'joe', 'something'
  end
  
  it 'only splits on first "said"' do
    result = klass.parse("bob said jill said boo")
    check result, 'bob', 'jill said boo'
  end
  
  
  it 'removes ":" between "said" and quote' do
    result = klass.parse("bob said: something")
    check result, 'bob', 'something'

    result = klass.parse("bob said : something")
    check result, 'bob', 'something'
  end
  
  it "removes quotes around text" do
    result = klass.parse %(bob said "some words")
    check result, 'bob', 'some words'

    result = klass.parse %(bob said 'some words')
    check result, 'bob', 'some words'
  end
  
  describe '"said" must be within first 35 characters' do
    let(:star_30) { '*' * 30 }
    
    it "parses who" do
      quote = "#{star_30} said foo"
      result = klass.parse(quote)
      check result, star_30, 'foo'
    end

    it "doesn't parse who" do
      quote = "#{star_30}x said foo"
      result = klass.parse(quote)
      check result, 'Someone', quote
    end
  end
  
  private
  
  def check(result, who, text, context = nil)
    result.should == {
      :who => who,
      :text => text,
      :context => context
    }
  end
end