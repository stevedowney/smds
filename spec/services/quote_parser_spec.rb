require 'spec_helper'

describe QuoteParser do
  let(:klass) {QuoteParser}
  
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
  
  private
  
  def check(result, who, text, context = nil)
    result.should == {
      :who => who,
      :text => text,
      :context => context
    }
  end
end