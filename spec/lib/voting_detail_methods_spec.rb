require 'spec_helper'

describe VotingDetailMethods do
  
  describe '#vote_up!' do
    it 'no votes' do
  		qa = QuoteActivity.create!(:quote_id => 1, :user_id => 1)
  		response = qa.vote_up!
  		
  		qa.reload.should be_voted_up
  		qa.should_not be_voted_down
  		response.should == VoteDelta.new(1, 0)
    end
    
    it 'down vote' do
  		qa = QuoteActivity.create!(:quote_id => 1, :user_id => 1, :voted_down => true)
  		response = qa.vote_up!
  		
  		qa.reload.should be_voted_up
  		qa.should_not be_voted_down
  		response.should == VoteDelta.new(1, -1)
    end
    
    it 'up vote' do
  		qa = QuoteActivity.create!(:quote_id => 1, :user_id => 1, :voted_up => true)
  		response = qa.vote_up!
  		
  		qa.reload.should be_voted_up
  		qa.should_not be_voted_down
  		response.should == VoteDelta.new(0, 0)
    end
	end

  describe '#vote_down!' do
    it 'no votes' do
  		qa = QuoteActivity.create!(:quote_id => 1, :user_id => 1)
  		response = qa.vote_down!
  		
  		qa.reload.should_not be_voted_up
  		qa.should be_voted_down
  		response.should == VoteDelta.new(0, 1)
    end
    
    it 'up vote' do
  		qa = QuoteActivity.create!(:quote_id => 1, :user_id => 1, :voted_up => true)
  		response = qa.vote_down!
  		
  		qa.reload.should_not be_voted_up
  		qa.should be_voted_down
  		response.should == VoteDelta.new(-1, 1)
    end
    
    it 'down vote' do
  		qa = QuoteActivity.create!(:quote_id => 1, :user_id => 1, :voted_down => true)
  		response = qa.vote_down!
  		
  		qa.reload.should_not be_voted_up
  		qa.should be_voted_down
  		response.should == VoteDelta.new(0, 0)
    end
	end
	
end