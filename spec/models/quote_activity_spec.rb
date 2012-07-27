require 'spec_helper'

describe QuoteActivity do
	describe '#vote_up!' do
		let(:uqa) { QuoteActivity.create!(:quote_id => 1, :user_id => 1) }

		it "sets vote_up" do
			uqa.vote_up!
			uqa.reload.should be_voted_up
		end

		it "returns delta" do
			response = uqa.vote_up!
			response.should == VoteDelta.new(1, 0)
		end
	end
end
 