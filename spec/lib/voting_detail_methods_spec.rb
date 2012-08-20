require 'spec_helper'

describe VotingDetailMethods do

  context 'no vote' do
    let(:qa) { FactoryGirl.create(:quote_activity, :quote_id => 1, :user_id => 1) }

    it '#toggle_vote_up' do
      response = qa.toggle_vote_up!
      qa.reload.should be_voted_up
      qa.should_not be_voted_down
      response.should == VoteDelta.new(1, 0)
    end

    it '#toggle_vote_down' do
      response = qa.toggle_vote_down!
      qa.reload.should_not be_voted_up
      qa.should be_voted_down
      response.should == VoteDelta.new(0, 1)
    end
  end

  context 'voted up' do
    let(:qa) { FactoryGirl.create(:quote_activity, :quote_id => 1, :user_id => 1, :voted_up => true)  }

    it '#toggle_vote_up' do
      response = qa.toggle_vote_up!
      qa.reload.should_not be_voted_up
      qa.should_not be_voted_down
      response.should == VoteDelta.new(-1, 0)
    end

    it '#toggle_vote_down' do
      response = qa.toggle_vote_down!
      qa.reload.should_not be_voted_up
      qa.should be_voted_down
      response.should == VoteDelta.new(-1, 1)
    end
  end

  context 'voted down' do
    let(:qa) { FactoryGirl.create(:quote_activity, :quote_id => 1, :user_id => 1, :voted_down => true) }

    it '#toggle_vote_up' do
      response = qa.toggle_vote_up!
      qa.reload.should be_voted_up
      qa.should_not be_voted_down
      response.should == VoteDelta.new(1, -1)
    end

    it '#toggle_vote_down' do
      response = qa.toggle_vote_down!
      qa.reload.should_not be_voted_up
      qa.should_not be_voted_down
      response.should == VoteDelta.new(0, -1)
    end
  end


end