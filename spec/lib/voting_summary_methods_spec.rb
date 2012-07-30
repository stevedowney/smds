require 'spec_helper'

describe VotingSummaryMethods do
  
  describe '#updates_votes' do
    it "updates vote counts" do
      quote = FactoryGirl.create(:quote, :vote_up_count => 13, :vote_down_count => 4)
      quote.update_votes!(VoteDelta.new(1, -1))
      quote.reload
      quote.vote_up_count.should == 14
      quote.vote_down_count.should == 3
      quote.vote_net_count.should == 11
    end
  end
  
end