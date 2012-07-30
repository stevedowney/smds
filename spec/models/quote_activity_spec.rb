require 'spec_helper'

describe QuoteActivity do

	describe '.for_user_and_quotes' do
	  it "returns activity from db" do
	    user = stub(:id => 1)
	    quotes = [stub(:id => 2)]
	    QuoteActivity.should_receive(:find_all_by_user_id_and_quote_id).with(1, [2])
	    QuoteActivity.for_user_and_quotes(user, quotes)
	  end
  end

end
 