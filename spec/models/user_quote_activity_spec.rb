require 'spec_helper'

describe UserQuoteActivity do
	describe '#vote_up!' do
		let(:uqa) { UserQuoteActivity.create!(:quote_id => 1, :user_id => 1) }

		it "sets vote_up" do
			uqa.vote_up!
			uqa.reload.should be_vote_up
		end

		it "returns delta" do
			response = uqa.vote_up!
			response.should == VoteDelta.new(1, 0)
		end
	end
end
 