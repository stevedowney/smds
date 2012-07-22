require 'spec_helper'

describe Quote do

	describe '#updates_votes' do
		it "updates vote counts" do
			quote = FactoryGirl.create(:quote, :votes_up => 13, :votes_down => 4)
			quote.update_votes!(VoteDelta.new(1, -1))
			quote.reload
			quote.votes_up.should == 14
			quote.votes_down.should == 3
			quote.votes_net.should == 11
		end

	end
end
