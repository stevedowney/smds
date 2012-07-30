require 'spec_helper'

describe VotingDetailMethods do
  describe '#vote_up!' do
		let(:qa) { QuoteActivity.create!(:quote_id => 1, :user_id => 1) }

		it "sets vote_up" do
			qa.vote_up!
			qa.reload.should be_voted_up
		end

		it "returns delta" do
			response = qa.vote_up!
			response.should == VoteDelta.new(1, 0)
		end
	end
end